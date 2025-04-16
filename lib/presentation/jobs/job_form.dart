import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_dropdown_textfield.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_textfield.dart';

import '../../constant/router/router_names.dart';
import '../dashboard/bloc/search_bloc.dart';
import 'args/job_form_args.dart';

class JobForm extends StatelessWidget {
  const JobForm({super.key, required this.args});

  final JobFormArgs args;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height - 200;
    return Container(
        padding: EdgeInsets.all(20),
        height: height,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Work Details", style: context.textTheme.subTitle),
              Gap(10),
              InstrabahoTextField(
                  hintText: 'Job Position',
                  controller: TextEditingController()
                    ..text = args.jobTitle ?? ''),
              Gap(10),
              InstrabahoTextField(hintText: 'Job Description', maxLines: 4),
              Gap(10),
              InstrabahoTextField(hintText: 'Street, Barangay, City'),
              Gap(10),
              InstrabahoDropdownTextField(
                  hintText: 'Payment Offer', options: ['Fixed', 'Monthly']),
              Gap(10),
              //photos of work/area
              Text("Photos of Work/Area", style: context.textTheme.subTitle),
              Gap(10),
              Container(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child:
                                Icon(Icons.add_a_photo, color: Colors.white)),
                      );
                    }),
              ),
              Spacer(),
              // book now or schedule later button
              Row(
                children: [
                  Expanded(
                      child: InstrabahoButton(
                          onTap: () {},
                          outline: true,
                          label: 'Schedule Later')),
                  Gap(10),
                  Expanded(
                      child: InstrabahoButton(
                          onTap: () async {
                            if (context.canPop()) {
                              context.pop();
                            }
                            await _searchWorker(context, args.jobTitle ?? '');

                            // BlocProvider.of<SearchBloc>(context)
                            //     .add(SearchBlocReset());
                          },
                          label: 'Book Now')),
                ],
              )
            ]));
  }

  Future<void> _searchWorker(BuildContext context, String result) async {
    BlocProvider.of<SearchBloc>(context).add(SearchBlocReset());
    context.read<SearchBloc>().add(SearchSetHint(result));
    BlocProvider.of<SearchBloc>(context).add(SearchJobFindWorker());
    context.pushNamed(RouterNames.jobMapFinder);
  }
}
