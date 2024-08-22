import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';

class Interviews extends StatelessWidget {
  const Interviews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              const _InterviewHeader(),
              const Gap(15),
              CustomExpansionTile(
                  title: "Test",
                  body: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Construction Worker',
                            style: FontStyles.subheader
                                .copyWith(fontWeight: FontWeight.w600)),
                        const Gap(5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("About the client",
                                style: FontStyles.subheader
                                    .copyWith(fontSize: 16)),
                            const Gap(10),
                            Row(
                              children: [
                                const Text("\$2.4K spent",
                                    style: FontStyles.tiny),
                                const Spacer(),
                                Text("1 job posted",
                                    style: FontStyles.tiny
                                        .copyWith(color: primaryColor)),
                              ],
                            ),
                          ],
                        ),
                        const Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Received Aug 19, 2024",
                                style: FontStyles.subheader
                                    .copyWith(fontSize: 16)),
                            Text("yesterday",
                                style: FontStyles.tiny
                                    .copyWith(color: primaryColor))
                          ],
                        )
                      ],
                    ),
                  )),
            ]),
          ),
        ],
      ),
    );
  }
}

class _InterviewHeader extends StatelessWidget {
  const _InterviewHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Interviews", style: TextStyle(fontSize: 24)),
          Text("You have 3 interviews scheduled",
              style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final Widget body;

  const CustomExpansionTile(
      {super.key, required this.title, required this.body});

  @override
  State<StatefulWidget> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("Initation to Interview (3)",
                        style: FontStyles.subheader),
                    const Spacer(),
                    Icon(_isExpanded ? Icons.expand_less : Icons.expand_more)
                  ],
                ),
                const Gap(10),
                DecoratedBox(
                    decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Row(children: [
                        Icon(Icons.handshake),
                        Gap(10),
                        Flexible(
                          child: Text(
                              "Workers who apply to a job when invited, are hired 5x more often."),
                        )
                      ]),
                    )),
                GestureDetector(
                  child: AnimatedContainer(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    duration: const Duration(milliseconds: 200),
                    height: _isExpanded ? null : 0,
                    child: Visibility(
                      visible: _isExpanded,
                      child: widget.body,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
