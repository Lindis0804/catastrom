class ObjPagable {
  int page, size;
  List<String> sort;

  ObjPagable({
    required this.page,
    required this.size,
    required this.sort,
  });
}

class ReqParamsSearchTrip {
  String? code, startDate, endDate, userId;
  ObjPagable pagable;

  ReqParamsSearchTrip({
    required this.pagable,
  });
}
