import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_text.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';

class UploadID extends StatelessWidget {
  const UploadID({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Color(0xFFFEF4EB), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // exclamation mark
              SvgPicture.asset(Assets.icon.caution),
              Gap(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText.defaultBold(
                      context,
                      'Verify your identity',
                      color: C.textColor,
                    ),
                    Gap(4),
                    Text(
                        "To ensure a safe and secure experience, please verify your identity."),
                  ],
                ),
              ),
            ],
          ),
          Gap(16),
          InstrabahoButton(
              padding: EdgeInsets.zero,
              height: 36,
              label: "Upload ID",
              onTap: () {},
              bgColor: C.orange600),
        ],
      ),
    );
  }
}
