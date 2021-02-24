import 'package:accura_kosba_task/modules/welcome_screen/welcome_screen.dart';
import 'package:accura_kosba_task/shared/colors.dart';
import 'package:accura_kosba_task/shared/component.dart';
import 'package:flutter/material.dart';


void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   initApp();

    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Accura Task',
        theme: ThemeData(
          primarySwatch: kMaterialColor
        ),
        home: WelcomeScreen(),
        // home: ManipulateScreen(),
      );
  }
}