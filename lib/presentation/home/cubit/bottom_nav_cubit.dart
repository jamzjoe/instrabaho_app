import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_state.dart';

enum BottomNavTab { home, interviews, messages, profile }

class BottomNavCubit extends Cubit<BottomNavTab> {
  BottomNavCubit() : super(BottomNavTab.home);

  void selectTab(BottomNavTab tab) {
    emit(tab);
  }
}
