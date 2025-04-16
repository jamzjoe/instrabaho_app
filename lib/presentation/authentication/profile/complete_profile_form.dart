import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/inputs/names_input.dart';
import 'package:instrabaho_app/constant/inputs/password_input.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/authentication/profile/bloc/profile_bloc.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_single_child_scroll_view.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_dropdown_textfield.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_textfield.dart';
import 'package:instrabaho_app/presentation/home/cubit/bottom_nav_cubit.dart';

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
          context.goNamed(RouterNames.home);
          BlocProvider.of<BottomNavCubit>(context).selectTab(BottomNavTab.home);
        }
      },
      child: Scaffold(
        body: CustomSingleChildScrollView(context: context, childrenWidget: [
          GestureDetector(
              onTap: () {
                context.pop();
              },
              child: SvgPicture.asset(Assets.svg.customBackButton)),
          const Gap(40),
          Text("Complete your profile", style: context.textTheme.appBarFont),
          const Gap(8),
          Text("We need a few more details to set up your account.",
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
          const Gap(10),
          BlocSelector<ProfileBloc, ProfileState, NameInput?>(
            selector: (state) => state.lastName,
            builder: (context, state) {
              return InstrabahoTextField(
                errorText: state?.validator(state.value) ==
                        NameValidationError.invalid
                    ? "Invalid Last name"
                    : state?.validator(state.value) == NameValidationError.empty
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
          const Gap(10),
          Text("Make sure it matches the name on your government ID.",
              style: context.textTheme.noteStyle),
          const Gap(24),
          InstrabahoDropdownTextField(
            hintText: 'Location',
            options: [
              "Manila",
              "Makati",
              "Quezon City",
              "Pasig",
              "Taguig",
              "Mandaluyong",
              "Parañaque",
              "Pasay",
              "Marikina",
              "San Juan",
              "Las Piñas",
              "Muntinlupa",
              "Valenzuela",
              "Caloocan",
              "Malabon",
              "Navotas",
              "Pateros"
            ],
          ),
          Gap(10),
          Text("Your location helps us connect you with nearby workers.",
              style: context.textTheme.noteStyle),

          Gap(24),
          //create password
          BlocSelector<ProfileBloc, ProfileState, PasswordInput?>(
            selector: (state) {
              return state.password;
            },
            builder: (context, state) {
              return InstrabahoTextField.password(
                hintText: "Create Password",
                onChanged: (p0) {
                  BlocProvider.of<ProfileBloc>(context)
                      .add(ProfileOnChangedPassword(p0));
                },
                errorText: state?.validator(state.value) ==
                        PasswordValidationError.empty
                    ? "Invalid Password"
                    : state?.validator(state.value) ==
                            PasswordValidationError.empty
                        ? "Password cannot be empty"
                        : null,
                controller: TextEditingController(),
              );
            },
          ),
          Gap(10),
          Text(
              "Use at least 8 characters, including a mix of letters, numbers, and symbols.",
              style: context.textTheme.noteStyle),
          Gap(24),
          const Spacer(),
          Text(
              "By clicking Sign up, you agree to Instrabaho’s Terms & Conditions and Privacy Policy.",
              style: context.textTheme.noteStyle),
          const Gap(16),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              final isValid = state.password?.isValid == true &&
                  state.firstName?.isValid == true &&
                  state.lastName?.isValid == true;
              return InstrabahoButton(
                  label: 'Sign up',
                  onTap: () {
                    BlocProvider.of<ProfileBloc>(context)
                        .add(const ProfileOnCompleteSubmit());
                    context.read<BottomNavCubit>().selectTab(BottomNavTab.home);
                  }

                  // isValid
                  //     ? () {
                  //         BlocProvider.of<ProfileBloc>(context)
                  //             .add(const ProfileOnCompleteSubmit());
                  //         context
                  //             .read<BottomNavCubit>()
                  //             .selectTab(BottomNavTab.home);
                  //       }
                  //     : null

                  );
            },
          )
        ]),
      ),
    );
  }
}
