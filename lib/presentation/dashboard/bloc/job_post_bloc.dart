import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'job_post_event.dart';
part 'job_post_state.dart';

class JobPostBloc extends Bloc<JobPostEvent, JobPostState> {
  JobPostBloc() : super(JobPostState()) {
    on<JobPostChangeScreenIndex>((event, emit) {
      print('JobPostChangeScreenIndex: ${event.index}');
      if (event.index == 5) {
        return;
      }
      final progressBarPercentage = (event.index + 1) / 5;
      emit(state.copyWith(
          pageIndex: event.index + 1,
          progressBarPercentage: progressBarPercentage));
    });

    on<JobPostFindRecommendedJobs>((event, emit) async {
      print('JobPostFindRecommendedJobs: Searching for recommended jobs');
      emit(state.copyWith(
          jobPostSearchingStatus: JobPostSearchingStatus.searching));
      // Call API to find recommended jobs
      // If found emit(JobPostSearchingStatus.found)
      // else emit(JobPostSearchingStatus.notFound)
      // emitate add delay
      await Future.delayed(Duration(seconds: 2), () {
        print('JobPostFindRecommendedJobs: Found recommended jobs');
        emit(state.copyWith(
            jobPostSearchingStatus: JobPostSearchingStatus.found));
      });
    });

    on<JobPostOnChangeBudget>((event, emit) {
      print('JobPostOnChangeBudget: ${event.budgetAmount}');
      final combinedBudgetAmount =
          int.parse('${state.budgetAmount}${event.budgetAmount}');
      emit(state.copyWith(budgetAmount: combinedBudgetAmount));
    });

    on<JobPostOnDeleteAmountBudget>((event, emit) {
      print('JobPostOnDeleteAmountBudget');
      final budgetAmount = state.budgetAmount.toString();
      if (budgetAmount.isNotEmpty) {
        final newBudgetAmount =
            budgetAmount.substring(0, budgetAmount.length - 1);
        emit(state.copyWith(
            budgetAmount:
                int.parse(newBudgetAmount.isEmpty ? '0' : newBudgetAmount)));
      }
    });

    on<JobPostUploadPhotos>((event, emit) {
      print('JobPostUploadPhotos: ${event.photos.length} photos');
      final List<File> photos = List.from(state.jobPhotos);
      photos.addAll(event.photos);
      emit(state.copyWith(jobPhotos: photos));
    });

    on<JobPostDeletePhoto>((event, emit) {
      print('JobPostDeletePhoto: ${event.index}');
      final List<File> photos = List.from(state.jobPhotos);
      photos.removeAt(event.index);
      emit(state.copyWith(jobPhotos: photos));
    });

    on<JobPostSetSchedule>((event, emit) {
      print('JobPostSetSchedule: ${event.jobSchedule}');
      emit(state.copyWith(jobSchedule: event.jobSchedule));
    });

    on<JobPostOnChangeDescription>((event, emit) {
      print('JobPostOnChangeDescription: ${event.description}');
      emit(state.copyWith(jobDescription: event.description));
    });

    on<JobPostAddCategory>((event, emit) {
      print('JobPostAddCategory: ${event.category}');
      emit(state.copyWith(jobCategory: event.category));
    });

    on<JobPostChangeJobTitle>((event, emit) {
      print('JobPostChangeJobTitle: ${event.jobTitle}');
      emit(state.copyWith(jobPosition: event.jobTitle));
    });

    on<JobPostOnChangeJobAddress>((event, emit) {
      print('JobPostOnChangeJobAddress: ${event.jobAddress}');
      emit(state.copyWith(jobAddress: event.jobAddress));
    });

    on<JobPostReset>((event, emit) {
      print('JobPostReset');
      emit(JobPostState());
    });
  }
}
