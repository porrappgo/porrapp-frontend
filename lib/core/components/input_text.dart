import 'package:flutter/material.dart';
import 'package:porrapp_frontend/core/components/components.dart';

class InputText extends StatefulWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final IconData? prefixIcon;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  const InputText({
    Key? key,
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.prefixIcon,
    required this.onChanged,
    this.validator,
    this.textInputAction,
    this.keyboardType = TextInputType.none,
  }) : super(key: key);

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      decoration: InputDecorations.decoration(
        labelText: widget.label,
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon,
        isPassword: widget.isPassword,
        isObscure: _obscureText,
        onTogglePasswordVisibility: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
    );
  }
}
