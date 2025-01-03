import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomSingleChildScrollView extends StatelessWidget {
  final List<Widget>? childrenWidget;
  final BuildContext context;

  const CustomSingleChildScrollView({
    super.key,
    required this.context,
    this.childrenWidget,
  });

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar();
    var pageSize = MediaQuery.of(this.context).size.height;
    var appBarSize = appBar.preferredSize.height;
    var bottomPadding = MediaQuery.of(this.context).padding.bottom;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        height: pageSize - bottomPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(appBarSize),
            if (childrenWidget != null) ...childrenWidget!,
          ],
        ),
      ),
    );
  }
}
