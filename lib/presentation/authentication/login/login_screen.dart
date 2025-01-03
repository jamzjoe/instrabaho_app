import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/inputs/email_input.dart';
import 'package:instrabaho_app/constant/inputs/password_input.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/authentication/login/bloc/login_bloc.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_back_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_single_child_scroll_view.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_textfield.dart';
import 'package:instrabaho_app/presentation/home/cubit/bottom_nav_cubit.dart';
import 'package:ionicons/ionicons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSingleChildScrollView(
        context: context,
        childrenWidget: [
          GestureDetector(
              onTap: () {
                context.pop();
              },
              child: SvgPicture.asset(Assets.svg.customBackButton)),
          Gap(40),
          Text("Welcome back!", style: context.textTheme.appBarFont),
          const Gap(8),
          Text("Please sign in to your registered account",
              style: context.textTheme.noteStyle),
          const Gap(20),
          BlocSelector<LoginBloc, LoginState, EmailInput?>(
            selector: (state) {
              return state.email;
            },
            builder: (context, state) {
              return InstrabahoTextField(
                errorText: state?.validator(state.value) ==
                        EmailInputValidationError.invalid
                    ? "Invalid email"
                    : null,
                hintText: "Email address",
                onChanged: (value) {
                  context
                      .read<LoginBloc>()
                      .add(LoginEmailChanged(EmailInput.dirty(value)));
                },
              );
            },
          ),
          const Gap(20),
          BlocSelector<LoginBloc, LoginState, PasswordInput?>(
            selector: (state) {
              return state.password;
            },
            builder: (context, state) {
              return InstrabahoTextField(
                errorText: state?.validator(state.value) ==
                        PasswordValidationError.empty
                    ? "Password cannot be empty"
                    : state?.validator(state.value) ==
                            PasswordValidationError.noDigit
                        ? "Password must contain at least one digit"
                        : state?.validator(state.value) ==
                                PasswordValidationError.noUpperCase
                            ? "Password must contain at least one uppercase letter"
                            : state?.validator(state.value) ==
                                    PasswordValidationError.noDigit
                                ? "Password must contain at least one digit"
                                : state?.validator(state.value) ==
                                        PasswordValidationError.noUpperCase
                                    ? "Password must contain at least one uppercase letter"
                                    : state?.validator(state.value) ==
                                            PasswordValidationError.tooShort
                                        ? "Password must be at least 8 characters long"
                                        : null,
                hintText: "Password",
                isPassword: true,
                onChanged: (p0) {
                  context
                      .read<LoginBloc>()
                      .add(LoginPasswordChanged(PasswordInput.dirty(p0)));
                },
              );
            },
          ),
          const Gap(30),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              final isValid = state.email?.isValid == true &&
                  state.password?.isValid == true;
              return InstrabahoButton(
                  label: 'Login',
                  onTap: isValid
                      ? () {
                          context.goNamed(RouterNames.home);
                          BlocProvider.of<BottomNavCubit>(context)
                              .selectTab(BottomNavTab.home);
                        }
                      : null);
            },
          ),
          const Gap(10),
          Row(
            children: [
              Text("Forgot password?", style: context.textTheme.noteStyle),
              const Gap(5),
              GestureDetector(
                onTap: () => context.pushNamed(RouterNames.forgot_password),
                child: Text("Reset here",
                    style: context.textTheme.instruction.copyWith(
                        decoration: TextDecoration.underline,
                        color: secondaryColor)),
              ),
            ],
          ),
          const Gap(32),
          const Center(child: Text("Or sign in with")),
          const Gap(32),
          Row(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(60),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Ionicons.logo_facebook, color: Colors.white),
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
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Ionicons.logo_google, color: Colors.white),
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
        ],
      ),
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            centerTitle: false,
            leading: CustomBackButton(),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(50 - 16),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
