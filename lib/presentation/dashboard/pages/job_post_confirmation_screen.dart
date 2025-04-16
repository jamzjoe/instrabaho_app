import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/job_post_bloc.dart';

class JobPostConfirmationScreen extends StatelessWidget {
  const JobPostConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBarSize = AppBar().preferredSize.height;
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, -3), // changes position of shadow
            ),
          ],
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Base Price"), Text("P700.00")],
            ),
            Gap(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Convenience Fee"), Text("35.00")],
            ),
            Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total", style: context.textTheme.amountTextMedium),
                Text("P735.00", style: context.textTheme.amountTextMedium)
              ],
            ),
            Gap(24),
            InstrabahoButton(
                label: "Post Job",
                onTap: () {
                  BlocProvider.of<JobPostBloc>(context)
                      .add(JobPostFindRecommendedJobs());
                  GoRouter.of(context)
                      .pushNamed(RouterNames.jobPostRecommendationScreen);
                }),
          ],
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //back button
            Gap(appBarSize),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: SvgPicture.asset(Assets.svg.arrowNarrowLeft),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Review your job details?',
                      style: context.textTheme.questionText),
                  Gap(8),
                  Text(
                      'Check the details below to ensure everything is accurate.'),
                  Gap(16),
                  _RowItem(
                    icon: SvgPicture.asset(Assets.svg.searchList),
                    textValue: 'Painters',
                  ),
                  _RowItem(
                    icon: SvgPicture.asset(Assets.svg.briefcase),
                    textValue:
                        'Need a skilled wall painter to repaint the living room walls. The area is approximately 20 square meters, and I will provide the paint and brushes.',
                  ),
                  _RowItem(
                    icon: SvgPicture.asset(Assets.svg.pinLocation),
                    textValue:
                        '56-B Maginhawa Street, Teachers Village, Quezon City, Metro Manila',
                  ),
                  _RowItem(
                    icon: SvgPicture.asset(Assets.svg.cursorClock),
                    textValue: 'Book Now',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({required this.icon, required this.textValue});
  final Widget icon;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //icon

          icon,
          Gap(16),
          Flexible(
              child: Text(
            "${textValue}",
            style: context.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ))
        ],
      ),
    );
  }
}
