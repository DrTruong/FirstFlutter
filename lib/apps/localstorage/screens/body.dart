import 'package:first_flutter/apps/localstorage/localstrorage/localstorage_service.dart';
import 'package:first_flutter/apps/localstorage/models/user_model.dart';
import 'package:flutter/material.dart';

class LocalStorageBody extends StatefulWidget {
  const LocalStorageBody({super.key});

  @override
  State<LocalStorageBody> createState() => _LocalStorageBodyState();
}

class _LocalStorageBodyState extends State<LocalStorageBody> {
  final nameTextController = TextEditingController();
  final ageTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 85, right: 85),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 100),
          TextField(
            controller: nameTextController,
            decoration: const InputDecoration(
              label: Text('Name'),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: ageTextController,
            decoration: const InputDecoration(
              label: Text('Age'),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final prefs = await LocalStorageService.getInstance();
              prefs.save(
                Keys.key1,
                User(
                  name: nameTextController.text,
                  age: int.parse(ageTextController.text),
                ),
              );
            },
            child: const Text('Save into LocalStorage'),
          ),
          ElevatedButton(
            onPressed: () async {
              final prefs = await LocalStorageService.getInstance();
              final data = await prefs.read(Keys.key1);
              if (data != null) {
                User user = User.fromJson(data);
                debugPrint(user.name.toString());
                debugPrint(user.age.toString());
              } else {
                debugPrint(data);
              }
            },
            child: const Text('Get user from LocalStorage'),
          ),
          ElevatedButton(
            onPressed: () async {
              final prefs = await LocalStorageService.getInstance();
              prefs.remove(Keys.key1);
            },
            child: const Text('Remove usre from LocalStorage'),
          )
        ],
      ),
    );
  }
}
