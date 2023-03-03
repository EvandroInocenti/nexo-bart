import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/patient.dart';
import '../models/tumor_list.dart';

class AdaptativeDropdownButtonFormField extends StatefulWidget {
  final Patient patient;
  const AdaptativeDropdownButtonFormField({
    Key? key,
    required this.patient,
  }) : super(key: key);

  @override
  State<AdaptativeDropdownButtonFormField> createState() =>
      _AdaptativeDropdownButtonFormFieldState();
}

class _AdaptativeDropdownButtonFormFieldState
    extends State<AdaptativeDropdownButtonFormField> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TumorList>(
      builder: (ctx, tumors, child) {
        return Platform.isIOS
            ? CupertinoPicker(
                magnification: 1.22,
                squeeze: 1.2,
                useMagnifier: true,
                itemExtent: 32.0,
                onSelectedItemChanged: (int selectedItem) {
                  setState(() {});
                },
                children: [],
              )
            : DropdownButtonFormField<String>(
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                  border: OutlineInputBorder(),
                  label: Text(
                    'Tumor',
                    style: TextStyle(
                        fontFamily: 'Mulish', fontSize: 18, color: Colors.grey),
                  ),
                ),
                value: widget.patient.tumor!.name,
                onChanged: (newValue) {
                  widget.patient.tumor!.name = newValue.toString();
                },
                items: tumors.items.map<DropdownMenuItem<String>>((tumor) {
                  return DropdownMenuItem(
                    value: tumor.name,
                    child: Text(tumor.name!),
                  );
                }).toList(),
              );
      },
    );
  }
}
