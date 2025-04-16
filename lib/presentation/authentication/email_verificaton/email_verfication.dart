import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/authentication/profile/bloc/profile_bloc.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_single_child_scroll_view.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_textfield.dart';

import '../../../constant/styles/colors.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});

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
            "Please enter your email address. We’ll send you a code to verify your account.",
            style: context.textTheme.noteStyle),
        const Gap(32),
        InstrabahoTextField(
          hintText: 'Email Address',
          onChanged: (value) {
            BlocProvider.of<ProfileBloc>(context)
                .add(ProfileOnChangedEmail(value));
          },
        ),
        const Gap(24),
        BlocSelector<ProfileBloc, ProfileState, bool?>(
          selector: (state) {
            return state.email?.isValid;
          },
          builder: (context, state) {
            return InstrabahoButton(
                label: 'Continue',
                onTap: state == true
                    ? () {
                        context.pushNamed(RouterNames.phoneNumberVerification);
                      }
                    : null);
          },
        ),
        Gap(32),
        Center(child: Text("or")),
        Gap(32),
        SocialMediaAuthentication(actionText: 'Sign Up'),
        const Spacer(),
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "Already have an account? ",
              style: context.textTheme.noteStyle,
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.goNamed(RouterNames.login);
                    },
                  text: "Log in",
                  style: context.textTheme.noteStyle
                      .copyWith(color: C.blue600, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Gap(8)
      ],
    ));
  }
}

class SocialMediaAuthentication extends StatelessWidget {
  final String actionText;

  const SocialMediaAuthentication({
    super.key,
    required this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InstrabahoButton(
          label: '$actionText with Facebook',
          bgColor: Colors.white,
          borderColor: Color(0xff767676),
          outline: true,
          icon: SvgPicture.asset(Assets.svg.facebookLogo),
          onTap: () {
            // context.read<ProfileBloc>().add(ProfileOnGoogleSignIn());
          },
        ),
        Gap(16),
        InstrabahoButton(
          label: '$actionText with Google',
          bgColor: Colors.white,
          borderColor: Color(0xff767676),
          outline: true,
          icon: SvgPicture.asset(Assets.svg.googleLogo),
          onTap: () {
            // context.read<ProfileBloc>().add(ProfileOnGoogleSignIn());
          },
        ),
      ],
    );
  }
}
