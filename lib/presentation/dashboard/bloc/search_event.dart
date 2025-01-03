part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchSetHint extends SearchEvent {
  final String hint;

  SearchSetHint(this.hint);

  @override
  List<Object> get props => [hint];
}

class SearchOnChangeQuery extends SearchEvent {
  final String query;

  SearchOnChangeQuery(this.query);

  @override
  List<Object> get props => [query];
}

class SearchBlocReset extends SearchEvent {
  @override
  List<Object> get props => [];
}

class SearchWorkerAcceptOrNot extends SearchEvent {
  final bool isAccepted;

  SearchWorkerAcceptOrNot(this.isAccepted);

  @override
  List<Object> get props => [isAccepted];
}

class SearchJobFindWorker extends SearchEvent {
  SearchJobFindWorker();

  @override
  List<Object> get props => [];
}

class SearchJobWorkerIsOnTheWay extends SearchEvent {
  SearchJobWorkerIsOnTheWay();

  @override
  List<Object> get props => [];
}

class SearchJobWorking extends SearchEvent {
  SearchJobWorking();

  @override
  List<Object> get props => [];
}

class SearchJobCompleted extends SearchEvent {
  SearchJobCompleted();

  @override
  List<Object> get props => [];
}

class SearchSetActiveWorker extends SearchEvent {
  final WorkerModel worker;

  SearchSetActiveWorker(this.worker);

  @override
  List<Object> get props => [worker];
}

class SearchSetActivePlace extends SearchEvent {
  final String place;

  SearchSetActivePlace(this.place);

  @override
  List<Object> get props => [place];
}

class SearchHiredWorker extends SearchEvent {
  SearchHiredWorker();

  @override
  List<Object> get props => [];
}
