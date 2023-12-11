import 'package:first_flutter/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/internal.dart';
import 'package:objectbox/objectbox.dart';

class StoreObjectBoxBody extends StatefulWidget {
  const StoreObjectBoxBody({super.key});

  @override
  State<StoreObjectBoxBody> createState() => _StoreObjectBoxBodyState();
}

class _StoreObjectBoxBodyState extends State<StoreObjectBoxBody> {
  late final _nameTextController = TextEditingController();
  late final _ageTextController = TextEditingController();
  final store = Store(getObjectBoxModel());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        color: Colors.amber[200],
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: _nameTextController,
                decoration: const InputDecoration(
                  label: Text('Name'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _ageTextController,
                decoration: const InputDecoration(
                  label: Text('Age'),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  return FocusManager.instance.primaryFocus?.unfocus();
                },
                child: const Text('Save'),
              )
              // Container(
              //   child: ListView.builder(
              //     itemCount: 5,
              //     itemBuilder: (ctx, index) {
              //       return ListTile(
              //         leading: Text('Index'),
              //         title: Text('Name'),
              //         trailing: Text('Age'),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
