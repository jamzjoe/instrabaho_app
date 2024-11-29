import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop();
      },
      child: Container(
          padding: const EdgeInsets.only(left: 16),
          child: SvgPicture.asset(Assets.svg.customBackButton)),
    );
  }
}
