import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/authentication/profile/bloc/profile_bloc.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_single_child_scroll_view.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:phone_form_field/phone_form_field.dart';

class PhoneNumberVerification extends StatelessWidget {
  const PhoneNumberVerification({super.key});

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
        const Gap(40),
        Text("Sign up to Instrabaho", style: context.textTheme.appBarFont),
        const Gap(8),
        Text(
            "Please enter your mobile number. We’ll send you a code to verify your account.",
            style: context.textTheme.noteStyle),
        const Gap(32),
        PhoneFormField(
            autofocus: true,
            onTapOutside: (p0) {
              // hide keyboard
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              prefixStyle: context.textTheme.caption,
              counterStyle: context.textTheme.caption,
              suffixStyle: context.textTheme.caption,
              hintStyle: context.textTheme.caption.copyWith(color: C.hintColor),
              labelStyle:
                  context.textTheme.caption.copyWith(color: C.hintColor),
              labelText: 'Phone Number',
              hintText: 'Enter your phone number',
              fillColor: C.fieldColor,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: C.blue600)),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: C.hintColor)),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: C.fieldColor)),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            style: context.textTheme.caption, // Set the input text style
            initialValue: PhoneNumber.parse('+63'), // or use the controller
            validator: PhoneValidator.compose([
              PhoneValidator.required(context),
              PhoneValidator.validMobile(context)
            ]),
            countrySelectorNavigator: const CountrySelectorNavigator.page(),
            onChanged: (phoneNumber) {
              log("Phone number: $phoneNumber");
              BlocProvider.of<ProfileBloc>(context).add(
                  ProfileOnChangePhoneNumber(
                      phoneNumber: phoneNumber.nsn,
                      isPhoneNumberValid: phoneNumber.isValid()));
            },
            enabled: true,
            isCountrySelectionEnabled: true,
            isCountryButtonPersistent: true,
            countryButtonStyle: CountryButtonStyle(
                showDropdownIcon: false,
                showDialCode: true,
                showIsoCode: false,
                showFlag: true,
                flagSize: 16,
                textStyle:
                    context.textTheme.caption // Set the country code text style
                )),
        const Spacer(),
        BlocSelector<ProfileBloc, ProfileState, bool>(
          selector: (state) {
            return state.isPhoneNumberValid;
          },
          builder: (context, state) {
            return InstrabahoButton(
                label: 'Continue',
                onTap: state
                    ? () {
                        context.pushNamed(RouterNames.otp);
                      }
                    : null);
          },
        ),
      ],
    ));
  }
}
