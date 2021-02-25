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
    kTuesday,
    kWednesday,
    kThursday,
    kFriday
  ];


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DocAssistCubit()..getData(),
      child: BlocConsumer<DocAssistCubit, DocAssistStates>(
          listener: (context, state) {
        if (state is DocAssistSwitchButtonState) {}
      }, builder: (context, state) {
        DoctorData doctorData = DocAssistCubit.get(context).doctorData;
        List<AvailabilityTimeList> clinicSelectedList = DocAssistCubit.get(context).clinicSelectedList;
        List<AvailabilityTimeList> voiceSelectedList = DocAssistCubit.get(context).voiceSelectedList;
        List<AvailabilityTimeList> videoSelectedList = DocAssistCubit.get(context).videoSelectedList;
        List<AvailabilityTimeList> spotSelectedList = DocAssistCubit.get(context).spotSelectedList;
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
                          initiallyExpanded: true,
                          expansionTitle:
                              '${doctorData.result.availabilityList[0].vendorAppointType}',
                          key: _clinicFormKey,
                          buildSwitchBtnValue:
                              DocAssistCubit.get(context).clinicSwitch,
                          buildSwitchBtnOnChange: (value) {
                            DocAssistCubit.get(context)
                                .toggleTheSwitch(value: value, index: 0);
                          },
                          buildTextFieldController: addPriceClinicController,
                          buildTextFieldValidator: (value) {
                            if (value.isEmpty) {
                              return 'Price';
                            }
                            return null;
                          },
                          list: ConditionalBuilder(
                            condition: clinicSelectedList.length != 0,
                            builder: (context) {
                              return ListView.separated(
                                itemBuilder: (context, index) {
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
                                          DocAssistCubit.get(context).selectWeekDay(value: selectedItem, index: 0);
                                        },
                                        value: DocAssistCubit.get(context).clinicSelectedDay,
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
                                itemCount: clinicSelectedList.length);
                            },
                            fallback: (context) => Center(
                              child: writeText14(
                                  title:
                                  'Add your\navailable time\nfrom the plus icon\nin the bottom left\ncorner',
                                  maxLines: 5),
                            ),
                          ),
                          drawCircleIconOnTap: () {},
                          buildButtonOnPressed: () {
                            if (_clinicFormKey.currentState.validate()) {
                              print('\n=========================================================');
                              print('${DocAssistCubit.get(context).voiceSwitch}' + '\n');
                              print(addPriceVoiceController.text + '\n');
                              print(DocAssistCubit.get(context).voiceSelectedDay + '\n');
                              print('=========================================================\n\n');
                              print('Saving Data');
                            }
                          }),
                    ),
                    SizedBox(
                      child: buildExpandedCard(
                          initiallyExpanded: false,
                          expansionTitle:
                              '${doctorData.result.availabilityList[1].vendorAppointType}',
                          key: _voiceFormKey,
                          buildSwitchBtnValue:
                              DocAssistCubit.get(context).voiceSwitch,
                          buildSwitchBtnOnChange: (value) {
                            DocAssistCubit.get(context)
                                .toggleTheSwitch(value: value, index: 1);
                          },
                          buildTextFieldController: addPriceVoiceController,
                          buildTextFieldValidator: (value) {
                            if (value.isEmpty) {
                              return 'Price';
                            }
                            return null;
                          },
                          list: ConditionalBuilder(
                            condition: voiceSelectedList.length != 0,
                            builder: (context) {
                              return  ListView.separated(
                                itemBuilder: (context, index) {

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
                                              .selectWeekDay(
                                                  value: selectedItem, index: 1);
                                        },
                                        value: DocAssistCubit.get(context).voiceSelectedDay,
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
                                itemCount: voiceSelectedList.length);},
                            fallback: (context) => Center(
                              child: writeText14(
                                  title:
                                  'Add your\navailable time\nfrom the plus icon\nin the bottom left\ncorner',
                                  maxLines: 5),
                            ),
                          ),
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
                              '${doctorData.result.availabilityList[2].vendorAppointType}',
                          key: _videoFormKey,
                          buildSwitchBtnValue:
                              DocAssistCubit.get(context).videoSwitch,
                          buildSwitchBtnOnChange: (value) {
                            DocAssistCubit.get(context)
                                .toggleTheSwitch(value: value, index: 2);
                          },
                          buildTextFieldController: addPriceVideoController,
                          buildTextFieldValidator: (value) {
                            if (value.isEmpty) {
                              return 'Price';
                            }
                            return null;
                          },
                          list: ConditionalBuilder(
                            condition: videoSelectedList.length != 0,
                            builder: (context) {
                              return   ListView.separated(
                                itemBuilder: (context, index) {

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
                                              .selectWeekDay(
                                                  value: selectedItem, index: 2);
                                        },
                                        value: DocAssistCubit.get(context).videoSelectedDay,
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
                                itemCount: videoSelectedList.length);},
                            fallback: (context) => Center(
                              child: writeText14(
                                  title:
                                  'Add your\navailable time\nfrom the plus icon\nin the bottom left\ncorner',
                                  maxLines: 5),
                            ),
                          ),
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
                              '${doctorData.result.availabilityList[3].vendorAppointType}',
                          key: _spotFormKey,
                          buildSwitchBtnValue:
                              DocAssistCubit.get(context).spotSwitch,
                          buildSwitchBtnOnChange: (value) {
                            DocAssistCubit.get(context)
                                .toggleTheSwitch(value: value, index: 3);
                          },
                          buildTextFieldController: addPriceSpotController,
                          buildTextFieldValidator: (value) {
                            if (value.isEmpty) {
                              return 'Price';
                            }
                            return null;
                          },

                          list: ConditionalBuilder(
                            condition: spotSelectedList.length != 0,
                            builder: (context) => ListView.separated(
                                itemBuilder: (context, index) {
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
                                                  value: selectedItem,
                                                  index: 3);
                                        },
                                        value: doctorData
                                                    .result
                                                    .availabilityList[3]
                                                    .availabilityTimeList
                                                    .length ==
                                                0
                                            ? 'Day'
                                            : DocAssistCubit.get(context)
                                                .spotSelectedDay,
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
                                itemCount: doctorData.result.availabilityList[3]
                                    .availabilityTimeList.length),
                            fallback: (context) => Center(
                              child: writeText14(
                                  title:
                                      'Add your\navailable time\nfrom the plus icon\nin the bottom left\ncorner',
                                  maxLines: 5),
                            ),
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
