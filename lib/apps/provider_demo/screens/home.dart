import 'package:first_flutter/apps/provider_demo/providers/title_provider.dart';
import 'package:first_flutter/apps/provider_demo/dialog/change_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderHomeScreen extends StatelessWidget {
  const ProviderHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Demo'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return const SimpleDialog(
                      children: [
                        ChangeTitleDialog(),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.published_with_changes_rounded),
          )
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Text(
                context.watch<TitleProvider>().title,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
