part of 'job_post_bloc.dart';

enum ScheduleType { now, later }

enum JobPostSearchingStatus { initial, searching, found, notFound }

enum JobSchedule { now, later }

class JobPostState extends Equatable {
  final String jobPosition;
  final String jobDescription;
  final double progressBarPercentage;
  final List<File> jobPhotos;
  final String jobAddress;
  final int budgetAmount;
  final ScheduleType scheduleType;
  final double convenienceFee;
  final int pageIndex;
  final DateTime? selectedDate;
  final JobPostSearchingStatus jobPostSearchingStatus;
  final String jobCategory;
  final JobSchedule jobSchedule; // Added jobSchedule field

  const JobPostState(
      {this.jobPosition = '',
      this.jobDescription = '',
      this.progressBarPercentage = .20,
      this.jobPhotos = const [],
      this.jobAddress = '',
      this.budgetAmount = 0,
      this.scheduleType = ScheduleType.now,
      this.convenienceFee = 0.0,
      this.pageIndex = 0,
      this.selectedDate,
      this.jobPostSearchingStatus = JobPostSearchingStatus.initial,
      this.jobCategory = '',
      this.jobSchedule = JobSchedule.now}); // Initialize jobSchedule

  @override
  List<Object?> get props => [
        jobPosition,
        jobDescription,
        progressBarPercentage,
        jobPhotos,
        jobAddress,
        budgetAmount,
        scheduleType,
        convenienceFee,
        pageIndex,
        selectedDate,
        jobPostSearchingStatus,
        jobCategory,
        jobSchedule // Add jobSchedule to props
      ];

  JobPostState copyWith(
      {String? jobPosition,
      String? jobDescription,
      double? progressBarPercentage,
      List<File>? jobPhotos,
      String? jobAddress,
      double? jobAmount,
      int? budgetAmount,
      ScheduleType? scheduleType,
      double? convenienceFee,
      int? pageIndex,
      DateTime? selectedDate,
      JobPostSearchingStatus? jobPostSearchingStatus,
      String? jobCategory,
      JobSchedule? jobSchedule}) {
    return JobPostState(
        jobPosition: jobPosition ?? this.jobPosition,
        jobDescription: jobDescription ?? this.jobDescription,
        progressBarPercentage:
            progressBarPercentage ?? this.progressBarPercentage,
        jobPhotos: jobPhotos ?? this.jobPhotos,
        jobAddress: jobAddress ?? this.jobAddress,
        budgetAmount: budgetAmount ?? this.budgetAmount,
        scheduleType: scheduleType ?? this.scheduleType,
        convenienceFee: convenienceFee ?? this.convenienceFee,
        pageIndex: pageIndex ?? this.pageIndex,
        selectedDate: selectedDate ?? this.selectedDate,
        jobPostSearchingStatus:
            jobPostSearchingStatus ?? this.jobPostSearchingStatus,
        jobCategory: jobCategory ?? this.jobCategory,
        jobSchedule: jobSchedule ?? this.jobSchedule);
  }
}
