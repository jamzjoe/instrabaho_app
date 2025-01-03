import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/data/listings.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/search_bloc.dart';

class DashboardSearchBar extends StatefulWidget {
  const DashboardSearchBar({
    super.key,
  });

  @override
  _DashboardSearchBarState createState() => _DashboardSearchBarState();
}

class _DashboardSearchBarState extends State<DashboardSearchBar> {
  int _currentHintIndex = 0;
  String _currentHintText = "";
  int _currentCharIndex = 0;

  @override
  void initState() {
    super.initState();
    _startHintRotation();
  }

  void _startHintRotation() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _currentHintText = searchHints[_currentHintIndex]['job']
              .substring(0, _currentCharIndex + 1);
          _currentCharIndex++;
          if (_currentCharIndex ==
              searchHints[_currentHintIndex]['job'].length) {
            _currentCharIndex = 0;
            _currentHintIndex = (_currentHintIndex + 1) % searchHints.length;
            Future.delayed(const Duration(seconds: 1), _startHintRotation);
          } else {
            _startHintRotation();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ]),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          context.pushNamed(RouterNames.jobSearch);
          BlocProvider.of<SearchBloc>(context).add(SearchBlocReset());
          // place the active hint text to search bloc
          BlocProvider.of<SearchBloc>(context).add(SearchSetHint(searchHints[
              (_currentHintIndex - 1 + searchHints.length) %
                  searchHints.length]['job']));
          context.read<SearchBloc>().add(SearchOnChangeQuery(searchHints[
              (_currentHintIndex - 1 + searchHints.length) %
                  searchHints.length]['job']));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                "Search for $_currentHintText",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
