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
  });

  final Function(String)? onChanged;
  final String? hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final String? errorText;

  @override
  State<StatefulWidget> createState() => _InstrabahoTextFieldState();
}

class _InstrabahoTextFieldState extends State<InstrabahoTextField> {
  final bool _isObscure = true;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onChanged: widget.onChanged,
      obscureText: widget.isPassword ? _isObscure : false,
      validator: widget.validator,
      decoration: InputDecoration(
        errorText: widget.errorText,
        prefixStyle: context.textTheme.caption,
        counterStyle: context.textTheme.caption,
        suffixStyle: context.textTheme.caption,
        hintStyle: context.textTheme.caption.copyWith(color: hintColor),
        labelStyle: context.textTheme.caption.copyWith(color: hintColor),
        labelText: '${widget.hintText}',
        hintText: 'Enter your ${widget.hintText}',
        fillColor: fieldColor,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        focusedBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: fieldColor)),
        enabledBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: fieldColor)),
        border:
            const OutlineInputBorder(borderSide: BorderSide(color: fieldColor)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
