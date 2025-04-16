import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_text.dart';
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
          backgroundColor: Colors.white,
          //center docked floatingActionButton
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: .2,
                        blurRadius: 30,
                        offset: Offset(0, -50),
                      ),
                    ],
                  ),
                  width: 70, // Adjust width
                  height: 70, // Adjust height
                  child: FloatingActionButton(
                    backgroundColor: C.blue600,
                    onPressed: () {
                      context.pushNamed(RouterNames.jobPost);
                    },
                    elevation: 0, // Remove elevation
                    highlightElevation: 0, // Remove highlight elevation
                    shape: CircleBorder(
                      side: BorderSide(color: Colors.white, width: 10),
                    ),
                    child: Icon(Icons.add, size: 30), // Adjust icon size
                  ),
                ),
                CustomText.notes(context, 'Post a job',
                    color: C.textColor, fontSize: 11)
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, -10),
                ),
              ],
            ),
            child: BottomAppBar(
              padding: EdgeInsets.zero,
              elevation: 0,
              notchMargin: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottomNavItem(
                      icon: SvgPicture.asset(Assets.bottomNav.navHome,
                          colorFilter: currentIndex == 0
                              ? ColorFilter.mode(C.textColor, BlendMode.srcIn)
                              : ColorFilter.mode(
                                  Colors.grey.shade500, BlendMode.srcIn)),
                      label: 'Home',
                      index: 0,
                      currentIndex: currentIndex,
                      onPressed: () {
                        navigationShell.goBranch(0, initialLocation: true);
                        context
                            .read<BottomNavCubit>()
                            .selectTab(BottomNavTab.home);
                      },
                    ),
                    BottomNavItem(
                      icon: SvgPicture.asset(Assets.bottomNav.navHistory,
                          colorFilter: currentIndex == 1
                              ? ColorFilter.mode(C.textColor, BlendMode.srcIn)
                              : ColorFilter.mode(
                                  Colors.grey.shade500, BlendMode.srcIn)),
                      label: 'History',
                      index: 1,
                      currentIndex: currentIndex,
                      onPressed: () {
                        navigationShell.goBranch(1, initialLocation: true);
                        context
                            .read<BottomNavCubit>()
                            .selectTab(BottomNavTab.interviews);
                      },
                    ),
                    SizedBox(width: 80), // FAB spacing
                    BottomNavItem(
                      icon: Badge.count(
                        count: 4,
                        backgroundColor: C.blue700,
                        child: SvgPicture.asset(Assets.bottomNav.navChat,
                            colorFilter: currentIndex == 2
                                ? ColorFilter.mode(C.blue700, BlendMode.srcIn)
                                : ColorFilter.mode(
                                    Colors.grey.shade500, BlendMode.srcIn)),
                      ),
                      label: 'Inbox',
                      index: 2,
                      currentIndex: currentIndex,
                      onPressed: () {
                        navigationShell.goBranch(2, initialLocation: true);
                        context
                            .read<BottomNavCubit>()
                            .selectTab(BottomNavTab.messages);
                      },
                    ),
                    BottomNavItem(
                      icon: SvgPicture.asset(Assets.bottomNav.navProfile,
                          colorFilter: currentIndex == 3
                              ? ColorFilter.mode(C.textColor, BlendMode.srcIn)
                              : ColorFilter.mode(
                                  Colors.grey.shade500, BlendMode.srcIn)),
                      label: 'Profile',
                      index: 3,
                      currentIndex: currentIndex,
                      onPressed: () {
                        navigationShell.goBranch(3, initialLocation: true);
                        context
                            .read<BottomNavCubit>()
                            .selectTab(BottomNavTab.profile);
                      },
                    ),
                  ],
                ),
              ),
            ),
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

class BottomNavItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final int index;
  final int currentIndex;
  final Function() onPressed;

  const BottomNavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 24,
                child: icon,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: currentIndex == index ? C.textColor : Colors.grey,
                  fontSize: 11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
