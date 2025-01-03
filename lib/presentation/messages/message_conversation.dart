import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_textfield.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/search_bloc.dart';
import 'package:lottie/lottie.dart';

class MessagesConversationScreen extends StatefulWidget {
  const MessagesConversationScreen({super.key});
  @override
  _MessagesConversationScreenState createState() =>
      _MessagesConversationScreenState();
}

class _MessagesConversationScreenState
    extends State<MessagesConversationScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
        // listenWhen: (previous, current) =>
        //     previous.activeWorker?.isHired != current.activeWorker?.isHired,
        listener: (context, state) {
      //show modal for lottie animation
      if (state.activeWorker?.isHired == true) {
        //show modal for lottie animation
        final worker = state.activeWorker;
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LottieBuilder.asset(
                          Assets.json.handshake,
                          repeat: false,
                          onLoaded: (p0) {
                            //add delay before closing the dialog
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.of(context).pop();
                            });
                          },
                        ),
                        Gap(10),
                        RichText(
                          text: TextSpan(
                            text: '${worker?.name} ',
                            style: FontStyles.caption.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'is now hired!',
                                style: FontStyles.caption.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      }
    }, builder: (context, state) {
      final worker = state.activeWorker;
      return Scaffold(
          appBar: AppBar(
            title:
                Text(worker?.name ?? '', style: context.textTheme.titleLarge),
          ),
          body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (worker?.isHired == false || worker?.isHired == null)
                    InstrabahoButton(
                        icon: SvgPicture.asset(
                          Assets.svg.handshake,
                          width: 30,
                          colorFilter:
                              ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                        label: 'Hire Worker',
                        onTap: () {
                          BlocProvider.of<SearchBloc>(context)
                              .add(SearchSetActiveWorker(worker!));
                        }),
                  Gap(10),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'By hiring worker, you agree to the ',
                      style: FontStyles.hintStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'terms and conditions',
                          style: FontStyles.hintStyle.copyWith(
                              color: secondaryColor,
                              decoration: TextDecoration.underline),
                        ),
                        TextSpan(
                          text: ' of Instrabaho.',
                          style: FontStyles.hintStyle,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: InstrabahoTextField(
                          controller: _messageController,
                          hintText: 'Type your message...',
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          // Handle send message
                          print('Message sent: ${_messageController.text}');
                          _messageController.clear();
                        },
                      ),
                    ],
                  ),
                ],
              )));
    });
  }
}
