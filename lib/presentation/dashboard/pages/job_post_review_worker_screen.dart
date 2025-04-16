import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_back_button.dart'
    show CustomBackButton;
import 'package:instrabaho_app/presentation/common/widgets/custom_text.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_text_field.dart';

class JobPostReviewWorkerScreen extends StatefulWidget {
  const JobPostReviewWorkerScreen({super.key});

  @override
  State<JobPostReviewWorkerScreen> createState() =>
      _JobPostReviewWorkerScreenState();
}

class _JobPostReviewWorkerScreenState extends State<JobPostReviewWorkerScreen> {
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText.appBar(context, "Review Worker"),
        leading: CustomBackButton(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('How was your experience?',
                style: context.textTheme.titleLarge),
            Gap(8),
            Text('Please rate and review your worker',
                style: context.textTheme.bodyMedium),
            Gap(24),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: index < _rating ? Colors.amber : Colors.grey,
                      size: 40,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                  );
                }),
              ),
            ),
            Gap(24),
            Text('Write a review', style: context.textTheme.titleMedium),
            Gap(8),
            InstrabahoTextField(
              controller: _reviewController,
              hintText: 'Share your experience with this worker...',
              maxLines: 5,
            ),
            Gap(24),
            InstrabahoButton(
              label: 'Submit Review',
              onTap: () {
                if (_rating == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please provide a rating')),
                  );
                  return;
                }
                // TODO: Submit review to backend
                context.goNamed(RouterNames.home);
              },
            ),
            Gap(8),
            InstrabahoButton(
              label: 'Skip',
              outline: true,
              onTap: () => context.goNamed(RouterNames.home),
            ),
          ],
        ),
      ),
    );
  }
}
