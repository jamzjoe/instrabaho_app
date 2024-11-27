import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:phone_form_field/phone_form_field.dart';

class PhoneNumberVerification extends StatelessWidget {
  const PhoneNumberVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(50), //back icon
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
              decoration: InputDecoration(
                prefixStyle: context.textTheme.caption,
                counterStyle: context.textTheme.caption,
                suffixStyle: context.textTheme.caption,
                hintStyle: context.textTheme.caption.copyWith(color: hintColor),
                labelStyle:
                    context.textTheme.caption.copyWith(color: hintColor),
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
                fillColor: fieldColor,
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: fieldColor)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: fieldColor)),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: fieldColor)),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              style: context.textTheme.caption, // Set the input text style
              initialValue: PhoneNumber.parse('+63'), // or use the controller
              validator: PhoneValidator.compose([
                PhoneValidator.required(context),
                PhoneValidator.validMobile(context)
              ]),
              countrySelectorNavigator: const CountrySelectorNavigator.page(),
              onChanged: (phoneNumber) => print('changed into $phoneNumber'),
              enabled: true,
              isCountrySelectionEnabled: true,
              isCountryButtonPersistent: true,
              countryButtonStyle: CountryButtonStyle(
                  showDropdownIcon: false,
                  showDialCode: true,
                  showIsoCode: false,
                  showFlag: true,
                  flagSize: 16,
                  textStyle: context
                      .textTheme.caption // Set the country code text style
                  )),
          const Spacer(),
          InstrabahoButton(
              label: 'Continue',
              onTap: () {
                context.pushNamed(RouterNames.otp);
              }),
          const Gap(50)
        ],
      ),
    ));
  }
}
