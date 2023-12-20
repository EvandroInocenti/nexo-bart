import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nexo_onco/models/pending_response_list.dart';

import '../models/pending_response.dart';
import '../utils/app_routes.dart';

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

    // DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(strDate);
    var inputDate = DateTime.parse(strDate);
    var outputDate = DateFormat('dd-MM-yyyy').format(inputDate);

    return Material(
      elevation: 4,
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: ListTile(
        // leading: Icon(
        //   Icons.error_outline,
        //   color: Theme.of(context).colorScheme.secondary,
        // ),
        title: Text(
          "Pendente $outputDate",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          widget.pendingResponse.period!,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        trailing: SizedBox(
          width: 130,
          child: Row(
            children: [
              const SizedBox(width: 20),
              IconButton(
                icon: Icon(
                  Icons.error_outline,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  if (widget.pendingResponse.period! == 'Diário') {
                    Navigator.of(context).pushNamed(
                      AppRoutes.answresForm,
                      arguments: widget.pendingResponse,
                    );
                  } else {
                    Navigator.of(context).pushNamed(
                      AppRoutes.answresWeekForm,
                      arguments: widget.pendingResponse,
                    );
                  }
                  PendingResponseList().remove(widget.pendingResponse.id!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
