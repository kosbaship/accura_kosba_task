import 'package:accura_kosba_task/shared/colors.dart';
import 'package:accura_kosba_task/shared/component.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/doc_assist_cubit.dart';
import 'cubit/doc_assist_states.dart';

class DocAssistSetting extends StatelessWidget {
  final addPriceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> daysOfTheWeek = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DocAssistCubit()..getData(),
      child: BlocConsumer<DocAssistCubit, DocAssistStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              backgroundColor: kSecondaryColor,
              appBar: drawAppBar(context: context),
              body: ConditionalBuilder(
                condition: state is! DocAssistLoadingState,
                builder: (context) => SingleChildScrollView(
                  child: Column(
                    children: [
                      buildExpandedCard(
                          initiallyExpanded: true,
                          expansionTitle: 'Clinic',
                          key: _formKey,
                          buildSwitchBtnValue:
                              DocAssistCubit.get(context).switchValue,
                          buildSwitchBtnOnChange: (value) {
                            DocAssistCubit.get(context)
                                .toggleTheSwitch(value: value);
                          },
                          buildTextFieldController: addPriceController,
                          buildTextFieldValidator: (value) {
                            if (value.isEmpty) {
                              return 'Price';
                            }
                            return null;
                          },
                          buildTDropdownButtonItems: daysOfTheWeek.map((day) {
                            return DropdownMenuItem(
                              value: day,
                              child: Text(day),
                            );
                          }).toList(),
                          buildTDropdownButtonOnChanged: (selectedItem) {
                            DocAssistCubit.get(context)
                                .selectWeekDay(value: selectedItem);
                          },
                          buildTDropdownButtonValue:
                              DocAssistCubit.get(context).selectedDay,
                          dayShiftChooseDateFrom: () {},
                          dayShiftChooseDateTo: () {},
                          nightShiftChooseDateFrom: () {},
                          nightShiftChooseDateTo: () {},
                          drawCircleIconOnTap: () {},
                          buildButtonOnPressed: () {
                            if (_formKey.currentState.validate()) {
                              print('Saving Data');
                            }
                          }),
                    ],
                  ),
                ),
                fallback: (context) => Center(child: CircularProgressIndicator(backgroundColor: kMainColor,)),
              ),
            );
          }),
    );
  }
}
