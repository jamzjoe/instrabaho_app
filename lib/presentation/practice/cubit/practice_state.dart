part of 'practice_cubit.dart';

sealed class PracticeState extends Equatable {
  const PracticeState();

  @override
  List<Object> get props => [];
}

final class PracticeInitial extends PracticeState {}
