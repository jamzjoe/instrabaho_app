part of 'job_post_bloc.dart';

sealed class JobPostEvent extends Equatable {
  const JobPostEvent();

  @override
  List<Object> get props => [];
}

class JobPostChangeScreenIndex extends JobPostEvent {
  final int index;

  JobPostChangeScreenIndex(this.index);

  @override
  List<Object> get props => [index];
}

class JobPostFindRecommendedJobs extends JobPostEvent {}

class JobPostOnChangeBudget extends JobPostEvent {
  final int budgetAmount;

  JobPostOnChangeBudget(this.budgetAmount);

  @override
  List<Object> get props => [budgetAmount];
}

class JobPostOnDeleteAmountBudget extends JobPostEvent {
  final int budgetAmount;

  JobPostOnDeleteAmountBudget(this.budgetAmount);

  @override
  List<Object> get props => [budgetAmount];
}

class JobPostUploadPhotos extends JobPostEvent {
  final List<File> photos;

  JobPostUploadPhotos(this.photos);

  @override
  List<Object> get props => [photos];
}

class JobPostDeletePhoto extends JobPostEvent {
  final int index;

  JobPostDeletePhoto(this.index);

  @override
  List<Object> get props => [index];
}

class JobPostSetSchedule extends JobPostEvent {
  final JobSchedule jobSchedule;

  JobPostSetSchedule(this.jobSchedule);

  @override
  List<Object> get props => [jobSchedule];
}

class JobPostAddCategory extends JobPostEvent {
  final String category;

  JobPostAddCategory(this.category);

  @override
  List<Object> get props => [category];
}

class JobPostOnChangeDescription extends JobPostEvent {
  final String description;

  JobPostOnChangeDescription(this.description);

  @override
  List<Object> get props => [description];
}

class JobPostChangeJobTitle extends JobPostEvent {
  final String jobTitle;

  JobPostChangeJobTitle(this.jobTitle);

  @override
  List<Object> get props => [jobTitle];
}

class JobPostOnChangeJobAddress extends JobPostEvent {
  final String jobAddress;

  JobPostOnChangeJobAddress(this.jobAddress);

  @override
  List<Object> get props => [jobAddress];
}

class JobPostReset extends JobPostEvent {}
