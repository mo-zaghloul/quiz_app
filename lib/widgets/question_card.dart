import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/utils/constants.dart';
import 'package:quiz_app/widgets/option_button.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final Function(String) onOptionSelected;

  const QuestionCard({
    Key? key,
    required this.question,
    required this.onOptionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildQuestionHeader(),
              const SizedBox(height: 24),
              _buildQuestionText(),
              const SizedBox(height: 32),
              _buildOptions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          ),
          child: Text(
            'Time: ${question.timeLimit}s',
            style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionText() {
    return Text(
      question.text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildOptions() {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: question.options.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final option = question.options[index];
          return OptionButton(
            optionText: option.text,
            optionId: option.id,
            onTap: () => onOptionSelected(option.id),
          );
        },
      ),
    );
  }
}