import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_text_rich.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';

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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView(
                  physics: const ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    _Onboarding(
                        image: Assets.images.onboarding1.path,
                        animate: _currentPage == 0,
                        textWidget: const CustomRichText(
                            normalText: 'Connecting',
                            boldText: " skilled Filipino workers ",
                            trailingText:
                                "to trusted employers, anytime, anywhere.")),
                    _Onboarding(
                        image: Assets.images.onboarding2.path,
                        animate: _currentPage == 1,
                        textWidget: const CustomRichText(
                            normalText: 'Search for',
                            boldText: " reliable workers ",
                            trailingText:
                                "post a task and let the best apply.")),
                    _Onboarding(
                        // Add this
                        image: Assets.images.onboarding3.path,
                        animate: _currentPage == 2,
                        textWidget: const CustomRichText(
                            normalText: 'We match you with',
                            boldText: " top-rated workers  ",
                            trailingText:
                                "in your area to get the job done faster.")),
                    _Onboarding(
                        // Add this
                        image: Assets.images.onboarding4.path,
                        animate: _currentPage == 3,
                        textWidget: const CustomRichText(
                            normalText: 'Be part of the',
                            boldText: " \nInstrabaho Community! ",
                            trailingText: "")),
                  ],
                ),
                Positioned(
                    right: 16,
                    top: 60,
                    child: SvgPicture.asset(Assets.svg.instrabahoLogo))
              ],
            ),
          ),
          const Gap(16),
          _Inidcator(currentPage: _currentPage),
          const Gap(16),
          if (_currentPage <= 2)
            InstrabahoButton(
                label: 'Continue',
                onTap: () {
                  _pageController?.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
                horizontalMargin: 16),
          if (_currentPage == 3)
            Row(
              children: [
                const Gap(16),
                Expanded(
                  child: InstrabahoButton(
                      outline: true,
                      label: 'Log in',
                      onTap: () => context.pushNamed(RouterNames.login),
                      horizontalMargin: 0),
                ),
                const Gap(8),
                Expanded(
                  child: InstrabahoButton(
                      label: 'Sign up',
                      onTap: () => context
                          .pushNamed(RouterNames.phoneNumberVerification),
                      horizontalMargin: 0),
                ),
                const Gap(16)
              ],
            ),
          const SizedBox(height: 30),
        ],
      ),
    );
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
        for (int i = 0; i < 4; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: _currentPage == i ? 26 : 4,
            height: 4,
            decoration: BoxDecoration(
              color: _currentPage == i ? demphasize : Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }
}

class _Onboarding extends StatelessWidget {
  const _Onboarding(
      {required this.image, this.animate = false, required this.textWidget});
  final String image;
  final bool animate;
  final Widget textWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
            child: Stack(
          children: [
            Image(image: AssetImage(image), fit: BoxFit.cover),
            Positioned(
              top: 100,
              left: 16,
              right: 64,
              child: AnimatedOpacity(
                opacity: animate ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: textWidget,
              ),
            ),
          ],
        )));
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
