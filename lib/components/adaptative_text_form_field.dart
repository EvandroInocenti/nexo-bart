import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextFormField extends StatelessWidget {
  final String? initialValue;
  final String label;
  final bool obscureText;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  TextInputType? keyboardType;
  FocusNode? focusNode;
  Function(String)? onFieldSubmitted;

  AdaptativeTextFormField({
    Key? key,
    this.initialValue,
    required this.label,
    required this.obscureText,
    required this.textInputAction,
    this.validator,
    required this.onSaved,
    this.keyboardType,
    this.focusNode,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextFormFieldRow(
            initialValue: initialValue,
            placeholder: label,
            textInputAction: textInputAction,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            onSaved: onSaved,
            validator: validator,
            keyboardType: keyboardType,
            obscureText: obscureText,
          )
        : TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              label: Text(label, style: Theme.of(context).textTheme.bodyMedium),
              border: const OutlineInputBorder(gapPadding: 3),
              contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
            ),
            textInputAction: textInputAction,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            onSaved: onSaved,
            validator: validator,
            keyboardType: keyboardType,
            obscureText: obscureText,
          );
  }
}
