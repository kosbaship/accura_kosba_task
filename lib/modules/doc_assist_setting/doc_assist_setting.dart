import 'package:accura_kosba_task/models/get_doctor.dart';
import 'package:accura_kosba_task/shared/colors.dart';
import 'package:accura_kosba_task/shared/component.dart';
import 'package:accura_kosba_task/shared/constants.dart';
import 'package:accura_kosba_task/shared/styels.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/doc_assist_cubit.dart';
import 'cubit/doc_assist_states.dart';

class DocAssistSetting extends StatelessWidget {
  final addPriceController = TextEditingController();
  final _clinicFormKey = GlobalKey<FormState>();
  final _voiceFormKey = GlobalKey<FormState>();
  final _videoFormKey = GlobalKey<FormState>();
  final _spotFormKey = GlobalKey<FormState>();

  final List<String> daysOfTheWeek = [
    kDay,
    kSaturday,
    kSunday,
    kMonday,
    kThursday,
    kWednesday,
    kThursday,
    kFriday
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      DocAssistCubit()
        ..getData(),
      child: BlocConsumer<DocAssistCubit, DocAssistStates>(
          listener: (context, state) {},
          builder: (context, state) {
            DoctorData doctorData = DocAssistCubit
                .get(context)
                .doctorData;

            return Scaffold(
              backgroundColor: kSecondaryColor,
              appBar: drawAppBar(context: context),
              body: ConditionalBuilder(
                condition: state is! DocAssistLoadingState,
                builder: (context) {
                  // show the price from the db inside the tf
                  if (addPriceController.text == '') {
                    addPriceController.text =
                        doctorData.result.availabilityList[0].priceValue;
                  }

                  return SingleChildScrollView(
                    child: Column(
                        children: [

                    // =====================
                    buildExpandedCard(
                      initiallyExpanded: true,
                      expansionTitle:
                      '${doctorData.result.availabilityList[0]
                          .vendorAppointType}',
                      key: _clinicFormKey,
                      buildSwitchBtnValue: DocAssistCubit
                          .get(context)
                          .switchValue,
                      buildSwitchBtnOnChange: (value) {
                        DocAssistCubit.get(context).toggleTheSwitch(
                            value: value);
                      },
                      buildTextFieldController: addPriceController,
                      buildTextFieldValidator: (value) {
                        if (value.isEmpty) {
                          return 'Price';
                        }
                        return null;
                      },
                      list: ListView.separated(
                          itemBuilder: (context, index) {
                            // select the day from db
                            switch (doctorData.result.availabilityList[0]
                                .availabilityTimeList[index].wdayDayName) {
                              case 'saturday':
                                DocAssistCubit
                                    .get(context)
                                    .selectedDay = kSaturday;
                                break;
                              case 'sunday':
                                DocAssistCubit
                                    .get(context)
                                    .selectedDay = kSunday;
                                break;
                              case 'monday':
                                DocAssistCubit
                                    .get(context)
                                    .selectedDay = kMonday;
                                break;
                              case 'tuesday':
                                DocAssistCubit
                                    .get(context)
                                    .selectedDay = kTuesday;
                                break;
                              case 'wednesday':
                                DocAssistCubit
                                    .get(context)
                                    .selectedDay = kWednesday;
                                break;
                              case 'thursday':
                                DocAssistCubit
                                    .get(context)
                                    .selectedDay = kThursday;
                                break;
                              case 'friday':
                                DocAssistCubit
                                    .get(context)
                                    .selectedDay = kFriday;
                                break;
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                  value: DocAssistCubit
                                      .get(context)
                                      .selectedDay,
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
                                    leftTitle: '${doctorData.result
                                        .availabilityList[0]
                                        .availabilityTimeList[index]
                                        .wdayFrom}' ?? 'from',
                                    leftOnTap: () {},
                                    rightTitle: '${doctorData.result
                                        .availabilityList[0]
                                        .availabilityTimeList[index].wdayTo}' ??
                                        'to',
                                    rightOnTap: () {}),
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
                                    leftTitle: '${doctorData.result
                                        .availabilityList[0]
                                        .availabilityTimeList[index]
                                        .wdayFrom2}' ?? 'from',
                                    leftOnTap: () {},
                                    rightTitle: '${doctorData.result
                                        .availabilityList[0]
                                        .availabilityTimeList[index]
                                        .wdayTo2}' ?? 'to',
                                    rightOnTap: () {}),

                              ],





                            );
                          },
                          separatorBuilder: (context, index) =>
                              Column(
                                children: [
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  drawDivider(),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                ],
                              ),
                          itemCount: doctorData.result.availabilityList[0].availabilityTimeList.length
                      ),
                        drawCircleIconOnTap: () {},
                        buildButtonOnPressed: () {
                          if (_clinicFormKey.currentState.validate()) {
                            print('Saving Data');
                          }
                        }
                    ) ],
                    ),
                  );
                },
                fallback: (context) =>
                    Center(
                        child: CircularProgressIndicator(
                          backgroundColor: kMainColor,
                        )),
              ),
            );
          }),
    );
  }
}
