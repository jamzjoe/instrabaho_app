import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instrabaho_app/constant/data/listings.dart';
import 'package:instrabaho_app/constant/data/workers_mock.dart';
import 'package:instrabaho_app/domain/data/worker_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on<SearchHiredWorker>((event, emit) {
      emit(state.copyWith(
          activeWorker: state.activeWorker?.copyWith(isHired: true)));
    });

    on<SearchSetHint>((event, emit) {
      log("SearchSetHint: ${event.hint}");
      emit(state.copyWith(activeHint: event.hint));
    });

    on<SearchOnChangeQuery>((event, emit) {
      if (event.query.isEmpty) {
        emit(state.copyWith(searchQuery: '', searchResult: []));
      } else {
        final searchResult = searchHints
            .where((element) =>
                element['job']
                    .toLowerCase()
                    .contains(event.query.toLowerCase()) ||
                _isFuzzyMatch(element['job'], event.query))
            .toList();

        emit(state.copyWith(
            searchQuery: event.query,
            searchResult:
                searchResult.map((e) => e['job'].toString()).toList()));
      }
    });

    on<SearchBlocReset>((event, emit) {
      emit(SearchState());
    });

    on<SearchWorkerAcceptOrNot>((event, emit) async {
      if (event.isAccepted == false) {
        add(SearchBlocReset());
        add(SearchJobFindWorker());
      } else {
        emit(state.copyWith(jobSearchStatus: JobSearchStatus.workerIsOnTheWay));
      }
    });

    on<SearchJobFindWorker>((event, emit) async {
      const totalSteps = 100; // Number of steps for smooth progress
      const loopCount = 4; // Repeat 0.0 to 0.9 four times
      const duration =
          Duration(seconds: 2); // Total duration for each smooth transition
      final interval =
          duration.inMilliseconds ~/ totalSteps; // Interval between updates

      var result = workersMockData.where((element) {
        return element.position.toLowerCase().contains(state.activeHint);
      }).toList();
      if (result.length > 3) {
        result = result.sublist(0, 3);
      }

      // Loop to simulate searching for a worker
      for (var loop = 0; loop < loopCount; loop++) {
        for (var step = 0; step <= totalSteps; step++) {
          final percentage =
              0.9 * step / totalSteps; // Progress from 0.0 to 0.9
          emit(state.copyWith(
              findingPercentage: percentage,
              jobSearchStatus: JobSearchStatus.finding));
          await Future.delayed(Duration(milliseconds: interval));
        }
        // Optional pause at 0.9 to simulate a worker being considered
        await Future.delayed(Duration(milliseconds: 200));
      }

      // Smoothly transition to 1.0 in the final loop
      for (var step = 0; step <= totalSteps; step++) {
        final percentage =
            0.9 + 0.1 * step / totalSteps; // Progress from 0.9 to 1.0
        emit(state.copyWith(
            findingPercentage: percentage,
            jobSearchStatus: JobSearchStatus.finding));
        await Future.delayed(Duration(milliseconds: interval));
      }

      // Emit final state with 1.0 percentage
      emit(state.copyWith(
          activeHint: result[0].position,
          workers: result,
          searchResult: [result[0].position.toLowerCase()],
          findingPercentage: 1.0,
          jobSearchStatus: JobSearchStatus.finding));
    });

    on<SearchJobWorkerIsOnTheWay>((event, emit) async {
      const totalSteps = 100; // Number of steps for smooth progress
      const loopCount = 4; // Repeat 0.0 to 0.9 four times
      const duration =
          Duration(seconds: 2); // Total duration for each smooth transition
      final interval =
          duration.inMilliseconds ~/ totalSteps; // Interval between updates

      // Loop to simulate searching for a worker
      for (var loop = 0; loop < loopCount; loop++) {
        for (var step = 0; step <= totalSteps; step++) {
          final percentage =
              0.9 * step / totalSteps; // Progress from 0.0 to 0.9
          emit(state.copyWith(
              workerIsOnTheWayPercentage: percentage,
              jobSearchStatus: JobSearchStatus.workerIsOnTheWay));
          await Future.delayed(Duration(milliseconds: interval));
        }
        // Optional pause at 0.9 to simulate a worker being considered
        await Future.delayed(Duration(milliseconds: 200));
      }

      // Smoothly transition to 1.0 in the final loop
      for (var step = 0; step <= totalSteps; step++) {
        final percentage =
            0.9 + 0.1 * step / totalSteps; // Progress from 0.9 to 1.0
        emit(state.copyWith(
            workerIsOnTheWayPercentage: percentage,
            jobSearchStatus: JobSearchStatus.workerIsOnTheWay));

        await Future.delayed(Duration(milliseconds: interval));
      }

      // Emit final state with 1.0 percentage
      emit(state.copyWith(
          workerIsOnTheWayPercentage: 1.0,
          jobSearchStatus: JobSearchStatus.workerIsOnTheWay));
      add(SearchJobWorking());
    });

    on<SearchJobWorking>((event, emit) async {
      const totalSteps = 100; // Number of steps for smooth progress
      const loopCount = 4; // Repeat 0.0 to 0.9 four times
      const duration =
          Duration(seconds: 2); // Total duration for each smooth transition
      final interval =
          duration.inMilliseconds ~/ totalSteps; // Interval between updates

      // Loop to simulate searching for a worker
      for (var loop = 0; loop < loopCount; loop++) {
        for (var step = 0; step <= totalSteps; step++) {
          final percentage =
              0.9 * step / totalSteps; // Progress from 0.0 to 0.9
          emit(state.copyWith(
              workingPercentage: percentage,
              jobSearchStatus: JobSearchStatus.working));
          await Future.delayed(Duration(milliseconds: interval));
        }
        // Optional pause at 0.9 to simulate a worker being considered
        await Future.delayed(Duration(milliseconds: 200));
      }

      // Smoothly transition to 1.0 in the final loop
      for (var step = 0; step <= totalSteps; step++) {
        final percentage =
            0.9 + 0.1 * step / totalSteps; // Progress from 0.9 to 1.0
        emit(state.copyWith(
            workingPercentage: percentage,
            jobSearchStatus: JobSearchStatus.working));
        await Future.delayed(Duration(milliseconds: interval));
      }

      // Emit final state with 1.0 percentage
      emit(state.copyWith(
          findingPercentage: 1.0, jobSearchStatus: JobSearchStatus.working));
      add(SearchJobCompleted());
    });

    on<SearchJobCompleted>((event, emit) async {
      const totalSteps = 100; // Number of steps for smooth progress
      const loopCount = 4; // Repeat 0.0 to 0.9 four times
      const duration =
          Duration(seconds: 2); // Total duration for each smooth transition
      final interval =
          duration.inMilliseconds ~/ totalSteps; // Interval between updates

      // Loop to simulate searching for a worker
      for (var loop = 0; loop < loopCount; loop++) {
        for (var step = 0; step <= totalSteps; step++) {
          final percentage =
              0.9 * step / totalSteps; // Progress from 0.0 to 0.9
          emit(state.copyWith(
              completedPercentage: percentage,
              jobSearchStatus: JobSearchStatus.completed));
          await Future.delayed(Duration(milliseconds: interval));
        }
        // Optional pause at 0.9 to simulate a worker being considered
        await Future.delayed(Duration(milliseconds: 200));
      }

      // Smoothly transition to 1.0 in the final loop
      for (var step = 0; step <= totalSteps; step++) {
        final percentage =
            0.9 + 0.1 * step / totalSteps; // Progress from 0.9 to 1.0
        emit(state.copyWith(
            completedPercentage: percentage,
            jobSearchStatus: JobSearchStatus.completed));
        await Future.delayed(Duration(milliseconds: interval));
      }

      // Emit final state with 1.0 percentage
      emit(state.copyWith(
          findingPercentage: 1.0, jobSearchStatus: JobSearchStatus.completed));
    });

    on<SearchSetActiveWorker>((event, emit) {
      emit(state.copyWith(activeWorker: event.worker.copyWith(isHired: true)));
    });

    on<SearchSetActivePlace>((event, emit) {
      emit(state.copyWith(activePlace: event.place));
    });
  }

  bool _isFuzzyMatch(String element, String query) {
    final elementChars = element.toLowerCase().split('');
    final queryChars = query.toLowerCase().split('');

    var elementIndex = 0;
    var queryIndex = 0;
    var matchCount = 0;

    while (
        elementIndex < elementChars.length && queryIndex < queryChars.length) {
      if (elementChars[elementIndex] == queryChars[queryIndex]) {
        matchCount++;
        queryIndex++;
      }
      elementIndex++;
    }

    return matchCount == queryChars.length;
  }
}
