import 'package:flutter/material.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';

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
  });

  final Function(String)? onChanged;
  final String? hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final String? errorText;
  final int maxLines;
  final Color? fieldColor;
  final TextEditingController? controller;

  @override
  State<StatefulWidget> createState() => _InstrabahoTextFieldState();
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
      controller: _controller,
      onChanged: widget.onChanged,
      obscureText: widget.isPassword ? _isObscure : false,
      validator: widget.validator,
      maxLines: widget.maxLines,
      textAlign: TextAlign.start, // Align text to the start
      decoration: InputDecoration(
        errorText: widget.errorText,
        prefixStyle: context.textTheme.caption,
        counterStyle: context.textTheme.caption,
        suffixStyle: context.textTheme.caption,
        alignLabelWithHint: true,
        hintStyle: context.textTheme.caption.copyWith(color: hintColor),
        labelStyle: context.textTheme.caption.copyWith(color: hintColor),
        labelText: '${widget.hintText}',
        hintText: widget.hintText,
        fillColor: widget.fieldColor ?? fieldColor,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.fieldColor ?? fieldColor)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.fieldColor ?? fieldColor)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: widget.fieldColor ?? fieldColor)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
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
