import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/pending_response.dart';

class PendingResponseItem extends StatefulWidget {
  final PendingResponse pendingResponse;
  const PendingResponseItem(this.pendingResponse, {super.key});

  @override
  State<PendingResponseItem> createState() => _PendingResponseItemState();
}

class _PendingResponseItemState extends State<PendingResponseItem> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var strDate = widget.pendingResponse.date!;
    DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(strDate);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy');
    var outputDate = outputFormat.format(inputDate);

    return Material(
      elevation: 4,
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: ListTile(
        leading: Icon(
          Icons.error_outline,
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          "Pendente $outputDate",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          widget.pendingResponse.period!,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
