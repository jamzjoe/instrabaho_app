import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:ionicons/ionicons.dart';

class InstrabahoDropdownTextField extends StatefulWidget {
  const InstrabahoDropdownTextField({
    super.key,
    this.onChanged,
    this.hintText,
    this.isPassword = false,
    this.validator,
    this.errorText,
    this.maxLines = 1,
    this.fieldColor,
    this.controller,
    this.options,
    this.labelText,
  });

  final Function(String)? onChanged;
  final String? hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final String? errorText;
  final int maxLines;
  final Color? fieldColor;
  final TextEditingController? controller;
  final List<String>? options; // List of options for dropdown
  final String? labelText; // Label text for floating label

  @override
  State<StatefulWidget> createState() => _InstrabahoDropdownTextFieldState();
}

class _InstrabahoDropdownTextFieldState
    extends State<InstrabahoDropdownTextField> {
  late final TextEditingController _controller;
  bool _isObscure = true;
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return widget.options != null && widget.options!.isNotEmpty
        ? DropdownButtonFormField2<String>(
            value: _selectedOption,
            onChanged: (String? newValue) {
              setState(() {
                _selectedOption = newValue;
                _controller.text = newValue ?? '';
                if (widget.onChanged != null) {
                  widget.onChanged!(newValue ?? '');
                }
              });
            },
            validator: widget.validator,
            decoration: InputDecoration(
              labelText: widget.labelText,
              errorText: widget.errorText,
              fillColor: widget.fieldColor ?? C.fieldColor,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: -5, vertical: 10),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: widget.fieldColor ?? C.fieldColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: widget.fieldColor ?? C.fieldColor),
              ),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: widget.fieldColor ?? C.fieldColor),
              ),
              hintStyle: context.textTheme.caption.copyWith(color: C.hintColor),
            ),
            items: widget.options!
                .map((option) => DropdownMenuItem<String>(
                      value: option,
                      child: Text(option, style: context.textTheme.bodyMedium),
                    ))
                .toList(),
            hint: Text(widget.hintText ?? '',
                style: context.textTheme.noteStyle
                    .copyWith(color: C.hintColor, fontSize: 14)),
            iconStyleData: IconStyleData(
              icon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child:
                    Icon(Ionicons.chevron_down, color: C.textColor, size: 20),
              ),
            ), // Custom icon
          )
        : TextFormField(
            controller: _controller,
            onChanged: widget.onChanged,
            obscureText: widget.isPassword ? _isObscure : false,
            validator: widget.validator,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              labelText: widget.labelText,
              errorText: widget.errorText,
              hintText: widget.hintText,
              fillColor: widget.fieldColor ?? C.fieldColor,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: widget.fieldColor ?? C.fieldColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: widget.fieldColor ?? C.fieldColor),
              ),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: widget.fieldColor ?? C.fieldColor),
              ),
              hintStyle: context.textTheme.caption.copyWith(color: C.hintColor),
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
