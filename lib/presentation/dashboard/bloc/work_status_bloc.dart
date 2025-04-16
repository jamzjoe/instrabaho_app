import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'work_status_event.dart';
import 'work_status_state.dart';

class WorkStatusBloc extends Bloc<WorkStatusEvent, WorkStatusState> {
  WorkStatusBloc()
      : super(WorkStatusState(
          backpackProgress: 0.0,
          carProgress: 0.0,
          homeProgress: 0.0,
          gearProgress: 0.0,
          checkProgress: 0.0,
        )) {
    on<StartWorkStatus>(_onStartWorkStatus);
    on<ScanQRVerify>(_onScanQRVerify);
    on<StartHomeProgress>(_onStartHomeProgress);
  }

  Timer? _backpackTimer;
  Timer? _carTimer;
  Timer? _homeTimer;
  Timer? _gearTimer;
  Timer? _checkTimer;
  int _backpackLoops = 0;
  int _carLoops = 0;
  int _homeLoops = 0;
  int _gearLoops = 0;
  int _checkLoops = 0;
  static const int maxLoops = 5;

  Future<void> _onStartWorkStatus(
      StartWorkStatus event, Emitter<WorkStatusState> emit) async {
    await _startBackpackProgress(emit);
  }

  Future<void> _startBackpackProgress(Emitter<WorkStatusState> emit) async {
    final completer = Completer<void>();

    _backpackTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_backpackLoops >= maxLoops && state.backpackProgress >= 1.0) {
        timer.cancel();
        emit(state.copyWith(
          isBackpackComplete: true,
          backpackProgress: 1.0,
        ));
        completer.complete();
      } else {
        if (state.backpackProgress >= 1.0) {
          _backpackLoops++;
          emit(state.copyWith(backpackProgress: 0.0));
        } else {
          emit(state.copyWith(
            backpackProgress: state.backpackProgress + 0.02,
          ));
        }
      }
    });

    await completer.future;
    await _startCarProgress(emit);
  }

  Future<void> _startCarProgress(Emitter<WorkStatusState> emit) async {
    final completer = Completer<void>();

    _carTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_carLoops >= maxLoops && state.carProgress >= 1.0) {
        timer.cancel();
        emit(state.copyWith(
          isCarComplete: true,
          carProgress: 1.0,
        ));
        completer.complete();
      } else {
        if (state.carProgress >= 1.0) {
          _carLoops++;
          emit(state.copyWith(carProgress: 0.0));
        } else {
          emit(state.copyWith(
            carProgress: state.carProgress + 0.02,
          ));
        }
      }
    });

    await completer.future;
  }

  Future<void> _onScanQRVerify(
      ScanQRVerify event, Emitter<WorkStatusState> emit) async {
    emit(state.copyWith(isQRVerified: true));
  }

  Future<void> _onStartHomeProgress(
      StartHomeProgress event, Emitter<WorkStatusState> emit) async {
    await _startHomeProgress(emit);
  }

  Future<void> _startHomeProgress(Emitter<WorkStatusState> emit) async {
    final completer = Completer<void>();

    _homeTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_homeLoops >= maxLoops && state.homeProgress >= 1.0) {
        timer.cancel();
        emit(state.copyWith(
          isHomeComplete: true,
          homeProgress: 1.0,
        ));
        completer.complete();
      } else {
        if (state.homeProgress >= 1.0) {
          _homeLoops++;
          emit(state.copyWith(homeProgress: 0.0));
        } else {
          emit(state.copyWith(
            homeProgress: state.homeProgress + 0.02,
          ));
        }
      }
    });

    await completer.future;
    await _startGearProgress(emit);
  }

  Future<void> _startGearProgress(Emitter<WorkStatusState> emit) async {
    final completer = Completer<void>();

    _gearTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_gearLoops >= maxLoops && state.gearProgress >= 1.0) {
        timer.cancel();
        emit(state.copyWith(
          isGearComplete: true,
          gearProgress: 1.0,
        ));
        completer.complete();
      } else {
        if (state.gearProgress >= 1.0) {
          _gearLoops++;
          emit(state.copyWith(gearProgress: 0.0));
        } else {
          emit(state.copyWith(
            gearProgress: state.gearProgress + 0.02,
          ));
        }
      }
    });

    await completer.future;
    await _startCheckProgress(emit);
  }

  Future<void> _startCheckProgress(Emitter<WorkStatusState> emit) async {
    final completer = Completer<void>();

    _checkTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_checkLoops >= maxLoops && state.checkProgress >= 1.0) {
        timer.cancel();
        emit(state.copyWith(
          isCheckComplete: true,
          checkProgress: 1.0,
        ));
        completer.complete();
      } else {
        if (state.checkProgress >= 1.0) {
          _checkLoops++;
          emit(state.copyWith(checkProgress: 0.0));
        } else {
          emit(state.copyWith(
            checkProgress: state.checkProgress + 0.02,
          ));
        }
      }
    });

    await completer.future;
  }

  @override
  Future<void> close() {
    _backpackTimer?.cancel();
    _carTimer?.cancel();
    _homeTimer?.cancel();
    _gearTimer?.cancel();
    _checkTimer?.cancel();
    return super.close();
  }
}
