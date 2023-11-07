import 'package:flutter/material.dart';

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
    return Material(
      elevation: 4,
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: ListTile(
        leading: const Icon(Icons.error_outline),
        title: Text(
          widget.pendingResponse.date! as String,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          widget.pendingResponse.title! + widget.pendingResponse.period!,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        trailing: SizedBox(
          width: 130,
          child: Row(
            children: [
              Flexible(
                child: Icon(
                  Icons.error_outline,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
