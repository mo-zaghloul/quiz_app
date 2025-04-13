import 'package:flutter/material.dart';
import 'package:quiz_app/utils/constants.dart';

class OptionButton extends StatelessWidget {
  final String optionText;
  final String optionId;
  final VoidCallback onTap;

  const OptionButton({
    Key? key,
    required this.optionText,
    required this.optionId,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kPrimaryColor.withValues(alpha:0.1),
                shape: BoxShape.circle,
              ),
              child: Text(
                optionId.toUpperCase(),
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                optionText,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}