import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';

import '../../../gen/assets.gen.dart';

class InstrabahoTextField extends StatefulWidget {
  const InstrabahoTextField({
    super.key,
    this.onChanged,
    this.hintText,
    this.isPassword = false,
    this.validator,
    this.errorText,
    this.maxLines = 1,
    this.fieldColor,
    this.controller,
    this.keyboardType,
  });

  final Function(String)? onChanged;
  final String? hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final String? errorText;
  final int maxLines;
  final Color? fieldColor;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  @override
  State<StatefulWidget> createState() => _InstrabahoTextFieldState();

  factory InstrabahoTextField.password({
    required Function(String) onChanged,
    required String hintText,
    TextEditingController? controller,
    String? errorText,
    String? Function(String?)? validator,
  }) {
    return InstrabahoTextField(
      onChanged: onChanged,
      hintText: hintText,
      errorText: errorText,
      validator: validator,
      controller: controller,
      isPassword: true,
    );
  }
}

class _InstrabahoTextFieldState extends State<InstrabahoTextField> {
  late final TextEditingController _controller;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (value) {
        FocusScope.of(context).unfocus();
      },
      inputFormatters: [
        //number only
        if (widget.keyboardType == TextInputType.number)
          FilteringTextInputFormatter.digitsOnly
      ],
      controller: _controller,
      onChanged: widget.onChanged,
      obscureText: widget.isPassword ? _isObscure : false,
      validator: widget.validator,
      maxLines: widget.maxLines,
      textAlign: TextAlign.start, // Align text to the start
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        errorText: widget.errorText,
        prefixStyle: context.textTheme.caption,
        counterStyle: context.textTheme.caption,
        suffixStyle: context.textTheme.caption,
        alignLabelWithHint: true,
        hintStyle: context.textTheme.caption.copyWith(color: C.hintColor),
        labelStyle: context.textTheme.caption.copyWith(color: C.hintColor),
        labelText: '${widget.hintText}',
        hintText: widget.hintText,
        fillColor: widget.fieldColor ?? C.fieldColor,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.fieldColor ?? C.blue600)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.fieldColor ?? C.fieldColor)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: widget.fieldColor ?? C.fieldColor)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: _isObscure
                    ? SvgPicture.asset(Assets.svg.eyesClose)
                    : SvgPicture.asset(Assets.svg.eyesOpen),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              )
            : null,
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
