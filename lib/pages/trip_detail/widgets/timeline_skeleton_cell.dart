import 'package:flutter/material.dart';

class TimelineSkeletonCell extends StatelessWidget {
  const TimelineSkeletonCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image skeleton
          _buildSkeletonBox(60, 60),

          const SizedBox(width: 8),

          // Content skeleton
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Time skeleton
                Row(
                  children: [
                    _buildSkeletonBox(12, 12),
                    const SizedBox(width: 4),
                    _buildSkeletonLine(width: 120, height: 12),
                  ],
                ),

                const SizedBox(height: 4),

                // Title skeleton
                _buildSkeletonLine(width: double.infinity, height: 14),

                const SizedBox(height: 4),

                // Cost skeleton
                _buildSkeletonLine(width: 150, height: 10),

                const SizedBox(height: 8),

                // Buttons skeleton
                Row(
                  children: [
                    _buildSkeletonLine(width: 80, height: 20),
                    const SizedBox(width: 8),
                    _buildSkeletonLine(width: 60, height: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonBox(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [
            Color(0xFFE0E0E0),
            Color(0xFFF5F5F5),
            Color(0xFFE0E0E0),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: const _ShimmerWidget(),
    );
  }

  Widget _buildSkeletonLine({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: const LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [
            Color(0xFFE0E0E0),
            Color(0xFFF5F5F5),
            Color(0xFFE0E0E0),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: const _ShimmerWidget(),
    );
  }
}

class _ShimmerWidget extends StatefulWidget {
  const _ShimmerWidget();

  @override
  State<_ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<_ShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutSine,
    ));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value, 0),
              colors: const [
                Colors.transparent,
                Colors.white24,
                Colors.transparent,
              ],
            ),
          ),
        );
      },
    );
  }
}
