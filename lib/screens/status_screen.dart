import 'package:flutter/material.dart';
import 'package:flutter_projects_start/provider/auth_provider.dart';
import 'package:flutter_projects_start/screens/auth_screen.dart';
import 'package:flutter_projects_start/screens/main_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class StatusScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final boxData = ref.watch(userProvider);
              return boxData.isEmpty ? AuthScreen():  MainScreen();
            }
    )
    );
  }
}
