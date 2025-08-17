import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/plan/dto/timeline.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/widgets/custom_tab_bar.dart';
import 'package:template/common/widgets/error_dialog_utils.dart';
import 'package:template/data/models/plan/plan.model.dart';
import 'package:template/pages/create_time_line/models/create_timeline_arguments.dart';
import 'package:template/pages/trip_detail/bloc/trip_detail.bloc.dart';
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
  int _selectedTabIndex = 1;
  final List<String> _tabs = ['To-do', 'Lịch trình', 'Xem lịch', 'Túi tiền'];

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _deleteTimeline(Timeline timeline, BuildContext context) async {
    try {
      print('Deleting timeline with ID: ${timeline.id}');

      // Dispatch delete event to BLoC
      context.read<TripDetailBloc>().add(
            DeleteTimeline(timelineId: timeline.id),
          );

      // Note: Success message and refresh will be handled after delete completes
    } catch (err) {
      print('Error deleting timeline: $err');

      // Show error message
      ErrorDialogUtils.showErrorToast(
        context: context,
        message: 'Lỗi khi xóa lịch trình. Vui lòng thử lại.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<TripDetailBloc, TripDetailState>(
        listenWhen: (previous, current) {
          // Only listen when timelineStatus changes from loading to loaded/error
          return previous.timelineStatus == LoadingStatus.loading &&
              current.timelineStatus != LoadingStatus.loading;
        },
        listener: (context, state) {
          if (state.timelineStatus == LoadingStatus.loaded) {
            // Show success message - the BLoC already refreshes the timeline list automatically
            ErrorDialogUtils.showSuccessToast(
              context: context,
              message: 'Lịch trình đã được xóa thành công',
            );
          } else if (state.timelineStatus == LoadingStatus.error) {
            // Show error message for any timeline operation
            ErrorDialogUtils.showErrorToast(
              context: context,
              message: state.timelineErrorMessage ??
                  'Lỗi khi thực hiện thao tác. Vui lòng thử lại.',
            );
          }
        },
        child: BlocBuilder<TripDetailBloc, TripDetailState>(
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
      ),
      floatingActionButton: BlocBuilder<TripDetailBloc, TripDetailState>(
        builder: (context, state) {
          if (state.selectedPlan == null) return const SizedBox.shrink();

          return TripActionButtons(
            onAddPressed: () async {
              print('Navigate to create timeline');
              final tripCode = state.selectedPlan?.tripCode;
              final bloc = context.read<TripDetailBloc>();
              final result = await Navigator.of(context).pushNamed(
                AppRouters.createTimeline,
                arguments: tripCode,
              );

              // If timeline was created successfully, refresh the timeline list
              if (result == true && tripCode != null && mounted) {
                print('Timeline created successfully, refreshing list');
                bloc.add(
                  GetTimelineByTripCode(tripCode: tripCode),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildTabContent(Plan plan) {
    switch (_selectedTabIndex) {
      case 0:
        return const Center(
          child: Text('To-do tab - Đang phát triển'),
        );
      case 1:
        return BlocBuilder<TripDetailBloc, TripDetailState>(
          builder: (context, state) {
            return TimelineListWidget(
              timelines: state.timelines,
              timelineStatus: state.timelineStatus,
              timelineErrorMessage: state.timelineErrorMessage,
              onAddItem: () async {
                final tripCode = plan.tripCode;
                final bloc = context.read<TripDetailBloc>();
                final result = await Navigator.of(context).pushNamed(
                  AppRouters.createTimeline,
                  arguments: tripCode,
                );

                // If timeline was created successfully, refresh the timeline list
                if (result == true && mounted) {
                  bloc.add(
                    GetTimelineByTripCode(tripCode: tripCode),
                  );
                }
              },
              onEditTimeline: (timeline) async {
                final tripCode = plan.tripCode;
                final bloc = context.read<TripDetailBloc>();
                final result = await Navigator.of(context).pushNamed(
                  AppRouters.createTimeline,
                  arguments: CreateTimelineArguments(
                    tripCode: tripCode,
                    timelineToEdit: timeline,
                  ),
                );

                // If timeline was updated successfully, refresh the timeline list
                if (result == true && mounted) {
                  bloc.add(
                    GetTimelineByTripCode(tripCode: tripCode),
                  );
                }
              },
              onDeleteTimeline: (timeline) {
                _deleteTimeline(timeline, context);
              },
              onRefreshTimelines: () {
                final tripCode = plan.tripCode;
                if (tripCode.isNotEmpty) {
                  context.read<TripDetailBloc>().add(
                        GetTimelineByTripCode(tripCode: tripCode),
                      );
                }
              },
              onRetry: () {
                if (plan.tripCode.isNotEmpty) {
                  context.read<TripDetailBloc>().add(
                        GetTimelineByTripCode(tripCode: plan.tripCode),
                      );
                }
              },
            );
          },
        );
      case 2:
        return const Center(
          child: Text('Xem lịch tab - Đang phát triển'),
        );
      case 3:
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
