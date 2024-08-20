import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController? _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: const [
                _OnboadingOne(),
                _OnboadingOne(),
                _OnboadingOne(),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (_currentPage > 0) {
                      _pageController?.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          _currentPage != 0 ? primaryColor : Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Icon(CupertinoIcons.chevron_back,
                            color: _currentPage != 0
                                ? Colors.white
                                : Colors.grey.withOpacity(0.8))),
                  ),
                ),
                _Inidcator(currentPage: _currentPage),
                GestureDetector(
                    onTap: () {
                      if (_currentPage < 2) {
                        _pageController?.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 10),
                      child: _currentPage == 2
                          ? GestureDetector(
                              onTap: _onStart,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  "Start",
                                  style: FontStyles.subheader
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: _currentPage <= 2
                                    ? primaryColor
                                    : Colors.grey,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: Icon(CupertinoIcons.chevron_forward,
                                      color: _currentPage != 2
                                          ? Colors.white
                                          : Colors.grey.withOpacity(0.8))),
                            ),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  void _onStart() {
    context.pushReplacementNamed(RouterNames.onboardingUserSelection);
  }
}

class _Inidcator extends StatelessWidget {
  const _Inidcator({
    required int currentPage,
  }) : _currentPage = currentPage;

  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 3; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: _currentPage == i ? 26 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: _currentPage == i ? primaryColor : Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }
}

class _OnboadingOne extends StatelessWidget {
  const _OnboadingOne();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            CustomPlaceHolder(),
            Gap(20),
            Text('Find your dream job now', style: FontStyles.header),
            Gap(10),
            Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempory',
                style: FontStyles.caption,
                textAlign: TextAlign.center),
            Gap(16)
          ],
        ));
  }
}

class CustomPlaceHolder extends StatelessWidget {
  const CustomPlaceHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      color: Colors.grey.withOpacity(0.3),
      fallbackHeight: 200,
      fallbackWidth: 200,
    );
  }
}
