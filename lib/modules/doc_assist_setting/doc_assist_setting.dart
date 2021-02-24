import 'package:accura_kosba_task/shared/colors.dart';
import 'package:accura_kosba_task/shared/component.dart';
import 'package:accura_kosba_task/shared/styels.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
      create: (context) => DocAssistCubit(),
      child: BlocConsumer<DocAssistCubit, DocAssistStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              backgroundColor: kSecondaryColor,
              appBar: drawAppBar(context: context),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                        top: BorderSide(
                          width: 1,
                          color: kExpansionBorderColor,
                        ),
                      )),
                      child: ExpansionTileCard(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        finalPadding: EdgeInsets.zero,
                        baseColor: kExpansionBGColor,
                        expandedColor: kExpansionBGColor,
                        initiallyExpanded: true,
                        elevation: 0.0,
                        title: Text(
                          'Clinic',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: font18.copyWith(color: kExpansionTitleColor),
                        ),
                        onExpansionChanged: (value) {},
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 14),
                            decoration: BoxDecoration(
                                color: kSecondaryColor,
                                border: Border(
                                    top: BorderSide(
                                  width: 1,
                                  color: kExpansionBorderColor,
                                ))),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // switch button
                                  Text(
                                    'Activation',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: font14,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Off',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: font14.copyWith(
                                            color: kTitleGreyColor,),
                                      ),
                                      buildSwitchBtn(
                                        value: DocAssistCubit.get(context).switchValue,
                                        onChanged: (value) {
                                          DocAssistCubit.get(context)
                                              .toggleTheSwitch(value: value);
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  drawDivider(),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  // add price
                                  Text(
                                    'Pricing',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: font14,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'add price',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: font14.copyWith(
                                            color: kTitleGreyColor),
                                      ),
                                      Container(
                                        width: 110,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              right: 9,
                                              top: 8.5,
                                              child: Text(
                                                'EGP',
                                                style: font12,
                                              ),
                                            ),
                                            buildTextFormField(
                                              controller: addPriceController,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Price';
                                                }
                                                return null;
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  drawDivider(),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  // choose day
                                  Text(
                                    'Available',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: font14,
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  buildTDropdownButton(
                                    items: daysOfTheWeek.map((day) {
                                      return DropdownMenuItem(
                                        value: day,
                                        child: Text(day),
                                      );
                                    }).toList(),
                                    onChanged: (selectedItem) {
                                      DocAssistCubit.get(context)
                                          .selectWeekDay(value: selectedItem);
                                    },
                                    value: DocAssistCubit.get(context).selectedDay,
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  // Day Shift
                                  writeText14(title: 'Day Shift'),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  chooseDateRow(
                                    leftTitle:  'from',
                                      leftOnTap: (){},
                                      rightTitle: 'to',
                                    rightOnTap: (){}
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  // Night Shift
                                  Text(
                                    'Night Shift',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: font14,
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  chooseDateRow(
                                      leftTitle:  'from',
                                      leftOnTap: (){},
                                      rightTitle: 'to',
                                      rightOnTap: (){}
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [

                                      drawCircleIcon(),
                                      Container(
                                        height: 50.0,
                                        width: 150.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: kSecondaryColor,
                                        ),
                                        child: buildSaveButton(
                                            onPressed: () {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                print('Saving Data');
                                              }
                                            },
                                            title: 'Save Settings'
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
