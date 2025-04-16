import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_back_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/work_status_bloc.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/work_status_event.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/work_status_state.dart';
import 'package:instrabaho_app/presentation/dashboard/widgets/job_detail_row.dart';

import '../../common/widgets/custom_text.dart';

class JobStatusScreen extends StatelessWidget {
  const JobStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: ClampingScrollPhysics(),
            clipBehavior: Clip.none,
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Assets.images.bg2.path),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        children: [
                          //make custom app bar with back button
                          AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            title: CustomText.appBar(
                                context, "Track Your Worker in Real-time"),
                            leading: CustomBackButton(),
                          ),
                          Gap(80),
                          Stack(clipBehavior: Clip.none, children: [
                            Container(
                              constraints: BoxConstraints(
                                  minHeight:
                                      MediaQuery.of(context).size.height),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Gap(70),
                                  Center(
                                    child: Text("Nicolas Torre",
                                        style: context.textTheme.defaultBold),
                                  ),
                                  //rate stars yellow
                                  Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ...List.generate(5, (index) {
                                          return Icon(
                                            Icons.star,
                                            size: 8,
                                            color: Colors.orange,
                                          );
                                        }),
                                        Gap(5),
                                        Text(
                                          "5.0",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gap(20),
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 5),
                                    decoration: _boxDecor(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Worker's Progress",
                                            style: context.textTheme.noteStyle),
                                        Gap(10),
                                        Text("Worker is getting ready",
                                            style: context.textTheme.bodyLarge),
                                        Gap(10),
                                        WorkerStatusLinearIndicator(),
                                      ],
                                    ),
                                  ),
                                  Gap(20),
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: _boxDecor(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Job Details",
                                            style:
                                                context.textTheme.defaultBold),
                                        Gap(10),
                                        JobDetailRow(
                                          label: "Title",
                                          value: "Wall Repaint",
                                        ),
                                        Gap(10),
                                        JobDetailRow(
                                          label: "Description",
                                          value:
                                              "Need a skilled painter to repaint the wall",
                                        ),
                                        Gap(10),
                                        //address
                                        JobDetailRow(
                                          label: "Address",
                                          value:
                                              "123 Main St, Springfield, IL 62704",
                                        ),
                                        //urgency
                                        Gap(10),
                                        JobDetailRow(
                                          label: "Urgency",
                                          value: "Book Now",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gap(20),
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: _boxDecor(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Payment Details",
                                            style: context.textTheme.noteStyle),
                                        Gap(10),
                                        JobDetailRow(
                                          label: "Total Type",
                                          value: "Fixed Price",
                                        ),

                                        //amount on hold
                                        Gap(10),
                                        JobDetailRow(
                                          isAmount: true,
                                          label: "Amount on Hold",
                                          value: "\P100.00",
                                        ),
                                        //status
                                        Gap(10),
                                        JobDetailRow(
                                          isStatus: true,
                                          label: "Status",
                                          value: "Payment Held Securely",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gap(20),
                                  //what happens next
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('What Happens Next?',
                                            style:
                                                context.textTheme.defaultBold),
                                        //#1
                                        Gap(10),
                                        Text(
                                            '1. The worker will complete the job as scheduled.',
                                            style: context.textTheme.noteStyle),
                                        // #2
                                        Gap(10),
                                        Text(
                                            '2. Once the job is finished and approved, the payment will be released.',
                                            style: context.textTheme.noteStyle),
                                        // #3
                                        Gap(10),
                                        Text(
                                            '3. If there are any issues, our support team is here to help.',
                                            style: context.textTheme.noteStyle),
                                      ],
                                    ),
                                  ),
                                  Gap(20),
                                  //workers location button
                                  Gap(50),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: -55,
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        Assets.categories.category1.path),
                                  ),
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          Gap(50)
                        ],
                      )),
                ]),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              padding:
                  EdgeInsets.only(bottom: 30, top: 16, left: 16, right: 16),
              child: BlocBuilder<WorkStatusBloc, WorkStatusState>(
                builder: (context, state) {
                  return InstrabahoButton(
                    horizontalMargin: 20,
                    label: state.isGearComplete
                        ? 'Confirm Job Completion'
                        : state.isCarComplete && state.isQRVerified
                            ? 'Message Worker'
                            : state.isCarComplete
                                ? 'Scan QR Code'
                                : 'View Worker\'s Location',
                    onTap: () async {
                      if (state.isCarComplete &&
                          state.isQRVerified &&
                          state.isGearComplete) {
                        context.pushNamed(RouterNames.reviewRoker);
                      } else if (state.isCarComplete && state.isQRVerified) {
                        // Show "not yet implemented" message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Messaging feature coming soon!'),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: C.orange600,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (state.isCarComplete) {
                        await context.pushNamed(RouterNames.qrScanner);
                        await showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return Container(
                                padding: EdgeInsets.all(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText.title(
                                        context, "Ready to begin the job?"),
                                    Gap(10),
                                    Text(
                                        "Please confirm to officially start the job. Payment will remain on hold until completion."),
                                    Gap(10),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: InstrabahoButton(
                                            bgColor: Colors.transparent,
                                            borderColor: Colors.grey[200],
                                            outline: true,
                                            textColor: C.textColor,
                                            label: "Cancel",
                                            onTap: () {
                                              context.pop();
                                            },
                                          ),
                                        ),
                                        Gap(12),
                                        Flexible(
                                          child: InstrabahoButton(
                                            label: "Start Job",
                                            onTap: () {
                                              context
                                                  .read<WorkStatusBloc>()
                                                  .add(ScanQRVerify());
                                              context
                                                  .read<WorkStatusBloc>()
                                                  .add(StartHomeProgress());
                                              context.pop();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      } else {
                        context.pushNamed(RouterNames.workerLocation);
                      }
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration _boxDecor() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Colors.grey.withOpacity(0.2),
      ),
    );
  }
}

class WorkerStatusLinearIndicator extends StatelessWidget {
  const WorkerStatusLinearIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkStatusBloc, WorkStatusState>(
      builder: (context, state) {
        return Row(
          children: [
            //backpack icon
            Icon(
              Icons.backpack,
              size: 20,
              color: C.orange600,
            ),
            Gap(2),
            Flexible(
              child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(10),
                  value: state.backpackProgress,
                  backgroundColor: Colors.grey[200],
                  color: C.orange600,
                  minHeight: 5),
            ),
            //car icon
            Gap(2),
            Icon(
              Icons.directions_car,
              size: 20,
              color: state.isBackpackComplete ? C.orange600 : Colors.grey[200],
            ),
            Gap(2),
            Flexible(
              child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(10),
                  value: state.carProgress,
                  backgroundColor: Colors.grey[200],
                  color: C.orange600,
                  minHeight: 5),
            ),
            //home icon
            Gap(2),
            Icon(
              Icons.home,
              size: 20,
              color: state.isCarComplete ? C.orange600 : Colors.grey[200],
            ),
            Gap(2),
            Flexible(
              child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(10),
                  value: state.homeProgress,
                  backgroundColor: Colors.grey[200],
                  color: C.orange600,
                  minHeight: 5),
            ),
            //gear icon
            Gap(2),
            Icon(
              Icons.settings,
              size: 20,
              color: state.isHomeComplete ? C.orange600 : Colors.grey[200],
            ),
            Gap(2),
            Flexible(
              child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(10),
                  value: state.gearProgress,
                  backgroundColor: Colors.grey[200],
                  color: C.orange600,
                  minHeight: 5),
            ),
            //check icon
            Gap(2),
            Icon(
              Icons.check_circle,
              size: 20,
              color: state.isGearComplete ? C.orange600 : Colors.grey[200],
            ),
          ],
        );
      },
    );
  }
}
