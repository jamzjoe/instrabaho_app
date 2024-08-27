import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrabaho_app/presentation/practice/cubit/practice_cubit.dart';

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PracticeCubit, int>(
      builder: (context, state) {
        final value = state;
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${value}"),
                ElevatedButton(onPressed: () => increment(context), child: Text("Inc")),
                ElevatedButton(onPressed: () => decrement(context), child: Text("Dec"))
              ]
            ),
          )
        );
      },
    );
  }

  void increment(BuildContext context) {
  BlocProvider.of<PracticeCubit>(context).increment();

  }

  void decrement(BuildContext context) {
  BlocProvider.of<PracticeCubit>(context).decrement();
  }
}
