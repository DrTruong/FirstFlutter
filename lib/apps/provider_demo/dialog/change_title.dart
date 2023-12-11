import 'package:first_flutter/apps/provider_demo/providers/title_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeTitleDialog extends StatefulWidget {
  const ChangeTitleDialog({super.key});

  @override
  State<ChangeTitleDialog> createState() => _ChangeTitleDialogState();
}

class _ChangeTitleDialogState extends State<ChangeTitleDialog> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 50,
        right: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _textController,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: const Text('New title'),
                hintText: 'Old title: ${context.watch<TitleProvider>().title}'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context
                  .read<TitleProvider>()
                  .changeTitle(newTitle: _textController.text);
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.of(context).pop();
            },
            child: Text('Change to ${_textController.text}'),
          )
        ],
      ),
    );
  }
}
