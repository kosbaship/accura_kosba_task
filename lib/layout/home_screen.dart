import 'package:accura_kosba_task/models/post.dart';
import 'package:accura_kosba_task/shared/colors.dart';
import 'package:accura_kosba_task/shared/component.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/home_cubit.dart';
import 'cubit/home_states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List listOfPostsData = HomeCubit.get(context).listOfPostsData;

        return Scaffold(
            appBar: AppBar(
              title: ConditionalBuilder(
                condition: listOfPostsData.length > 0,
                builder: (context) => Text(
                  '${listOfPostsData[1]['title']}',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'BoltSemiBold',
                      color: kSecondaryColor),
                ),
                fallback: (context) => Text(
                  'Task',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'BoltSemiBold',
                      color: kSecondaryColor),
                ),
              ),
              centerTitle: true,
            ),
            body: Center(
              child: ConditionalBuilder(
                  condition: state is! HomeLoadingState,
                  // builder: (context) => ConditionalBuilder(
                  //       condition: state is! HomeErrorState,
                  //       builder: (context) => buildList(list: listOfPostsData),
                  //       fallback: (context) => Center(
                  //           child: Text(
                  //         "No data found .. !",
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 22,
                  //         ),
                  //       )),
                  //     ),
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator())),
            ));
      },
    );
  }
}
