import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/app_drawer.dart';
import '../components/pending_response_item.dart';

import '../models/pending_response_list.dart';
// import '../utils/app_routes.dart';
import 'dart:async';

class PendingResponsesPage extends StatefulWidget {
  const PendingResponsesPage({super.key});

  @override
  State<PendingResponsesPage> createState() => _PendingResponsesPageState();
}

class _PendingResponsesPageState extends State<PendingResponsesPage> {
  Future<void> _refreshPendingResponses(BuildContext context) {
    return Provider.of<PendingResponseList>(context, listen: false)
        .getPendingResponse();
  }

  int itemsCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Respostas Pendentes',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      drawer: const Drawer(
        backgroundColor: Colors.white,
        child: AppDrawer(),
      ),
      body: FutureBuilder(
        future: Provider.of<PendingResponseList>(context, listen: false)
            .getPendingResponse(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return const Center(
              child: Text('Ocorreu um erro!'),
            );
          } else {
            return Consumer<PendingResponseList>(
              builder: (ctx, responses, child) => RefreshIndicator(
                onRefresh: () => _refreshPendingResponses(context),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: responses.itemsCount,
                    itemBuilder: (ctx, i) => Column(
                      children: [
                        PendingResponseItem(responses.items[i]),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Provider.of<PatientNotificationService>(
      //       context,
      //       listen: false,
      //     ).add(PatientNotification(
      //       title: 'Mais uma notificação',
      //       body: Random().nextDouble().toString(),
      //     ));
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
