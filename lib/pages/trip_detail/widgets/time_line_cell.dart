import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TimelineItem {
  final String time;
  final String title;
  final String description;
  final String cost;
  final String? image;
  final bool hasMapAction;
  final bool hasDetailAction;

  TimelineItem({
    required this.time,
    required this.title,
    required this.description,
    required this.cost,
    this.image,
    this.hasMapAction = false,
    this.hasDetailAction = false,
  });
}

class TimelineCell extends StatelessWidget {
  final TimelineItem item;
  final VoidCallback? onMapTap;
  final VoidCallback? onDetailTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TimelineCell({
    Key? key,
    required this.item,
    this.onMapTap,
    this.onDetailTap,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Slidable(
        key: ValueKey(item.title + item.time),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            // Edit button
            SlidableAction(
              onPressed: (context) => onEdit?.call(),
              backgroundColor: const Color(0xFF18A558),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              // borderRadius: const BorderRadius.only(
              //   topLeft: Radius.circular(8),
              //   bottomLeft: Radius.circular(8),
              // ),
            ),
            // Delete button
            SlidableAction(
              onPressed: (context) => onDelete?.call(),
              backgroundColor: const Color(0xFFFF5775),
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: _buildTimelineContent(),
        ),
      ),
    );
  }

  Widget _buildTimelineContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: item.image != null && item.image!.startsWith('http')
                    ? Image.network(
                        item.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade300,
                            child: const Icon(
                              Icons.photo,
                              size: 28,
                              color: Colors.grey,
                            ),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.photo,
                          size: 28,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),

            const SizedBox(width: 8),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time with calendar icon
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 12,
                        color: Colors.black87,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.time,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Title
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  // // Cost
                  // if (item.cost.isNotEmpty) ...[
                  //   Text(
                  //     item.cost,
                  //     style: const TextStyle(
                  //       fontSize: 10,
                  //       color: Colors.black87,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // ],

                  if (item.hasMapAction || item.hasDetailAction) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (item.hasMapAction) ...[
                          GestureDetector(
                            onTap: onMapTap,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Xem bản đồ',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        if (item.hasDetailAction) ...[
                          GestureDetector(
                            onTap: onDetailTap,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Chi tiết',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
