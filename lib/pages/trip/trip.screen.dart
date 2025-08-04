import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/widgets/custom_search_bar.dart';
import 'package:template/common/widgets/custom_tab_bar.dart';
import 'package:template/data/models/plan/plan.model.dart';
import 'package:template/pages/trip/bloc/trip.bloc.dart';
import 'package:template/pages/trip_detail/bloc/trip_detail.bloc.dart';
import 'package:template/pages/trip/widgets/trip_cell.dart';
import 'package:template/pages/trip/widgets/trip_header.dart';
import 'package:template/root/app_routers.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TripBloc()),
        BlocProvider(create: (context) => TripDetailBloc()),
      ],
      child: const _TripScreenContent(),
    );
  }
}

class _TripScreenContent extends StatefulWidget {
  const _TripScreenContent();

  @override
  State<_TripScreenContent> createState() => _TripScreenContentState();
}

class _TripScreenContentState extends State<_TripScreenContent> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['Đã đi', 'Đang đi', 'Sẽ đi'];

  void _onSearch(String query) {
    print('Tìm kiếm: $query');
    // Xử lý tìm kiếm
  }

  void _onAddTrip() async {
    print('Thêm chuyến đi mới');
    // Navigate to new plan creation screen
    final result = await Navigator.of(context).pushNamed(AppRouters.newPlan);

    // If a plan was created successfully, you might want to refresh the trips list
    if (result != null) {
      print('Plan created successfully, refreshing trips...');
      context.read<TripBloc>().add(const GetMyPlansEvent());
    }
  }

  void _onTabSelected(int index) {
    print('TripScreen: Tab selected - index: $index, tab: ${_tabs[index]}');
    setState(() {
      _selectedTabIndex = index;
    });
    // Có thể gọi API khác nhau cho từng tab
    print('TripScreen: Dispatching GetMyPlansEvent...');
    context.read<TripBloc>().add(const GetMyPlansEvent());
    print('TripScreen: GetMyPlansEvent dispatched');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Bar
              CustomSearchBar(
                onSearch: _onSearch,
                hintText: 'Tìm kiếm',
              ),

              const SizedBox(height: 24),

              // Header
              TripHeader(
                title: 'Lịch trình của tôi',
                onAddPressed: _onAddTrip,
              ),

              const SizedBox(height: 24),

              // Tab Bar
              CustomTabBar(
                tabs: _tabs,
                selectedIndex: _selectedTabIndex,
                onTabSelected: _onTabSelected,
              ),

              const SizedBox(height: 20),

              // Content Area with BlocBuilder
              Expanded(
                child: BlocBuilder<TripBloc, TripState>(
                  builder: (context, state) {
                    return _buildTabContent(state.myPlans ?? []);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(List<Plan> plans) {
    // Kiểm tra loading state từ BLoC
    return BlocBuilder<TripBloc, TripState>(
      builder: (context, state) {
        switch (state.getMyPlansStatus) {
          case LoadingStatus.loading:
            return _buildLoadingContent();
          case LoadingStatus.error:
            return _buildErrorContent(state.getMyPlansErrMsg);
          case LoadingStatus.loaded:
            return _buildLoadedContent(plans);
          default:
            return _buildLoadingContent();
        }
      },
    );
  }

  Widget _buildLoadingContent() {
    return ListView.builder(
      itemCount: 3, // Hiển thị 3 skeleton items
      itemBuilder: (context, index) => const TripCell(
        thumbnail: '',
        tripName: '',
        location: '',
        time: '',
        isLoading: true,
      ),
    );
  }

  Widget _buildErrorContent(String? errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            errorMessage ?? 'Có lỗi xảy ra',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<TripBloc>().add(const GetMyPlansEvent());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.primary,
            ),
            child: const Text(
              'Thử lại',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedContent(List<Plan> plans) {
    if (plans.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'Chưa có chuyến đi nào',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    // Lọc plans theo tab đã chọn
    final filteredPlans = _filterPlansByTab(plans);

    return ListView.builder(
      itemCount: filteredPlans.length,
      itemBuilder: (context, index) {
        final plan = filteredPlans[index];
        return TripCell(
          thumbnail: plan.imageUrl,
          tripName: plan.name ?? plan.tripIntent,
          location: plan.mainLocations.isNotEmpty
              ? plan.mainLocations.join(', ')
              : 'Chưa có địa điểm',
          time: _formatDateRange(plan.startTime, plan.endTime),
          isLoading: false,
          onTap: () {
            print('Tap vào plan: ${plan.name ?? plan.tripIntent}');
            // Set selected plan in trip detail bloc and navigate
            final tripDetailBloc = context.read<TripDetailBloc>();
            tripDetailBloc.add(SetSelectedPlan(plan: plan));

            // Get timeline for this trip code
            if (plan.tripCode != null && plan.tripCode!.isNotEmpty) {
              tripDetailBloc
                  .add(GetTimelineByTripCode(tripCode: plan.tripCode!));
            }

            Navigator.of(context).pushNamed(
              AppRouters.tripDetail,
              arguments: tripDetailBloc,
            );
          },
        );
      },
    );
  }

  String _formatDateRange(DateTime startTime, DateTime endTime) {
    final days = endTime.difference(startTime).inDays + 1;
    return '$days ngày';
  }

  List<Plan> _filterPlansByTab(List<Plan> plans) {
    // Lọc plans dựa trên tab đã chọn và thời gian
    final now = DateTime.now();

    switch (_selectedTabIndex) {
      case 0: // Đã đi
        return plans.where((plan) => plan.endTime.isBefore(now)).toList();
      case 1: // Đang đi
        return plans
            .where((plan) =>
                plan.startTime.isBefore(now) && plan.endTime.isAfter(now))
            .toList();
      case 2: // Sẽ đi
        return plans.where((plan) => plan.startTime.isAfter(now)).toList();
      default:
        return plans;
    }
  }
}
