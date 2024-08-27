import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'practice_state.dart';

class PracticeCubit extends Cubit<int> {
  PracticeCubit() : super(0);

  void increment(){
    emit(state+1);
  }

  void decrement(){
    emit(state-1);
  }
}