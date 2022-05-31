import 'package:flutter/material.dart';
import 'package:flutter_projects_start/provider/auth_provider.dart';
import 'package:flutter_projects_start/screens/auth_screen.dart';
import 'package:flutter_projects_start/screens/main_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class StatusScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, child) {
          final userData = ref.watch(userStream);
          return Scaffold(
            body: userData.when(
                data: (data){
                  if(data == null){
                    return AuthScreen();
                  }else{
                     return MainScreen();
                  }
                },
                error: (err, stack) => Center(child: Text('$err')),
                loading: () => Center(child: CircularProgressIndicator())
            ),
          );
        }
    );
  }
}
