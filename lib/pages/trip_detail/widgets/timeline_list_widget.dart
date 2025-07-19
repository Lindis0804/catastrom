import 'package:flutter/material.dart';
import 'package:template/common/widgets/custom_empty_list.dart';
import 'package:template/api/plan/dto/Timeline.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/pages/trip_detail/widgets/time_line_cell.dart';
import 'package:template/pages/trip_detail/widgets/timeline_skeleton_cell.dart';
import 'package:template/data/mocks/timeline_mock.dart'; // TODO: REMOVE when API is working

class TimelineListWidget extends StatelessWidget {
  final List<Timeline>? timelines;
  final LoadingStatus timelineStatus;
  final String? timelineErrorMessage;
  final VoidCallback? onAddItem;
  final VoidCallback? onRetry;

  const TimelineListWidget({
    Key? key,
    this.timelines,
    required this.timelineStatus,
    this.timelineErrorMessage,
    this.onAddItem,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (timelineStatus) {
      case LoadingStatus.loading:
        return _buildSkeletonLoading();

      case LoadingStatus.error:
        // TODO: REMOVE this when API is working - Using mock data for demo
        if (TimelineMockData.ENABLE_MOCK) {
          return Column(
            children: [
              // Mock data notification banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  border: Border.all(color: Colors.orange.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.orange.shade600,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'DEMO MODE: Đang hiển thị dữ liệu mẫu do API lỗi, vui lòng test UI với dữ liệu thật khi API hoạt động trở lại.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Mock timeline list
              Expanded(
                child: _buildTimelineList(context, TimelineMockData.getMockTimelines()),
              ),
            ],
          );
        }

        return CustomEmptyList(
          icon: Icons.error_outline,
          title: 'Lỗi tải lịch trình',
          subtitle: timelineErrorMessage ?? 'Có lỗi xảy ra khi tải lịch trình',
          buttonText: 'Thử lại',
          onButtonPressed: onRetry,
        );

      case LoadingStatus.loaded:
        if (timelines == null || timelines!.isEmpty) {
          return CustomEmptyList(
            icon: Icons.schedule_outlined,
            title: 'Chưa có lịch trình',
            subtitle: 'Thêm địa điểm và hoạt động để tạo lịch trình cho chuyến đi của bạn',
            buttonText: 'Thêm lịch trình',
            onButtonPressed: onAddItem,
          );
        }

        return _buildTimelineList(context, timelines!);

      default:
        return _buildSkeletonLoading();
    }
  }

  Widget _buildSkeletonLoading() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: List.generate(
        5, // Hiển thị 5 skeleton items
        (index) => const TimelineSkeletonCell(),
      ),
    );
  }

  Widget _buildTimelineList(BuildContext context, List<Timeline> timelineList) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: timelineList.map((timeline) {
        return TimelineCell(
          item: _convertTimelineToTimelineItem(timeline),
          onMapTap: () {
            print('Xem bản đồ: ${timeline.locationCode}');
          },
          onDetailTap: () {
            print('Chi tiết: ${timeline.activityCode}');
          },
          onEdit: () {
            print('Sửa timeline: ${timeline.id}');
            // TODO: Navigate to edit timeline screen
          },
          onDelete: () {
            print('Xóa timeline: ${timeline.id}');
            _showDeleteConfirmation(context, timeline);
          },
        );
      }).toList(),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Timeline timeline) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Xác nhận xóa',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bạn có chắc chắn muốn xóa lịch trình này không?',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_getLocationDisplayName(timeline.locationCode)} - ${_getActivityDisplayName(timeline.activityCode)}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_formatTime(timeline.startTime)} - ${_formatTime(timeline.endTime)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Hành động này không thể hoàn tác.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(
                'Hủy',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
                _deleteTimeline(timeline);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5775),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Xóa',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteTimeline(Timeline timeline) {
    print('Deleting timeline with ID: ${timeline.id}');
    // TODO: Implement actual delete API call
    // Example:
    // 1. Call delete API with timeline ID
    // 2. Show loading indicator
    // 3. Refresh timeline list on success
    // 4. Show error message on failure
  }

  // Convert Timeline DTO to TimelineItem for compatibility with TimelineCell
  TimelineItem _convertTimelineToTimelineItem(Timeline timeline) {
    return TimelineItem(
      title: '${_getLocationDisplayName(timeline.locationCode)} - ${_getActivityDisplayName(timeline.activityCode)}',
      time: '${_formatTime(timeline.startTime)} - ${_formatTime(timeline.endTime)}',
      description: _getActivityDescription(timeline.activityCode, timeline.subTimeLine.length),
      cost: _getEstimatedCost(timeline.activityCode),
      hasMapAction: true,
      hasDetailAction: timeline.subTimeLine.isNotEmpty,
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}, ${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String _getLocationDisplayName(String locationCode) {
    // Convert location codes to display names
    switch (locationCode) {
      case 'HN001':
      case 'NOI_BAI':
        return 'Nội Bài, Hà Nội';
      case 'DA_NANG':
        return 'Đà Nẵng';
      case 'HOI_AN':
        return 'Hội An';
      case 'DA_NANG_BEACH':
        return 'Bãi biển Đà Nẵng';
      case 'BA_NA_HILLS':
        return 'Bà Nà Hills';
      case 'CITY_CENTER':
        return 'Trung tâm thành phố';
      case 'OLD_QUARTER':
        return 'Phố cổ Hội An';
      case 'JAPANESE_BRIDGE':
        return 'Chùa Cầu';
      case 'NIGHT_MARKET':
        return 'Chợ đêm';
      case 'SEAFOOD_RESTAURANT':
        return 'Nhà hàng hải sản';
      case 'CABLE_CAR':
        return 'Cáp treo';
      case 'GOLDEN_BRIDGE':
        return 'Cầu Vàng';
      case 'FRENCH_VILLAGE':
        return 'Làng Pháp';
      case 'FANTASY_PARK':
        return 'Công viên Fantasy';
      default:
        return locationCode;
    }
  }

  String _getActivityDisplayName(String activityCode) {
    switch (activityCode) {
      case 'FLIGHT':
        return 'Bay';
      case 'HOTEL':
        return 'Khách sạn';
      case 'SIGHTSEEING':
        return 'Tham quan';
      case 'DINING':
        return 'Ăn uống';
      case 'ADVENTURE':
        return 'Phiêu lưu';
      case 'CHECK_IN':
        return 'Check-in';
      case 'BOARDING':
        return 'Lên máy bay';
      case 'WALKING_TOUR':
        return 'Đi bộ tham quan';
      case 'PHOTO_TAKING':
        return 'Chụp ảnh';
      case 'SHOPPING':
        return 'Mua sắm';
      case 'DINNER':
        return 'Ăn tối';
      case 'TRANSPORTATION':
        return 'Di chuyển';
      case 'LUNCH':
        return 'Ăn trưa';
      case 'GAMES':
        return 'Trò chơi';
      default:
        return activityCode;
    }
  }

  String _getActivityDescription(String activityCode, int subTimelineCount) {
    String baseDescription = _getActivityDisplayName(activityCode);
    if (subTimelineCount > 0) {
      baseDescription += ' ($subTimelineCount hoạt động)';
    }
    return baseDescription;
  }

  String _getEstimatedCost(String activityCode) {
    switch (activityCode) {
      case 'FLIGHT':
        return '1.500.000 - 3.000.000 VND';
      case 'HOTEL':
        return '800.000 - 1.500.000 VND';
      case 'SIGHTSEEING':
        return '200.000 - 500.000 VND';
      case 'DINING':
        return '300.000 - 800.000 VND';
      case 'ADVENTURE':
        return '500.000 - 1.200.000 VND';
      default:
        return '100.000 - 500.000 VND';
    }
  }
}
