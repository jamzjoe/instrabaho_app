import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:pinput/pinput.dart';

class PhoneNumberOtp extends StatelessWidget {
  const PhoneNumberOtp({super.key});

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
          Text("Verify your mobile number",
              style: context.textTheme.appBarFont),
          const Gap(8),
          Text(
              "We’ve sent a 6-digit code to +63 912 345 6789. Enter it below to verify your account.",
              style: context.textTheme.noteStyle),
          const Gap(32),
          Center(
            child: Pinput(
              length: 6,
              defaultPinTheme: PinTheme(
                  constraints:
                      const BoxConstraints.tightFor(width: 55, height: 55),
                  decoration: BoxDecoration(
                    color: fieldColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: hintColor),
                  )),
              focusedPinTheme: PinTheme(
                  constraints:
                      const BoxConstraints.tightFor(width: 55, height: 55),
                  decoration: BoxDecoration(
                    color: const Color(0xffE6E6E6),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: secondaryColor),
                  )),
            ),
          ),
          const Gap(16),
          Center(
              child: Text('Didn’t receive the code? Resend in 30 seconds.',
                  style: context.textTheme.instruction)),
          const Spacer(),
          InstrabahoButton(label: 'Verify', onTap: () {}),
          const Gap(50)
        ],
      ),
    ));
  }
}
