import 'package:flutter/material.dart';
import 'package:template/common/constants/colors.dart';

class TopNotification {
  static void show({
    required BuildContext context,
    required String message,
    required bool isSuccess,
    Duration duration = const Duration(seconds: 3),
  }) {
    OverlayState overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _TopNotificationBanner(
        message: message,
        isSuccess: isSuccess,
        duration: duration,
        onDismissed: () => entry.remove(),
      ),
    );
    overlay.insert(entry);
  }
}

class _TopNotificationBanner extends StatefulWidget {
  final String message;
  final bool isSuccess;
  final Duration duration;
  final VoidCallback onDismissed;

  const _TopNotificationBanner({
    required this.message,
    required this.isSuccess,
    required this.duration,
    required this.onDismissed,
  });

  @override
  State<_TopNotificationBanner> createState() =>
      _TopNotificationBannerState();
}

class _TopNotificationBannerState extends State<_TopNotificationBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    Future.delayed(widget.duration, () async {
      if (!mounted) return;
      await _controller.reverse();
      widget.onDismissed();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color = widget.isSuccess ? CustomColors.primary : CustomColors.error;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: SlideTransition(
          position: _offsetAnimation,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      widget.isSuccess
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: color,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
