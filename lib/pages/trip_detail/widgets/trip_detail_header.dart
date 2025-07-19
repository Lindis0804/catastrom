import 'package:flutter/material.dart';
import 'package:template/data/models/plan/plan.model.dart';
import 'package:intl/intl.dart';

class TripDetailHeader extends StatelessWidget {
  final Plan plan;
  final VoidCallback? onBackPressed;

  const TripDetailHeader({
    Key? key,
    required this.plan,
    this.onBackPressed,
  }) : super(key: key);

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF116530),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button và title
            Row(
              children: [
                GestureDetector(
                  onTap: onBackPressed ?? () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    plan.name ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // const SizedBox(height: 16),

            // Ngày tháng
            Text(
              '${_formatDate(plan.startTime)} - ${_formatDate(plan.endTime)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 16),

            // Thông tin ngân sách và thành viên
            // Row(
            //   children: [
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             'Ngân sách: ${plan.budget}',
            //             style: const TextStyle(
            //               color: Colors.white,
            //               fontSize: 14,
            //             ),
            //           ),
            //           const SizedBox(height: 4),
            //           Text(
            //             'Sức khỏe tài chính: ${plan.actualCost}',
            //             style: const TextStyle(
            //               color: Colors.white,
            //               fontSize: 14,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.end,
            //       children: [
            //         Text(
            //           'Thành viên: ${plan.memberCount}',
            //           style: const TextStyle(
            //             color: Colors.white,
            //             fontSize: 14,
            //           ),
            //         ),
            //         const SizedBox(height: 4),
            //         Row(
            //           children: [
            //             Container(
            //               width: 8,
            //               height: 8,
            //               decoration: const BoxDecoration(
            //                 color: Colors.white,
            //                 shape: BoxShape.circle,
            //               ),
            //             ),
            //             const SizedBox(width: 4),
            //             Container(
            //               width: 8,
            //               height: 8,
            //               decoration: const BoxDecoration(
            //                 color: Colors.white,
            //                 shape: BoxShape.circle,
            //               ),
            //             ),
            //             const SizedBox(width: 4),
            //             Container(
            //               width: 8,
            //               height: 8,
            //               decoration: const BoxDecoration(
            //                 color: Colors.white,
            //                 shape: BoxShape.circle,
            //               ),
            //             ),
            //             const SizedBox(width: 4),
            //             const Text(
            //               '+2',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 12,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}