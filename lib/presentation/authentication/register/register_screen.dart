import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_back_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_textfield.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            centerTitle: false,
            leading: CustomBackButton(),
          ),
          SliverFillRemaining(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Create an account", style: FontStyles.header),
                    const Text("Please fill in the form to create an account"),
                    const Gap(20),
                    InstrabahoTextField(
                      hintText: "Username",
                    ),
                    const Gap(20),
                    InstrabahoTextField(
                      hintText: "Email address",
                    ),
                    const Gap(20),
                    InstrabahoTextField(hintText: "Password", isPassword: true),
                    const Gap(30),
                    const InstrabahoButton(
                        label: 'CREATE ACCOUNT', isTwoTone: true),
                    const Gap(10),
                    const Text(
                        "By signing up, you agree to our Terms of Service"),
                    const Spacer(),
                    Divider(color: hintColor.withOpacity(0.3)),
                    const Spacer(),
                    Center(
                      child: GestureDetector(
                          onTap: () {
                            context.pushReplacementNamed(RouterNames.login);
                          },
                          child: const Text("Don't have an account? Sign up")),
                    ),
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
