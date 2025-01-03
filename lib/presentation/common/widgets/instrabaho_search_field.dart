import 'package:flutter/material.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';

class InstrabahoSearchField extends StatefulWidget {
  const InstrabahoSearchField({
    super.key,
    this.onChanged,
    this.hintText,
    this.validator,
    this.errorText,
    this.controller,
  });

  final Function(String)? onChanged;
  final String? hintText;
  final String? Function(String?)? validator;
  final String? errorText;
  final TextEditingController? controller;

  @override
  State<StatefulWidget> createState() => _InstrabahoSearchFieldState();
}

class _InstrabahoSearchFieldState extends State<InstrabahoSearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: _controller,
        builder: (context, value, child) {
          return TextFormField(
            controller: _controller,
            onChanged: widget.onChanged,
            validator: widget.validator,
            decoration: InputDecoration(
              errorText: widget.errorText,
              prefixIcon: Icon(Icons.search, color: hintColor),
              suffixIcon: value.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear_rounded, color: hintColor),
                      onPressed: () {
                        _controller.clear();
                        if (widget.onChanged != null) {
                          widget.onChanged!('');
                        }
                      },
                    )
                  : null,
              hintStyle: context.textTheme.caption.copyWith(color: hintColor),
              labelStyle: context.textTheme.caption.copyWith(color: hintColor),
              hintText: widget.hintText ?? 'Search...',
              fillColor: fieldColor,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: fieldColor)),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: fieldColor)),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: fieldColor)),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          );
        },
      ),
    );
  }
}
