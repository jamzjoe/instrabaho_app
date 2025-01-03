import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/presentation/home/cubit/bottom_nav_cubit.dart';

class MainScreenWrapper extends StatelessWidget {
  const MainScreenWrapper({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavTab>(
      builder: (context, state) {
        final activeTab = state;
        final currentIndex = activeTab.index;
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              navigationShell.goBranch(value, initialLocation: true);
              switch (value) {
                case 0:
                  context.read<BottomNavCubit>().selectTab(BottomNavTab.home);
                  break;
                case 1:
                  context
                      .read<BottomNavCubit>()
                      .selectTab(BottomNavTab.interviews);
                  break;
                case 2:
                  context
                      .read<BottomNavCubit>()
                      .selectTab(BottomNavTab.messages);
                  break;
                case 3:
                  context
                      .read<BottomNavCubit>()
                      .selectTab(BottomNavTab.profile);
                  break;

                default:
              }
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  activeIcon: Icon(CupertinoIcons.house_fill),
                  icon: Icon(CupertinoIcons.house),
                  label: 'Home'),
              BottomNavigationBarItem(
                  activeIcon: Icon(CupertinoIcons.bookmark_fill),
                  icon: Icon(CupertinoIcons.bookmark),
                  label: 'Activity'),
              BottomNavigationBarItem(
                  activeIcon: Icon(CupertinoIcons.mail_solid),
                  icon: Icon(CupertinoIcons.mail),
                  label: 'Messages'),
              BottomNavigationBarItem(
                  activeIcon: Icon(CupertinoIcons.person_fill),
                  icon: Icon(CupertinoIcons.person),
                  label: 'Profile'),
            ],
          ),
          body: BlocBuilder<BottomNavCubit, BottomNavTab>(
            builder: (context, state) {
              return navigationShell;
            },
          ),
        );
      },
    );
  }
}
