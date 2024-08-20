import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_back_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_textfield.dart';
import 'package:ionicons/ionicons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.userType});

  final String userType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: false,
            title: Text(userType),
            leading: const CustomBackButton(),
          ),
          SliverFillRemaining(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Sign in", style: FontStyles.header),
                    const Text("Please sign in to your registered account"),
                    const Gap(20),
                    const InstrabahoTextField(
                      hintText: "Email address",
                    ),
                    const Gap(20),
                    const InstrabahoTextField(
                        hintText: "Password", isPassword: true),
                    const Gap(30),
                    InstrabahoButton(
                        label: 'SIGN IN',
                        isTwoTone: true,
                        onTap: () {
                          context.goNamed(RouterNames.home);
                        }),
                    const Gap(10),
                    Row(
                      children: [
                        const Text("Forgot password?"),
                        Gap(5),
                        GestureDetector(
                          onTap: () => context.pushNamed(RouterNames.forgot_password),
                          child: const Text("Reset here",
                              style: TextStyle(
                                  decoration: TextDecoration.underline)),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Center(child: Text("Or sign in with")),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Ionicons.logo_facebook,
                                    color: Colors.white),
                                const Gap(5),
                                Text("Facebook",
                                    style: FontStyles.subheader
                                        .copyWith(color: Colors.white)),
                              ],
                            ),
                          ),
                        )),
                        const Gap(10),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Ionicons.logo_google,
                                    color: Colors.white),
                                const Gap(5),
                                Text("Google",
                                    style: FontStyles.subheader
                                        .copyWith(color: Colors.white)),
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                    const Spacer(),
                    Divider(color: hintColor.withOpacity(0.3)),
                    const Spacer(),
                    Center(
                        child: GestureDetector(
                            onTap: () {
                              context.pushReplacementNamed(RouterNames.register,
                                  extra: userType);
                            },
                            child: const Text("Create an account"))),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
