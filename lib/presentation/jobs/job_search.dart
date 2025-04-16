import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/data/listings.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_search_field.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/search_bloc.dart';
import 'package:instrabaho_app/presentation/jobs/job_form.dart';
import 'package:ionicons/ionicons.dart';

import 'args/job_form_args.dart';

class JobSearchScreen extends StatelessWidget {
  const JobSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your location', style: context.textTheme.noteStyle),
                  BlocSelector<SearchBloc, SearchState, String>(
                    selector: (state) {
                      return state.activePlace;
                    },
                    builder: (context, state) {
                      return DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                        isDense: true,
                        value: state,
                        items: ['Manila', 'Cebu', 'Davao']
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (value) {
                          BlocProvider.of<SearchBloc>(context)
                              .add(SearchSetActivePlace(value!));
                        },
                      ));
                    },
                  )
                ],
              ),
              floating: true,
              snap: true,
              pinned: true,
              leadingWidth: 60,
              centerTitle: false,
              leading: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  context.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SvgPicture.asset(Assets.svg.customBackButton),
                ),
              )),
          SliverList(
              delegate: SliverChildListDelegate([
            Column(
              children: [
                BlocSelector<SearchBloc, SearchState, String>(
                  selector: (state) {
                    return state.activeHint;
                  },
                  builder: (context, state) {
                    return InstrabahoSearchField(
                      controller: TextEditingController(text: state),
                      hintText: state,
                      onChanged: (p0) {
                        context.read<SearchBloc>().add(SearchOnChangeQuery(p0));
                      },
                    );
                  },
                ),
                Gap(16),
                BlocSelector<SearchBloc, SearchState, bool>(
                  selector: (state) {
                    return state.searchQuery == '';
                  },
                  builder: (context, state) {
                    if (state) {
                      return SizedBox(
                        height: 50,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(4.0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: C
                                      .blue600, // Replace with your desired pastel color
                                  borderRadius: BorderRadius.circular(180),
                                ),
                                child: Center(
                                  child: Text('All',
                                      style: context.textTheme.caption
                                          .copyWith(color: Colors.white)),
                                ),
                              ),
                              if (searchHints.isNotEmpty)
                                ...searchHints.map((hint) {
                                  return GestureDetector(
                                    onTap: () async {
                                      // await _searchWorker(context, hint['job']);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(4.0),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                        color: C.blue600.withOpacity(
                                            0.1), // Replace with your desired pastel color
                                        borderRadius:
                                            BorderRadius.circular(180),
                                      ),
                                      child: Center(child: Text(hint['job'])),
                                    ),
                                  );
                                }).toList()
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
                  final activeQuery = state.searchQuery;
                  final hideWhen = state.searchResult.isEmpty;
                  if (hideWhen) {
                    return Visibility(
                      visible: activeQuery.isNotEmpty || activeQuery != '',
                      child: Text.rich(
                        TextSpan(
                          text: 'See results for ',
                          children: [
                            TextSpan(
                              text: activeQuery,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: C.blue600),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: state.searchResult.map((result) {
                      return ListTile(
                        leading: const Icon(Ionicons.search_circle),
                        title: Text(result),
                        onTap: () async {
                          // await _searchWorker(context, result);
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            enableDrag: true,
                            context: context,
                            builder: (context) {
                              return JobForm(
                                  args: JobFormArgs(jobTitle: result));
                            },
                          );
                        },
                      );
                    }).toList(),
                  );
                })
              ],
            )
          ])),
        ],
      ),
    );
  }

  Future<void> _searchWorker(BuildContext context, String result) async {
    BlocProvider.of<SearchBloc>(context).add(SearchBlocReset());
    context.read<SearchBloc>().add(SearchSetHint(result));
    BlocProvider.of<SearchBloc>(context).add(SearchJobFindWorker());
    await context.pushNamed(RouterNames.jobMapFinder);
    BlocProvider.of<SearchBloc>(context).add(SearchBlocReset());
  }
}
