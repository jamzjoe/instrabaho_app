import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:instrabaho_app/constant/inputs/email_input.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_back_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_textfield.dart';
import 'package:instrabaho_app/presentation/forgot_password/bloc/forgot_password_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(50 - 16),
                  Text("Forgot your password?",
                      style: context.textTheme.appBarFont),
                  const Gap(8),
                  Text("Enter your email address to reset your password",
                      style: context.textTheme.noteStyle),
                  const Gap(20),
                  BlocSelector<ForgotPasswordBloc, ForgotPasswordState,
                      EmailInput?>(
                    selector: (state) {
                      return state.emailInput;
                    },
                    builder: (context, state) {
                      return InstrabahoTextField(
                        errorText: state?.validator(state.value) ==
                                EmailInputValidationError.invalid
                            ? "Invalid email"
                            : null,
                        hintText: "Email address",
                        onChanged: (p0) {
                          BlocProvider.of<ForgotPasswordBloc>(context)
                              .add(ForgotPasswordEmailChanged(p0));
                        },
                      );
                    },
                  ),
                  const Gap(20),
                  BlocSelector<ForgotPasswordBloc, ForgotPasswordState, bool?>(
                    selector: (state) {
                      return state.emailInput?.isValid;
                    },
                    builder: (context, state) {
                      final isValid = state ?? false;
                      return InstrabahoButton(
                          label: 'Send reset link',
                          onTap: isValid ? () {} : null);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
