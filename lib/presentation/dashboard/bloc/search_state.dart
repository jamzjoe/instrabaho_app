part of 'search_bloc.dart';

enum JobSearchStatus { finding, workerIsOnTheWay, working, completed }

extension JobSearchStatusExtension on JobSearchStatus {
  String get description {
    switch (this) {
      case JobSearchStatus.finding:
        return 'Finding a worker';
      case JobSearchStatus.workerIsOnTheWay:
        return 'Worker is on the way';
      case JobSearchStatus.working:
        return 'Worker is currently working';
      case JobSearchStatus.completed:
        return 'Job completed';
      default:
        return 'Unknown status';
    }
  }
}

class SearchState extends Equatable {
  SearchState(
      {this.searchQuery = '',
      this.activeHint = '',
      this.searchResult = const <String>[],
      this.findingPercentage = 0,
      this.workerIsOnTheWayPercentage = 0,
      this.completedPercentage = 0,
      this.workingPercentage = 0,
      this.jobSearchStatus = JobSearchStatus.finding,
      this.activeWorker,
      this.workers,
      this.activePlace = 'Manila'});

  final String searchQuery;
  final String activeHint;
  final List<String> searchResult;
  final double findingPercentage;
  final double workerIsOnTheWayPercentage;
  final double completedPercentage;
  final double workingPercentage;
  final JobSearchStatus jobSearchStatus;
  final WorkerModel? activeWorker;
  final List<WorkerModel>? workers;
  final String activePlace;

  SearchState copyWith(
      {String? searchQuery,
      String? activeHint,
      List<String>? searchResult,
      double? findingPercentage,
      double? workerIsOnTheWayPercentage,
      double? completedPercentage,
      double? workingPercentage,
      JobSearchStatus? jobSearchStatus,
      WorkerModel? activeWorker,
      List<WorkerModel>? workers,
      String? activePlace}) {
    return SearchState(
        searchQuery: searchQuery ?? this.searchQuery,
        activeHint: activeHint ?? this.activeHint,
        searchResult: searchResult ?? this.searchResult,
        findingPercentage: findingPercentage ?? this.findingPercentage,
        workerIsOnTheWayPercentage:
            workerIsOnTheWayPercentage ?? this.workerIsOnTheWayPercentage,
        completedPercentage: completedPercentage ?? this.completedPercentage,
        jobSearchStatus: jobSearchStatus ?? this.jobSearchStatus,
        workingPercentage: workingPercentage ?? this.workingPercentage,
        activeWorker: activeWorker ?? this.activeWorker,
        workers: workers ?? this.workers,
        activePlace: activePlace ?? this.activePlace);
  }

  @override
  List<Object?> get props => [
        searchQuery,
        activeHint,
        searchResult,
        findingPercentage,
        workerIsOnTheWayPercentage,
        completedPercentage,
        jobSearchStatus,
        workingPercentage,
        activeWorker,
        workers,
        activePlace
      ];
}
