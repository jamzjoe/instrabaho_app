import 'package:flutter/gestures.dart';
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
import 'package:instrabaho_app/presentation/app/app_bloc.dart';
import 'package:instrabaho_app/presentation/authentication/email_verificaton/email_verfication.dart';
import 'package:instrabaho_app/presentation/authentication/login/bloc/login_bloc.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_single_child_scroll_view.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_textfield.dart';
import 'package:instrabaho_app/presentation/home/cubit/bottom_nav_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.authenticationState == AuthenticationState.authenticated) {
          context.goNamed(RouterNames.home);
          BlocProvider.of<BottomNavCubit>(context).selectTab(BottomNavTab.home);
        }
      },
      child: Scaffold(
        body: CustomSingleChildScrollView(
          context: context,
          childrenWidget: [
            GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: SvgPicture.asset(Assets.svg.customBackButton)),
            Gap(40),
            Text("Welcome back to Instrabaho!",
                style: context.textTheme.appBarFont),
            const Gap(8),
            Text(
                "Log in to continue connecting with trusted workers and employers.",
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
                return InstrabahoTextField.password(
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
                  onChanged: (p0) {
                    context
                        .read<LoginBloc>()
                        .add(LoginPasswordChanged(PasswordInput.dirty(p0)));
                  },
                );
              },
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Forgot password?",
                    style:
                        context.textTheme.noteStyle.copyWith(color: C.blue500)),
              ],
            ),
            const Gap(24),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                final isValid = state.email?.isValid == true &&
                    state.password?.isValid == true;
                return InstrabahoButton(
                    label: 'Login',
                    onTap: isValid
                        ? () {
                            BlocProvider.of<LoginBloc>(context)
                                .add(LoginSubmitted());
                          }
                        : null);
              },
            ),
            const Gap(32),
            const Center(child: Text("or")),
            // Center(
            //     child: TextButton(
            //         child: Text("Face Detection Test "),
            //         onPressed: () {
            //           context.pushNamed(RouterNames.faceDetectionTest);
            //         })),
            const Gap(32),
            // Center(
            //     child: TextButton(
            //         child: Text("Match Face Detection Test"),
            //         onPressed: () {
            //           context.pushNamed(RouterNames.faceDetectionMatchTest);
            //         })),

            SocialMediaAuthentication(actionText: 'Login'),
            Spacer(),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Don't have an account yet? ",
                  style: context.textTheme.noteStyle,
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.goNamed(RouterNames.emailVerification);
                        },
                      text: "Sign up now",
                      style: context.textTheme.noteStyle.copyWith(
                        color: C.blue500,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
