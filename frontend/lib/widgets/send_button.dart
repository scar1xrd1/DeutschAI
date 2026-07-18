import 'package:flutter/material.dart';
import 'package:frontend/theme/app_colors.dart';

class SendButton extends StatelessWidget {
  final bool enabled;
  final bool loading;

  final VoidCallback onPressed;
  final VoidCallback onLongPressed;

  const SendButton({
    super.key,
    required this.enabled,
    required this.loading,
    required this.onPressed,
    required this.onLongPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      onLongPress: onLongPressed,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        width: 32,
        height: 32,

        decoration: BoxDecoration(
          color: enabled ? AppColors.primary : AppColors.surface,

          shape: BoxShape.circle,
        ),

        child: loading
            ? const Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              )
            : const Icon(
                Icons.arrow_upward_rounded,
                size: 18,
                color: Colors.white,
              ),
      ),
    );
  }
}
