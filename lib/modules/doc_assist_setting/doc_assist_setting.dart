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
            builder: (context) {

              addPriceClinicController.text = DocAssistCubit.get(context).availableLists[kVendorTypeClinic].priceValue ;
              addPriceVoiceController.text = DocAssistCubit.get(context).voiceAddPriceInitialText;
              addPriceVideoController.text = DocAssistCubit.get(context).videoAddPriceInitialText;
              addPriceSpotController.text = DocAssistCubit.get(context).spotAddPriceInitialText;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      child: buildExpandedCard(
                          initiallyExpanded: true,
                          expansionTitle:
                              '${DocAssistCubit.get(context).availableLists[kVendorTypeClinic].vendorAppointType}',
                          key: _clinicFormKey,
                          buildSwitchBtnValue:
                              DocAssistCubit.get(context).clinicSwitch,
                          buildSwitchBtnOnChange: (value) {
                            DocAssistCubit.get(context).toggleAndSaveSwitch(vendorType: kVendorTypeClinic, value: value);
                          },
                          buildTextFieldController: addPriceClinicController,
                          buildTextFieldValidator: (value) {
                            if (value.isEmpty) {
                              return 'Price';
                            }
                            return null;
                          },
                          list: ConditionalBuilder(
                            condition: DocAssistCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList.length != 0,
                            builder: (context) => ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Column(
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
                                              print(selectedItem);
                                              DocAssistCubit.get(context)
                                                  .selectAndSaveDay(
                                                      value: selectedItem,
                                                      vendorType: kVendorTypeClinic,
                                                      indexOfListLength: index);
                                            },
                                            value: DocAssistCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[index].wdayDayName,
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
                                                '${DocAssistCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[index].wdayFrom}' ??
                                                    'from',
                                            leftOnTap: () {
                                              DocAssistCubit.get(context).selectTime(
                                                  context: context,
                                                  index: index,
                                                  type: kPickDateDayFrom,
                                                  vendorType: kVendorTypeClinic
                                              );
                                            },
                                            rightTitle:
                                                '${DocAssistCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[index].wdayTo}' ??
                                                    'to',
                                            rightOnTap: () {
                                              DocAssistCubit.get(context).selectTime(
                                                  context: context,
                                                  index: index,
                                                  type: kPickDateDayTo,
                                                  vendorType: kVendorTypeClinic
                                              );
                                            }),
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
                                                '${DocAssistCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[index].wdayFrom2}' ??
                                                    'from',
                                            leftOnTap: () {
                                              DocAssistCubit.get(context).selectTime(
                                                  context: context,
                                                  index: index,
                                                  type: kPickDateNightFrom,
                                              vendorType: kVendorTypeClinic
                                              );
                                            },
                                            rightTitle:
                                                '${DocAssistCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[index].wdayTo2}' ??
                                                    'to',
                                            rightOnTap: () {
                                              DocAssistCubit.get(context).selectTime(
                                                  context: context,
                                                  index: index,
                                                  type: kPickDateNightTo,
                                                  vendorType: kVendorTypeClinic
                                              );
                                            }),

                                        SizedBox(
                                          height: 8,
                                        ),
                                        buildRemoveButton(
                                            onPressed: () {
                                              DocAssistCubit.get(context).removeThisDay(availableDayID: index, vendorType: kVendorTypeClinic);
                                            }, title: 'Remove This Day'),
                                      ],
                                    ),
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
                                itemCount: DocAssistCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList.length),
                            fallback: (context) => Center(
                              child: writeText14(
                                  title:
                                      'Add your\navailable time\nfrom the plus icon\nin the bottom left\ncorner',
                                  maxLines: 5),
                            ),
                          ),
                          drawCircleIconOnTap: () {
                            DocAssistCubit.get(context).addAvailableDayToTheList(vendorType: kVendorTypeClinic);
                          },
                          buildButtonOnPressed: () {
                            if (_clinicFormKey.currentState.validate()) {
                              DocAssistCubit.get(context).availableLists[kVendorTypeClinic].priceValue = addPriceClinicController.text;
                              DocAssistCubit.get(context).updateClinicData(
                                  clinicPrice: DocAssistCubit.get(context).availableLists[kVendorTypeClinic].priceValue,
                                  clinicDayListFirst: DocAssistCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[0].wdayDayName,
                                  clinicFromDayFirst: DocAssistCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[0].wdayFrom,
                                  clinicToDayFirst: DocAssistCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[0].wdayTo,
                                  clinicFromNightFirst: DocAssistCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[0].wdayFrom,
                                  clinicToNightFirst: DocAssistCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[0].wdayTo2,
                                  clinicDayListSecond: DocAssistCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[1].wdayDayName,
                                  clinicFromDaySecond: DocAssistCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[1].wdayFrom,
                                  clinicToDaySecond: DocAssistCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[1].wdayTo,
                                  clinicFromNightSecond: DocAssistCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[1].wdayFrom2,
                                  clinicToNightSecond: DocAssistCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[1].wdayTo2
                              );
                              showToast(message: 'First 2 Appointments Updated Successfully', error: false);
                              DocAssistCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList.map((day) {
                                print('=========================================');
                                print(day.wdayDayName);
                                print(day.wdayFrom);
                                print(day.wdayTo);
                                print(day.wdayFrom2);
                                print(day.wdayTo2);
                                print('=========================================');
                              }).toList();
                            }
                          }),
                    ),
                    // SizedBox(
                    //   child: buildExpandedCard(
                    //       initiallyExpanded: false,
                    //       expansionTitle:
                    //           '${doctorData.result.availabilityList[1].vendorAppointType}',
                    //       key: _voiceFormKey,
                    //       buildSwitchBtnValue:
                    //           DocAssistCubit.get(context).voiceSwitch,
                    //       buildSwitchBtnOnChange: (value) {
                    //         DocAssistCubit.get(context).toggleAndSaveSwitch(vendorType: kVendorTypeVoice, value: value);
                    //
                    //       },
                    //       buildTextFieldController: addPriceVoiceController,
                    //       buildTextFieldValidator: (value) {
                    //         if (value.isEmpty) {
                    //           return 'Price';
                    //         }
                    //         return null;
                    //       },
                    //       list: ConditionalBuilder(
                    //         condition: availableLists[kVendorTypeVoice].availabilityTimeList.length != 0,
                    //         builder: (context) {
                    //           return ListView.separated(
                    //               itemBuilder: (context, index) {
                    //                 return Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                           buildTDropdownButton(
                    //                         items: daysOfTheWeek.map((day) {
                    //                           return DropdownMenuItem(
                    //                             value: day,
                    //                             child: Text(day),
                    //                           );
                    //                         }).toList(),
                    //                             onChanged: (selectedItem) {
                    //                               print(selectedItem);
                    //                               DocAssistCubit.get(context)
                    //                                   .selectAndSaveDay(
                    //                                   value: selectedItem,
                    //                                   vendorType: kVendorTypeVoice,
                    //                                   indexOfListLength: index);
                    //                             },
                    //                             value: DocAssistCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList[index].wdayDayName,
                    //                           ),
                    //                     SizedBox(
                    //                       height: 16.0,
                    //                     ),
                    //                     // Day Shift
                    //                     writeText14(title: 'Day Shift'),
                    //                     SizedBox(
                    //                       height: 4.0,
                    //                     ),
                    //                     chooseDateRow(
                    //                         leftTitle:
                    //                             '${doctorData.result.availabilityList[1].availabilityTimeList[index].wdayFrom}' ??
                    //                                 'from',
                    //                         leftOnTap: () {},
                    //                         rightTitle:
                    //                             '${doctorData.result.availabilityList[1].availabilityTimeList[index].wdayTo}' ??
                    //                                 'to',
                    //                         rightOnTap: () {}),
                    //                     SizedBox(
                    //                       height: 16.0,
                    //                     ),
                    //                     // Night Shift
                    //                     Text(
                    //                       'Night Shift',
                    //                       maxLines: 1,
                    //                       overflow: TextOverflow.ellipsis,
                    //                       style: font14,
                    //                     ),
                    //                     SizedBox(
                    //                       height: 4.0,
                    //                     ),
                    //                     chooseDateRow(
                    //                         leftTitle:
                    //                             '${doctorData.result.availabilityList[1].availabilityTimeList[index].wdayFrom2}' ??
                    //                                 'from',
                    //                         leftOnTap: () {},
                    //                         rightTitle:
                    //                             '${doctorData.result.availabilityList[1].availabilityTimeList[index].wdayTo2}' ??
                    //                                 'to',
                    //                         rightOnTap: () {}),
                    //                   ],
                    //                 );
                    //               },
                    //               separatorBuilder: (context, index) => Column(
                    //                     children: [
                    //                       SizedBox(
                    //                         height: 8.0,
                    //                       ),
                    //                       drawDivider(),
                    //                       SizedBox(
                    //                         height: 8.0,
                    //                       ),
                    //                     ],
                    //                   ),
                    //               itemCount: availableLists[kVendorTypeVoice].availabilityTimeList.length);
                    //         },
                    //         fallback: (context) => Center(
                    //           child: writeText14(
                    //               title:
                    //                   'Add your\navailable time\nfrom the plus icon\nin the bottom left\ncorner',
                    //               maxLines: 5),
                    //         ),
                    //       ),
                    //       drawCircleIconOnTap: () {},
                    //       buildButtonOnPressed: () {
                    //         if (_voiceFormKey.currentState.validate()) {
                    //           print('Saving Data');
                    //         }
                    //       }),
                    // ),
                    // SizedBox(
                    //   child: buildExpandedCard(
                    //       initiallyExpanded: false,
                    //       expansionTitle:
                    //           '${doctorData.result.availabilityList[2].vendorAppointType}',
                    //       key: _videoFormKey,
                    //       buildSwitchBtnValue:
                    //           DocAssistCubit.get(context).videoSwitch,
                    //       buildSwitchBtnOnChange: (value) {
                    //         DocAssistCubit.get(context).toggleAndSaveSwitch(vendorType: kVendorTypeVideo, value: value);
                    //
                    //       },
                    //       buildTextFieldController: addPriceVideoController,
                    //       buildTextFieldValidator: (value) {
                    //         if (value.isEmpty) {
                    //           return 'Price';
                    //         }
                    //         return null;
                    //       },
                    //       list: ConditionalBuilder(
                    //         condition: availableLists[kVendorTypeVideo].availabilityTimeList.length != 0,
                    //         builder: (context) {
                    //           return ListView.separated(
                    //               itemBuilder: (context, index) {
                    //                 return Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                           buildTDropdownButton(
                    //                         items: daysOfTheWeek.map((day) {
                    //                           return DropdownMenuItem(
                    //                             value: day,
                    //                             child: Text(day),
                    //                           );
                    //                         }).toList(),
                    //                             onChanged: (selectedItem) {
                    //                               print(selectedItem);
                    //                               DocAssistCubit.get(context)
                    //                                   .selectAndSaveDay(
                    //                                   value: selectedItem,
                    //                                   vendorType: kVendorTypeVideo,
                    //                                   indexOfListLength: index);
                    //                             },
                    //                             value: DocAssistCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList[index].wdayDayName,
                    //
                    //                           ),
                    //                     SizedBox(
                    //                       height: 16.0,
                    //                     ),
                    //                     // Day Shift
                    //                     writeText14(title: 'Day Shift'),
                    //                     SizedBox(
                    //                       height: 4.0,
                    //                     ),
                    //                     chooseDateRow(
                    //                         leftTitle:
                    //                             '${doctorData.result.availabilityList[2].availabilityTimeList[index].wdayFrom}' ??
                    //                                 'from',
                    //                         leftOnTap: () {},
                    //                         rightTitle:
                    //                             '${doctorData.result.availabilityList[2].availabilityTimeList[index].wdayTo}' ??
                    //                                 'to',
                    //                         rightOnTap: () {}),
                    //                     SizedBox(
                    //                       height: 16.0,
                    //                     ),
                    //                     // Night Shift
                    //                     Text(
                    //                       'Night Shift',
                    //                       maxLines: 1,
                    //                       overflow: TextOverflow.ellipsis,
                    //                       style: font14,
                    //                     ),
                    //                     SizedBox(
                    //                       height: 4.0,
                    //                     ),
                    //                     chooseDateRow(
                    //                         leftTitle:
                    //                             '${doctorData.result.availabilityList[2].availabilityTimeList[index].wdayFrom2}' ??
                    //                                 'from',
                    //                         leftOnTap: () {},
                    //                         rightTitle:
                    //                             '${doctorData.result.availabilityList[2].availabilityTimeList[index].wdayTo2}' ??
                    //                                 'to',
                    //                         rightOnTap: () {}),
                    //                   ],
                    //                 );
                    //               },
                    //               separatorBuilder: (context, index) => Column(
                    //                     children: [
                    //                       SizedBox(
                    //                         height: 8.0,
                    //                       ),
                    //                       drawDivider(),
                    //                       SizedBox(
                    //                         height: 8.0,
                    //                       ),
                    //                     ],
                    //                   ),
                    //               itemCount: availableLists[kVendorTypeVideo].availabilityTimeList.length);
                    //         },
                    //         fallback: (context) => Center(
                    //           child: writeText14(
                    //               title:
                    //                   'Add your\navailable time\nfrom the plus icon\nin the bottom left\ncorner',
                    //               maxLines: 5),
                    //         ),
                    //       ),
                    //       drawCircleIconOnTap: () {},
                    //       buildButtonOnPressed: () {
                    //         if (_videoFormKey.currentState.validate()) {
                    //           print('Saving Data');
                    //         }
                    //       }),
                    // ),
                    // SizedBox(
                    //   child: buildExpandedCard(
                    //       initiallyExpanded: false,
                    //       expansionTitle:
                    //           '${doctorData.result.availabilityList[3].vendorAppointType}',
                    //       key: _spotFormKey,
                    //       buildSwitchBtnValue:
                    //           DocAssistCubit.get(context).spotSwitch,
                    //       buildSwitchBtnOnChange: (value) {
                    //         DocAssistCubit.get(context).toggleAndSaveSwitch(vendorType: kVendorTypeSpot, value: value);
                    //
                    //       },
                    //       buildTextFieldController: addPriceSpotController,
                    //       buildTextFieldValidator: (value) {
                    //         if (value.isEmpty) {
                    //           return 'Price';
                    //         }
                    //         return null;
                    //       },
                    //       list: ConditionalBuilder(
                    //         condition: availableLists[kVendorTypeSpot].availabilityTimeList.length != 0,
                    //         builder: (context) => ListView.separated(
                    //             itemBuilder: (context, index) {
                    //               return Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                         buildTDropdownButton(
                    //                       items: daysOfTheWeek.map((day) {
                    //                         return DropdownMenuItem(
                    //                           value: day,
                    //                           child: Text(day),
                    //                         );
                    //                       }).toList(),
                    //                           onChanged: (selectedItem) {
                    //                             print(selectedItem);
                    //                             DocAssistCubit.get(context)
                    //                                 .selectAndSaveDay(
                    //                                 value: selectedItem,
                    //                                 vendorType: kVendorTypeSpot,
                    //                                 indexOfListLength: index);
                    //                           },
                    //                           value: DocAssistCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList[index].wdayDayName,
                    //
                    //                         ),
                    //                   SizedBox(
                    //                     height: 16.0,
                    //                   ),
                    //                   // Day Shift
                    //                   writeText14(title: 'Day Shift'),
                    //                   SizedBox(
                    //                     height: 4.0,
                    //                   ),
                    //                   chooseDateRow(
                    //                       leftTitle: doctorData
                    //                                   .result
                    //                                   .availabilityList[3]
                    //                                   .availabilityTimeList
                    //                                   .length ==
                    //                               0
                    //                           ? 'from'
                    //                           : '${doctorData.result.availabilityList[3].availabilityTimeList[index].wdayFrom}',
                    //                       leftOnTap: () {},
                    //                       rightTitle: doctorData
                    //                                   .result
                    //                                   .availabilityList[3]
                    //                                   .availabilityTimeList
                    //                                   .length ==
                    //                               0
                    //                           ? 'to'
                    //                           : '${doctorData.result.availabilityList[3].availabilityTimeList[index].wdayTo}',
                    //                       rightOnTap: () {}),
                    //                   SizedBox(
                    //                     height: 16.0,
                    //                   ),
                    //                   // Night Shift
                    //                   Text(
                    //                     'Night Shift',
                    //                     maxLines: 1,
                    //                     overflow: TextOverflow.ellipsis,
                    //                     style: font14,
                    //                   ),
                    //                   SizedBox(
                    //                     height: 4.0,
                    //                   ),
                    //                   chooseDateRow(
                    //                       leftTitle: doctorData
                    //                                   .result
                    //                                   .availabilityList[3]
                    //                                   .availabilityTimeList
                    //                                   .length ==
                    //                               0
                    //                           ? 'from'
                    //                           : '${doctorData.result.availabilityList[3].availabilityTimeList[index].wdayFrom2}',
                    //                       leftOnTap: () {},
                    //                       rightTitle: doctorData
                    //                                   .result
                    //                                   .availabilityList[3]
                    //                                   .availabilityTimeList
                    //                                   .length ==
                    //                               0
                    //                           ? 'to'
                    //                           : '${doctorData.result.availabilityList[3].availabilityTimeList[index].wdayTo2}',
                    //                       rightOnTap: () {}),
                    //                 ],
                    //               );
                    //             },
                    //             separatorBuilder: (context, index) => Column(
                    //                   children: [
                    //                     SizedBox(
                    //                       height: 8.0,
                    //                     ),
                    //                     drawDivider(),
                    //                     SizedBox(
                    //                       height: 8.0,
                    //                     ),
                    //                   ],
                    //                 ),
                    //             itemCount: availableLists[kVendorTypeSpot].availabilityTimeList.length
                    //         ),
                    //
                    //
                    //
                    //
                    //
                    //
                    //         fallback: (context) => Center(
                    //           child: writeText14(
                    //               title:
                    //                   'Add your\navailable time\nfrom the plus icon\nin the bottom left\ncorner',
                    //               maxLines: 5),
                    //         ),
                    //       ),
                    //       drawCircleIconOnTap: () {},
                    //       buildButtonOnPressed: () {
                    //         if (_spotFormKey.currentState.validate()) {
                    //           print('Saving Data');
                    //         }
                    //       }),
                    // ),
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
