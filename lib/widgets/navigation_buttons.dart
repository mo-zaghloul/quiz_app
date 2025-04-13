import 'package:flutter/material.dart';
import 'package:quiz_app/utils/constants.dart';

class NavigationButtons extends StatelessWidget {
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  final VoidCallback? onSkip;
  final bool showNext;
  final bool showPrevious;
  final bool showSkip;

  const NavigationButtons({
    Key? key,
    this.onNext,
    this.onPrevious,
    this.onSkip,
    this.showNext = false,
    this.showPrevious = false,
    this.showSkip = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showPrevious)
            _buildNavigationButton(
              context,
              onPressed: onPrevious,
              icon: Icons.arrow_back,
              label: 'Previous',
              isPrimary: false,
            )
          else
            const SizedBox(width: 120),
            
          if (showSkip)
            _buildSkipButton(context)
          else
            const SizedBox.shrink(),
            
          if (showNext)
            _buildNavigationButton(
              context,
              onPressed: onNext,
              icon: Icons.arrow_forward,
              label: 'Next',
              isPrimary: true,
            )
          else
            const SizedBox(width: 120),
        ],
      ),
    );
  }

  Widget _buildNavigationButton(
    BuildContext context, {
    required VoidCallback? onPressed,
    required IconData icon,
    required String label,
    required bool isPrimary,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? kPrimaryColor : Colors.grey[200],
        foregroundColor: isPrimary ? Colors.white : Colors.black87,
        minimumSize: const Size(120, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        ),
      ),
    );
  }

  Widget _buildSkipButton(BuildContext context) {
    return TextButton(
      onPressed: onSkip,
      style: TextButton.styleFrom(
        foregroundColor: Colors.grey[600],
        minimumSize: const Size(80, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Skip'),
          SizedBox(width: 4),
          Icon(Icons.skip_next, size: 18),
        ],
      ),
    );
  }
}