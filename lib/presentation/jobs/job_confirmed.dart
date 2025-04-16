import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/job_post_bloc.dart';

class JobConfirmedScreen extends StatelessWidget {
  const JobConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            //gif
            Image(
              image: AssetImage(Assets.gif.handShake.path),
              width: MediaQuery.of(context).size.width * 0.45,
            ),
            Gap(24),
            Text("We've got a deal", style: context.textTheme.subTitle),
            Gap(8),
            Text("Your job has been confirmed and ready to go",
                style: context.textTheme.noteStyle),
            Spacer(),
            InstrabahoButton(
                horizontalMargin: 20,
                label: 'Close',
                onTap: () {
                  GoRouter.of(context).goNamed(RouterNames.home);
                  //reset the job post state
                  BlocProvider.of<JobPostBloc>(context).add(JobPostReset());
                }),
            Gap(50)
          ],
        ),
      ),
    );
  }
}
