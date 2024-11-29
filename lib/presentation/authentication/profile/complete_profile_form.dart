import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/inputs/email_input.dart';
import 'package:instrabaho_app/constant/inputs/names_input.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/presentation/authentication/profile/bloc/profile_bloc.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_back_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_textfield.dart';

class CompleteProfileForm extends StatelessWidget {
  const CompleteProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) =>
          previous.profileCreationStatus != current.profileCreationStatus,
      listener: (context, state) {
        if (state.profileCreationStatus == ProfileCreationStatus.success) {
          //show modal
          showCupertinoModalPopup(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text("Profile created successfully"),
                content: const Text("You can now start using Instrabaho"),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      context.goNamed(RouterNames.home);
                    },
                    child: const Text("Continue"),
                  )
                ],
              );
            },
          );
        }
      },
      child: Scaffold(
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
                    Text("Complete your profile",
                        style: context.textTheme.appBarFont),
                    const Gap(8),
                    Text("Just a few more details to get started!",
                        style: context.textTheme.noteStyle),
                    const Gap(20),
                    BlocSelector<ProfileBloc, ProfileState, NameInput?>(
                      selector: (state) => state.firstName,
                      builder: (context, errorText) {
                        return InstrabahoTextField(
                          errorText: errorText?.validator(errorText.value) ==
                                  NameValidationError.invalid
                              ? "Invalid First name"
                              : errorText?.validator(errorText.value) ==
                                      NameValidationError.empty
                                  ? "First name cannot be empty"
                                  : null,
                          hintText: "First name",
                          onChanged: (p0) {
                            BlocProvider.of<ProfileBloc>(context)
                                .add(ProfileOnChangedFirstName(p0));
                          },
                        );
                      },
                    ),
                    const Gap(20),
                    BlocSelector<ProfileBloc, ProfileState, NameInput?>(
                      selector: (state) => state.lastName,
                      builder: (context, state) {
                        return InstrabahoTextField(
                          errorText: state?.validator(state.value) ==
                                  NameValidationError.invalid
                              ? "Invalid Last name"
                              : state?.validator(state.value) ==
                                      NameValidationError.empty
                                  ? "Last name cannot be empty"
                                  : null,
                          hintText: "Last name",
                          onChanged: (p0) {
                            BlocProvider.of<ProfileBloc>(context)
                                .add(ProfileOnChangedLastName(p0));
                          },
                        );
                      },
                    ),
                    const Gap(20),
                    BlocSelector<ProfileBloc, ProfileState, EmailInput?>(
                      selector: (state) => state.email,
                      builder: (context, state) {
                        return InstrabahoTextField(
                          errorText: state?.validator(state.value) ==
                                  EmailInputValidationError.invalid
                              ? "Invalid email"
                              : null,
                          hintText: "Email address",
                          onChanged: (p0) {
                            BlocProvider.of<ProfileBloc>(context)
                                .add(ProfileOnChangedEmail(p0));
                          },
                        );
                      },
                    ),
                    const Gap(30),
                    const Spacer(),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        final isValid = state.email?.isValid == true &&
                            state.firstName?.isValid == true &&
                            state.lastName?.isValid == true;
                        return InstrabahoButton(
                            label: 'Verify',
                            onTap: isValid
                                ? () {
                                    BlocProvider.of<ProfileBloc>(context)
                                        .add(const ProfileOnCompleteSubmit());
                                  }
                                : null);
                      },
                    ),
                    const Gap(50 - 16)
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
