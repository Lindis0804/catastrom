import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:template/common/utils/dio.utils.dart';
import 'package:template/common/utils/env.dart';
import 'package:template/data/models/payment/category.model.dart';
import 'package:template/data/models/payment/monthly_total.model.dart';
import 'package:template/data/models/payment/spending_by_category_summary.model.dart';
import 'package:template/data/models/payment/total_by_date.model.dart';
import 'package:template/data/models/payment/transaction.model.dart';

class PaymentApiProvider {
  String accessToken;
  late Dio dio;

  PaymentApiProvider({required this.accessToken}) {
    dio = DioUtils.getDioClient(accessToken: accessToken);
  }

  Future<List<Transaction>> getTransactions({
    required DateTime dateFrom,
    required DateTime dateTo,
    List<int>? categoryIds,
    int pageIdx = 0,
    int limit = 20,
  }) async {
    Response res = await dio.get(
      '${EnvVariable.clientCustomerHost}/doc',
      queryParameters: {
        'date_from': DateFormat('dd/MM/yyyy').format(dateFrom),
        'date_to': DateFormat('dd/MM/yyyy').format(dateTo),
        'pageIdx': pageIdx,
        'limit': limit,
        if (categoryIds != null && categoryIds.isNotEmpty)
          'category': categoryIds.join(','),
      },
    );
    dynamic resData = res.data;
    if (resData['status'] != 200) {
      throw Exception('Get transactions fail: ${resData['error']}');
    }
    List<dynamic> rawTransactionsData = resData['data'];
    return rawTransactionsData
        .map(
            (dynamic rawTransaction) => Transaction.fromDynamic(rawTransaction))
        .toList();
  }

  Future<List<Category>> getCategories({String? key}) async {
    String url = '${EnvVariable.clientCustomerHost}/category/get-all';
    Response res = await dio.get(
      url,
      queryParameters: {
        if (key != null && key.isNotEmpty) 'key': key,
      },
    );
    dynamic resData = res.data;
    if (resData['status'] != 200) {
      throw Exception('Get categories fail: ${resData['error']}');
    }
    List<dynamic> rawCategoriesData = resData['data'];
    return rawCategoriesData
        .map((dynamic rawCategory) => Category.fromDynamic(rawCategory))
        .toList();
  }

  Future<List<Transaction>> insertTransactions(
      List<Transaction> transactions) async {
    Response res = await dio.post(
      '${EnvVariable.clientCustomerHost}/doc/insert',
      data: transactions.map((t) => t.toInsertJson()).toList(),
    );
    dynamic resData = res.data;
    if (resData['status'] != 200) {
      throw Exception(resData['error'] ?? 'Insert transaction failed');
    }
    List<dynamic> rawTransactionsData = resData['data'];
    return rawTransactionsData
        .map(
            (dynamic rawTransaction) => Transaction.fromDynamic(rawTransaction))
        .toList();
  }

  Future<void> deleteTransaction(int docId) async {
    Response res = await dio.delete(
      '${EnvVariable.clientCustomerHost}/doc',
      data: {'doc_id': docId},
    );
    dynamic resData = res.data;
    if (resData['status'] != 200) {
      throw Exception(resData['error'] ?? 'Delete transaction failed');
    }
  }

  Future<List<MonthlyTotal>> getTotalByMonth({
    required DateTime from,
    required DateTime to,
    required String order,
  }) async {
    Response res = await dio.get(
      '${EnvVariable.clientCustomerHost}/doc/total-by-month',
      queryParameters: {
        'from': DateFormat('MM/yyyy').format(from),
        'to': DateFormat('MM/yyyy').format(to),
        'saveAmount': false,
        'order': order,
      },
    );
    dynamic resData = res.data;
    if (resData['status'] != 200) {
      throw Exception('Get total by month fail: ${resData['error']}');
    }
    List<dynamic> rawMonthlyTotalsData = resData['data'];
    return rawMonthlyTotalsData
        .map((dynamic rawMonthlyTotal) =>
            MonthlyTotal.fromDynamic(rawMonthlyTotal))
        .toList();
  }

  Future<SpendingByCategorySummary> getTotalByCategory({
    required DateTime dateFrom,
    required DateTime dateTo,
    String orderType = 'amount',
    String orderValue = 'DESC',
  }) async {
    Response res = await dio.get(
      '${EnvVariable.clientCustomerHost}/doc/total-by-category',
      queryParameters: {
        'dateFrom': DateFormat('dd/MM/yyyy').format(dateFrom),
        'dateTo': DateFormat('dd/MM/yyyy').format(dateTo),
        'orderType': orderType,
        'orderValue': orderValue,
      },
    );
    dynamic resData = res.data;
    if (resData['status'] != 200) {
      throw Exception('Get total by category fail: ${resData['error']}');
    }
    return SpendingByCategorySummary.fromDynamic(resData['data']);
  }

  Future<List<TotalByDate>> getTotalByDate({
    required DateTime dateFrom,
    required DateTime dateTo,
    String orderValue = 'ASC',
  }) async {
    Response res = await dio.get(
      '${EnvVariable.clientCustomerHost}/doc/total-by-date',
      queryParameters: {
        'dateFrom': DateFormat('dd/MM/yyyy').format(dateFrom),
        'dateTo': DateFormat('dd/MM/yyyy').format(dateTo),
        'orderValue': orderValue,
      },
    );
    dynamic resData = res.data;
    if (resData['status'] != 200) {
      throw Exception('Get total by date fail: ${resData['error']}');
    }
    List<dynamic> rawTotalsData = resData['data'];
    return rawTotalsData
        .map((dynamic rawTotal) => TotalByDate.fromDynamic(rawTotal))
        .toList();
  }
}
