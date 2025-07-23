import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/widgets/custom_tab_bar.dart';
import 'package:template/data/models/plan/plan.model.dart';
import 'package:template/pages/trip_detail/bloc/trip_detail.bloc.dart';
import 'package:template/pages/trip_detail/widgets/time_line_cell.dart';
import 'package:template/pages/trip_detail/widgets/timeline_list_widget.dart';
import 'package:template/pages/trip_detail/widgets/trip_detail_action_button.dart';
import 'package:template/pages/trip_detail/widgets/trip_detail_header.dart';
import 'package:template/root/app_routers.dart';

class TripDetailScreen extends StatefulWidget {
  const TripDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TripDetailScreen> createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen> {
  int _selectedTabIndex = 1; // Default to "Lịch trình" tab
  final List<String> _tabs = ['To-do', 'Lịch trình', 'Xem lịch', 'Túi tiền'];

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<TripDetailBloc, TripDetailState>(
        builder: (context, state) {
          final plan = state.selectedPlan;

          if (plan == null) {
            return const Scaffold(
              body: Center(
                child: Text('Không có dữ liệu chuyến đi'),
              ),
            );
          }

          return Column(
            children: [
              // Header
              TripDetailHeader(plan: plan),

              // Tab Bar
              Container(
                color: Colors.white,
                child: CustomTabBar(
                  tabs: _tabs,
                  selectedIndex: _selectedTabIndex,
                  onTabSelected: _onTabSelected,
                ),
              ),

              // Content
              Expanded(
                child: _buildTabContent(plan),
              ),
            ],
          );
        },
      ),
      floatingActionButton: BlocBuilder<TripDetailBloc, TripDetailState>(
        builder: (context, state) {
          if (state.selectedPlan == null) return const SizedBox.shrink();

          return TripActionButtons(
            onAddPressed: () {
              print('Navigate to create timeline');
              final tripCode = state.selectedPlan?.tripCode;
              Navigator.of(context).pushNamed(
                AppRouters.createTimeline,
                arguments: tripCode,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildTabContent(Plan plan) {
    switch (_selectedTabIndex) {
      case 0: // To-do
        return const Center(
          child: Text('To-do tab - Đang phát triển'),
        );
      case 1: // Lịch trình
        return BlocBuilder<TripDetailBloc, TripDetailState>(
          builder: (context, state) {
            return TimelineListWidget(
              timelines: state.timelines,
              timelineStatus: state.timelineStatus,
              timelineErrorMessage: state.timelineErrorMessage,
              onAddItem: () {
                print('Thêm lịch trình mới từ empty state');
                final tripCode = plan.tripCode;
                Navigator.of(context).pushNamed(
                  AppRouters.createTimeline,
                  arguments: tripCode,
                );
              },
              onRetry: () {
                // Retry loading timeline if there's an error
                if (plan.tripCode.isNotEmpty) {
                  context.read<TripDetailBloc>().add(
                        GetTimelineByTripCode(tripCode: plan.tripCode!),
                      );
                }
              },
            );
          },
        );
      case 2: // Xem lịch
        return const Center(
          child: Text('Xem lịch tab - Đang phát triển'),
        );
      case 3: // Túi tiền
        return const Center(
          child: Text('Túi tiền tab - Đang phát triển'),
        );
      default:
        return const Center(
          child: Text('Không có dữ liệu'),
        );
    }
  }
}
