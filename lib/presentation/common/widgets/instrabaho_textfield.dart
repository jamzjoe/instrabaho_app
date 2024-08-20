import 'package:flutter/material.dart';

class InstrabahoTextField extends StatefulWidget {
  const InstrabahoTextField({
    super.key,
    this.onChanged,
    this.hintText,
    this.isPassword = false,
  });

  final Function(String)? onChanged;
  final String? hintText;
  final bool isPassword;

  @override
  State<StatefulWidget> createState() => _InstrabahoTextFieldState();
}

class _InstrabahoTextFieldState extends State<InstrabahoTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      obscureText: widget.isPassword ? _isObscure : false,
      decoration: InputDecoration(
        labelText: widget.hintText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
        suffixIcon: widget.isPassword
            ? Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              )
            : null,
      ),
    );
  }
}
