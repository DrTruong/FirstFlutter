import 'package:first_flutter/apps/refresh_loadmore_gridview/screens/body.dart';
import 'package:flutter/material.dart';

class RefreshLoadmoreGridViewScreen extends StatelessWidget {
  const RefreshLoadmoreGridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GridView - Refresh & Load more'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      body: const RefreshLoadmoreGridviewBody(),
    );
  }
}
