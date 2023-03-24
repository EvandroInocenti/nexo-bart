import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeDropdownButtonFormField extends StatelessWidget {
  String? label;
  String? value;
  void Function(String?)? onChanged;
  final List<DropdownMenuItem<String>>? items;

  AdaptativeDropdownButtonFormField({
    Key? key,
    Key? keyFormField,
    this.label,
    this.value,
    this.onChanged,
    this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPicker(
            magnification: 1.22,
            squeeze: 1.2,
            useMagnifier: true,
            itemExtent: 32.0,
            onSelectedItemChanged: (int selectedItem) {},
            children: [],
          )
        : DropdownButtonFormField<String>(
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
              border: const OutlineInputBorder(),
              label: Text(
                label!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            isExpanded: true,
            value: value,
            onChanged: onChanged,
            items: items,
          );
  }
}
