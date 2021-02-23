import 'package:accura_kosba_task/layout/cubit/home_cubit.dart';
import 'package:accura_kosba_task/modules/welcome_screen/welcome_screen.dart';
import 'package:accura_kosba_task/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/home_screen.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   initApp();

    return  BlocProvider(
      create: (context) => HomeCubit()..getData(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Accura Task',
          home: WelcomeScreen(),
          // home: ManipulateScreen(),
        ),
    );
  }
}