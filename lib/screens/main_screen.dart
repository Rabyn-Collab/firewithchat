import 'package:flutter/material.dart';
import 'package:flutter_projects_start/provider/auth_provider.dart';
import 'package:flutter_projects_start/widgets/drawer_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MainScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final box = ref.watch(userProvider);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Text('Sample Shop'),

          ),
            drawer: DrawerWidget(),
            body: Container()
        );
      }
    );
  }
}
