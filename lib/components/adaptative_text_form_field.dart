import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdaptativeTextFormField extends StatelessWidget {
  final String? initialValue;
  final String label;
  final bool obscureText;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  // final TextEditingController? controller;
  TextInputType? keyboardType;
  FocusNode? focusNode;
  Function(String)? onFieldSubmitted;
  List<TextInputFormatter>? inputFormatters;

  AdaptativeTextFormField({
    Key? key,
    this.initialValue,
    required this.label,
    required this.obscureText,
    required this.textInputAction,
    this.validator,
    required this.onSaved,
    // this.controller,
    this.keyboardType,
    this.focusNode,
    this.onFieldSubmitted,
    this.inputFormatters,
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
            inputFormatters: inputFormatters,
            // controller: controller,
          )
        : TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              label: Text(label, style: Theme.of(context).textTheme.bodyMedium),
              border: const OutlineInputBorder(gapPadding: 3),
              contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
            ),
            textInputAction: textInputAction,
            // controller: controller,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            onSaved: onSaved,
            validator: validator,
            keyboardType: keyboardType,
            obscureText: obscureText,
            inputFormatters: inputFormatters,
          );
  }
}
