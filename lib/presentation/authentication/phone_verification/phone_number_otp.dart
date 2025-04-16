import 'dart:async';
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
import 'package:pinput/pinput.dart';

class PhoneNumberOtp extends StatefulWidget {
  const PhoneNumberOtp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PhoneNumberOtpState();
  }
}

class _PhoneNumberOtpState extends State<PhoneNumberOtp> {
  Timer? _timer;
  int _start = 30;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _start = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

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
        Text("Verify your mobile number", style: context.textTheme.appBarFont),
        const Gap(8),
        Text(
            "We’ve sent a 6-digit code to +63 912 345 6789. Enter it below to verify your account.",
            style: context.textTheme.noteStyle),
        const Gap(32),
        Center(
          child: Pinput(
            onChanged: (value) {
              log("OTP value: $value");
              BlocProvider.of<ProfileBloc>(context).add(ProfileOnOTPValidation(
                  otp: value,
                  isOtpValid: value.isNotEmpty && value.length == 6));
            },
            length: 6,
            defaultPinTheme: PinTheme(
                constraints:
                    const BoxConstraints.tightFor(width: 55, height: 55),
                decoration: BoxDecoration(
                  color: C.fieldColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: C.hintColor),
                )),
            focusedPinTheme: PinTheme(
                constraints:
                    const BoxConstraints.tightFor(width: 55, height: 55),
                decoration: BoxDecoration(
                  color: const Color(0xffE6E6E6),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: C.blue600),
                )),
          ),
        ),
        const Gap(16),
        Center(
            child: GestureDetector(
          onTap: () {
            if (_start == 0) {
              startTimer();
            }
          },
          child: Text(
              _start > 0
                  ? 'Didn’t receive the code? Resend in $_start seconds.'
                  : 'Resend code',
              style: context.textTheme.instruction),
        )),
        const Spacer(),
        BlocSelector<ProfileBloc, ProfileState, bool>(
          selector: (state) {
            return state.isOtpValid;
          },
          builder: (context, state) {
            return InstrabahoButton(
                label: 'Verify',
                onTap: state
                    ? () {
                        context.pushNamed(RouterNames.completeProfile);
                      }
                    : null);
          },
        ),
      ],
    ));
  }
}
