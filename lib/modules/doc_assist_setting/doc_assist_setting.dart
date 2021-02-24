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
  final addPriceClinicController = TextEditingController();
  final addPriceVoiceController = TextEditingController();
  final addPriceVideoController = TextEditingController();
  final addPriceSpotController = TextEditingController();
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
      create: (context) => DocAssistCubit()..getData(),
      child: BlocConsumer<DocAssistCubit, DocAssistStates>(
          listener: (context, state) {},
          builder: (context, state) {
            DoctorData doctorData = DocAssistCubit.get(context).doctorData;

            return Scaffold(
              backgroundColor: kSecondaryColor,
              appBar: drawAppBar(context: context),
              body: ConditionalBuilder(
                condition: state is! DocAssistLoadingState,
                builder: (context) {
                  // show the price from the db inside the tf
                  if (addPriceClinicController.text == '') {
                    addPriceClinicController.text =
                        doctorData.result.availabilityList[0].priceValue;
                  }
                  if (addPriceVoiceController.text == '') {
                    addPriceVoiceController.text =
                        doctorData.result.availabilityList[1].priceValue;
                  }
                  if (addPriceVideoController.text == '') {
                    addPriceVideoController.text =
                        doctorData.result.availabilityList[2].priceValue;
                  }
                  if (addPriceSpotController.text == '') {
                    addPriceSpotController.text =
                        doctorData.result.availabilityList[3].priceValue;
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          child: buildExpandedCard(
                              initiallyExpanded: false,
                              expansionTitle:
                                  '${doctorData.result.availabilityList[0].vendorAppointType}',
                              key: _clinicFormKey,
                              buildSwitchBtnValue: DocAssistCubit.get(context)
                                  .getSwitchValueByIndex(index: 0),
                              buildSwitchBtnOnChange: (value) {
                                DocAssistCubit.get(context)
                                    .toggleTheSwitch(value: value);
                              },
                              buildTextFieldController:
                                  addPriceClinicController,
                              buildTextFieldValidator: (value) {
                                if (value.isEmpty) {
                                  return 'Price';
                                }
                                return null;
                              },
                              list: ListView.separated(
                                  itemBuilder: (context, index) {
                                    // select the day from db
                                    switch (doctorData
                                        .result
                                        .availabilityList[0]
                                        .availabilityTimeList[index]
                                        .wdayDayName) {
                                      case 'saturday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kSaturday;
                                        break;
                                      case 'sunday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kSunday;
                                        break;
                                      case 'monday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kMonday;
                                        break;
                                      case 'tuesday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kTuesday;
                                        break;
                                      case 'wednesday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kWednesday;
                                        break;
                                      case 'thursday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kThursday;
                                        break;
                                      case 'friday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kFriday;
                                        break;
                                    }

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                .selectWeekDay(
                                                    value: selectedItem);
                                          },
                                          value: DocAssistCubit.get(context)
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
                                            leftTitle:
                                                '${doctorData.result.availabilityList[0].availabilityTimeList[index].wdayFrom}' ??
                                                    'from',
                                            leftOnTap: () {},
                                            rightTitle:
                                                '${doctorData.result.availabilityList[0].availabilityTimeList[index].wdayTo}' ??
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
                                            leftTitle:
                                                '${doctorData.result.availabilityList[0].availabilityTimeList[index].wdayFrom2}' ??
                                                    'from',
                                            leftOnTap: () {},
                                            rightTitle:
                                                '${doctorData.result.availabilityList[0].availabilityTimeList[index].wdayTo2}' ??
                                                    'to',
                                            rightOnTap: () {}),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) => Column(
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
                                  itemCount: doctorData
                                      .result
                                      .availabilityList[0]
                                      .availabilityTimeList
                                      .length),
                              drawCircleIconOnTap: () {},
                              buildButtonOnPressed: () {
                                if (_clinicFormKey.currentState.validate()) {
                                  print('Saving Data');
                                }
                              }),
                        ),
                        SizedBox(
                          child: buildExpandedCard(
                              initiallyExpanded: false,
                              expansionTitle:
                                  '${doctorData.result.availabilityList[1].vendorAppointType}',
                              key: _videoFormKey,
                              buildSwitchBtnValue: DocAssistCubit.get(context)
                                  .getSwitchValueByIndex(index: 1),
                              buildSwitchBtnOnChange: (value) {
                                DocAssistCubit.get(context)
                                    .toggleTheSwitch(value: value);
                              },
                              buildTextFieldController: addPriceVoiceController,
                              buildTextFieldValidator: (value) {
                                if (value.isEmpty) {
                                  return 'Price';
                                }
                                return null;
                              },
                              list: ListView.separated(
                                  itemBuilder: (context, index) {
                                    // select the day from db
                                    switch (doctorData
                                        .result
                                        .availabilityList[1]
                                        .availabilityTimeList[index]
                                        .wdayDayName) {
                                      case 'saturday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kSaturday;
                                        break;
                                      case 'sunday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kSunday;
                                        break;
                                      case 'monday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kMonday;
                                        break;
                                      case 'tuesday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kTuesday;
                                        break;
                                      case 'wednesday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kWednesday;
                                        break;
                                      case 'thursday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kThursday;
                                        break;
                                      case 'friday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kFriday;
                                        break;
                                    }

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                .selectWeekDay(
                                                    value: selectedItem);
                                          },
                                          value: DocAssistCubit.get(context)
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
                                            leftTitle:
                                                '${doctorData.result.availabilityList[1].availabilityTimeList[index].wdayFrom}' ??
                                                    'from',
                                            leftOnTap: () {},
                                            rightTitle:
                                                '${doctorData.result.availabilityList[1].availabilityTimeList[index].wdayTo}' ??
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
                                            leftTitle:
                                                '${doctorData.result.availabilityList[1].availabilityTimeList[index].wdayFrom2}' ??
                                                    'from',
                                            leftOnTap: () {},
                                            rightTitle:
                                                '${doctorData.result.availabilityList[1].availabilityTimeList[index].wdayTo2}' ??
                                                    'to',
                                            rightOnTap: () {}),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) => Column(
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
                                  itemCount: doctorData
                                      .result
                                      .availabilityList[1]
                                      .availabilityTimeList
                                      .length),
                              drawCircleIconOnTap: () {},
                              buildButtonOnPressed: () {
                                if (_videoFormKey.currentState.validate()) {
                                  print('Saving Data');
                                }
                              }),
                        ),
                        SizedBox(
                          child: buildExpandedCard(
                              initiallyExpanded: false,
                              expansionTitle:
                                  '${doctorData.result.availabilityList[2].vendorAppointType}',
                              key: _voiceFormKey,
                              buildSwitchBtnValue: DocAssistCubit.get(context)
                                  .getSwitchValueByIndex(index: 2),
                              buildSwitchBtnOnChange: (value) {
                                DocAssistCubit.get(context)
                                    .toggleTheSwitch(value: value);
                              },
                              buildTextFieldController: addPriceVideoController,
                              buildTextFieldValidator: (value) {
                                if (value.isEmpty) {
                                  return 'Price';
                                }
                                return null;
                              },
                              list: ListView.separated(
                                  itemBuilder: (context, index) {
                                    // select the day from db
                                    switch (doctorData
                                        .result
                                        .availabilityList[2]
                                        .availabilityTimeList[index]
                                        .wdayDayName) {
                                      case 'saturday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kSaturday;
                                        break;
                                      case 'sunday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kSunday;
                                        break;
                                      case 'monday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kMonday;
                                        break;
                                      case 'tuesday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kTuesday;
                                        break;
                                      case 'wednesday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kWednesday;
                                        break;
                                      case 'thursday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kThursday;
                                        break;
                                      case 'friday':
                                        DocAssistCubit.get(context)
                                            .selectedDay = kFriday;
                                        break;
                                    }

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                .selectWeekDay(
                                                    value: selectedItem);
                                          },
                                          value: DocAssistCubit.get(context)
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
                                            leftTitle:
                                                '${doctorData.result.availabilityList[2].availabilityTimeList[index].wdayFrom}' ??
                                                    'from',
                                            leftOnTap: () {},
                                            rightTitle:
                                                '${doctorData.result.availabilityList[2].availabilityTimeList[index].wdayTo}' ??
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
                                            leftTitle:
                                                '${doctorData.result.availabilityList[2].availabilityTimeList[index].wdayFrom2}' ??
                                                    'from',
                                            leftOnTap: () {},
                                            rightTitle:
                                                '${doctorData.result.availabilityList[2].availabilityTimeList[index].wdayTo2}' ??
                                                    'to',
                                            rightOnTap: () {}),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) => Column(
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
                                  itemCount: doctorData
                                      .result
                                      .availabilityList[2]
                                      .availabilityTimeList
                                      .length),
                              drawCircleIconOnTap: () {},
                              buildButtonOnPressed: () {
                                if (_voiceFormKey.currentState.validate()) {
                                  print('Saving Data');
                                }
                              }),
                        ),
                        SizedBox(
                          child: buildExpandedCard(
                              initiallyExpanded: false,
                              expansionTitle:
                                  '${doctorData.result.availabilityList[3].vendorAppointType}',
                              key: _spotFormKey,
                              buildSwitchBtnValue: DocAssistCubit.get(context)
                                  .getSwitchValueByIndex(index: 3),
                              buildSwitchBtnOnChange: (value) {
                                DocAssistCubit.get(context)
                                    .toggleTheSwitch(value: value);
                              },
                              buildTextFieldController: addPriceSpotController,
                              buildTextFieldValidator: (value) {
                                if (value.isEmpty) {
                                  return 'Price';
                                }
                                return null;
                              },
                              list: ConditionalBuilder(
                                condition: doctorData
                                    .result
                                    .availabilityList[3]
                                    .availabilityTimeList.length > 0,
                                builder: (context) =>  ListView.separated(
                                    itemBuilder: (context, index) {
                                      // select the day from db
                                      switch (doctorData
                                          .result
                                          .availabilityList[3]
                                          .availabilityTimeList[index]
                                          .wdayDayName) {
                                        case 'saturday':
                                          DocAssistCubit.get(context)
                                              .selectedDay = kSaturday;
                                          break;
                                        case 'sunday':
                                          DocAssistCubit.get(context)
                                              .selectedDay = kSunday;
                                          break;
                                        case 'monday':
                                          DocAssistCubit.get(context)
                                              .selectedDay = kMonday;
                                          break;
                                        case 'tuesday':
                                          DocAssistCubit.get(context)
                                              .selectedDay = kTuesday;
                                          break;
                                        case 'wednesday':
                                          DocAssistCubit.get(context)
                                              .selectedDay = kWednesday;
                                          break;
                                        case 'thursday':
                                          DocAssistCubit.get(context)
                                              .selectedDay = kThursday;
                                          break;
                                        case 'friday':
                                          DocAssistCubit.get(context)
                                              .selectedDay = kFriday;
                                          break;
                                      }

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                  .selectWeekDay(
                                                      value: selectedItem);
                                            },
                                            value: doctorData
                                                        .result
                                                        .availabilityList[3]
                                                        .availabilityTimeList
                                                        .length ==
                                                    0
                                                ? 'Day'
                                                : DocAssistCubit.get(context)
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
                                              leftTitle: doctorData
                                                          .result
                                                          .availabilityList[3]
                                                          .availabilityTimeList
                                                          .length ==
                                                      0
                                                  ? 'from'
                                                  : '${doctorData.result.availabilityList[3].availabilityTimeList[index].wdayFrom}',
                                              leftOnTap: () {},
                                              rightTitle: doctorData
                                                          .result
                                                          .availabilityList[3]
                                                          .availabilityTimeList
                                                          .length ==
                                                      0
                                                  ? 'to'
                                                  : '${doctorData.result.availabilityList[3].availabilityTimeList[index].wdayTo}',
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
                                              leftTitle: doctorData
                                                          .result
                                                          .availabilityList[3]
                                                          .availabilityTimeList
                                                          .length ==
                                                      0
                                                  ? 'from'
                                                  : '${doctorData.result.availabilityList[3].availabilityTimeList[index].wdayFrom2}',
                                              leftOnTap: () {},
                                              rightTitle: doctorData
                                                          .result
                                                          .availabilityList[3]
                                                          .availabilityTimeList
                                                          .length ==
                                                      0
                                                  ? 'to'
                                                  : '${doctorData.result.availabilityList[3].availabilityTimeList[index].wdayTo2}',
                                              rightOnTap: () {}),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) => Column(
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
                                    itemCount: doctorData
                                        .result
                                        .availabilityList[3]
                                        .availabilityTimeList
                                        .length),
                                fallback: (context) => Center(child: writeText14(title: 'Add your\navailable time\nfrom the plus icon\nin the bottom left\ncorner', maxLines: 5),),
                              ),
                              drawCircleIconOnTap: () {},
                              buildButtonOnPressed: () {
                                if (_spotFormKey.currentState.validate()) {
                                  print('Saving Data');
                                }
                              }),
                        ),
                      ],
                    ),
                  );
                },
                fallback: (context) => Center(
                    child: CircularProgressIndicator(
                  backgroundColor: kMainColor,
                )),
              ),
            );
          }),
    );
  }
}
