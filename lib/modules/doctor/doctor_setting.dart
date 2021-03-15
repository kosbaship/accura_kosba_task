import 'package:accura_kosba_task/shared/colors.dart';
import 'package:accura_kosba_task/shared/component.dart';
import 'package:accura_kosba_task/shared/constants.dart';
import 'package:accura_kosba_task/shared/styels.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/setting_cubit/doctor_setting_cubit.dart';
import 'cubit/setting_cubit/doctor_setting_states.dart';

class DoctorSetting extends StatelessWidget {
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
      create: (context) => DoctorSettingCubit()..getData(),
      child: BlocConsumer<DoctorSettingCubit, DoctorSettingStates>(
          listener: (context, state) {},
          builder: (context, state) {


        return Scaffold(
          backgroundColor: kSecondaryColor,
          appBar: drawAppBar(context: context),
          body: ConditionalBuilder(
            condition: state is! DoctorSettingLoadingState,
            builder: (context) {

              addPriceClinicController.text = DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].priceValue ;
              addPriceVoiceController.text = DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].priceValue;
              addPriceVideoController.text = DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].priceValue;
              addPriceSpotController.text = DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].priceValue;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      child: buildExpandedCard(
                          initiallyExpanded: false,
                          expansionTitle:
                              '${DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].vendorAppointType}',
                          key: _clinicFormKey,
                          buildSwitchBtnValue:
                              DoctorSettingCubit.get(context).clinicSwitch,
                          buildSwitchBtnOnChange: (value) {
                            DoctorSettingCubit.get(context).toggleAndSaveSwitch(vendorType: kVendorTypeClinic, value: value);
                          },
                          buildTextFieldController: addPriceClinicController,
                          buildTextFieldValidator: (value) {
                            if (value.isEmpty) {
                              return 'Price';
                            }
                            return null;
                          },
                          list: ConditionalBuilder(
                            condition: DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList.length != 0,
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
                                              DoctorSettingCubit.get(context)
                                                  .selectAndSaveDay(
                                                      value: selectedItem,
                                                      vendorType: kVendorTypeClinic,
                                                      indexOfListLength: index);
                                            },
                                            value: DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[index].wdayDayName,
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
                                                '${DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[index].wdayFrom}' ??
                                                    'from',
                                            leftOnTap: () {
                                              DoctorSettingCubit.get(context).selectTime(
                                                  context: context,
                                                  index: index,
                                                  type: kPickDateDayFrom,
                                                  vendorType: kVendorTypeClinic
                                              );
                                            },
                                            rightTitle:
                                                '${DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[index].wdayTo}' ??
                                                    'to',
                                            rightOnTap: () {
                                              DoctorSettingCubit.get(context).selectTime(
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
                                                '${DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[index].wdayFrom2}' ??
                                                    'from',
                                            leftOnTap: () {
                                              DoctorSettingCubit.get(context).selectTime(
                                                  context: context,
                                                  index: index,
                                                  type: kPickDateNightFrom,
                                              vendorType: kVendorTypeClinic
                                              );
                                            },
                                            rightTitle:
                                                '${DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[index].wdayTo2}' ??
                                                    'to',
                                            rightOnTap: () {
                                              DoctorSettingCubit.get(context).selectTime(
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
                                              DoctorSettingCubit.get(context).removeThisDay(availableDayID: index, vendorType: kVendorTypeClinic);
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
                                itemCount: DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList.length),
                            fallback: (context) => Center(
                              child: writeText14(
                                  title:
                                      'Add your\navailable time\nfrom the plus icon\nin the bottom left\ncorner',
                                  maxLines: 5),
                            ),
                          ),
                          drawCircleIconOnTap: () {
                            DoctorSettingCubit.get(context).addAvailableDayToTheList(vendorType: kVendorTypeClinic);
                          },
                          buildButtonOnPressed: () {
                            if (_clinicFormKey.currentState.validate()) {
                              DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].priceValue = addPriceClinicController.text;
                              DoctorSettingCubit.get(context).updateClinicData(
                                  clinicPrice: DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].priceValue,
                                  clinicDayListFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[0].wdayDayName,
                                  clinicFromDayFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[0].wdayFrom,
                                  clinicToDayFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[0].wdayTo,
                                  clinicFromNightFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[0].wdayFrom,
                                  clinicToNightFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[0].wdayTo2,
                                  clinicDayListSecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[1].wdayDayName,
                                  clinicFromDaySecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[1].wdayFrom,
                                  clinicToDaySecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[1].wdayTo,
                                  clinicFromNightSecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[1].wdayFrom2,
                                  clinicToNightSecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList[1].wdayTo2
                              );
                              showToast(message: 'First 2 Appointments Updated Successfully', error: false);
                              DoctorSettingCubit.get(context).availableLists[kVendorTypeClinic].availabilityTimeList.map((day) {
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
                    //           '${DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].vendorAppointType}',
                    //       key: _voiceFormKey,
                    //       buildSwitchBtnValue:
                    //           DoctorSettingCubit.get(context).voiceSwitch,
                    //       buildSwitchBtnOnChange: (value) {
                    //         DoctorSettingCubit.get(context).toggleAndSaveSwitch(vendorType: kVendorTypeVoice, value: value);
                    //       },
                    //       buildTextFieldController: addPriceVoiceController,
                    //       buildTextFieldValidator: (value) {
                    //         if (value.isEmpty) {
                    //           return 'Price';
                    //         }
                    //         return null;
                    //       },
                    //       list: ConditionalBuilder(
                    //         condition: DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].availabilityTimeList.length != 0,
                    //         builder: (context) => ListView.separated(
                    //             shrinkWrap: true,
                    //             itemBuilder: (context, index) => Column(
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
                    //                         onChanged: (selectedItem) {
                    //                           print(selectedItem);
                    //                           DoctorSettingCubit.get(context)
                    //                               .selectAndSaveDay(
                    //                                   value: selectedItem,
                    //                                   vendorType: kVendorTypeVoice,
                    //                                   indexOfListLength: index);
                    //                         },
                    //                         value: DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].availabilityTimeList[index].wdayDayName,
                    //                       ),
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
                    //                             '${DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].availabilityTimeList[index].wdayFrom}' ??
                    //                                 'from',
                    //                         leftOnTap: () {
                    //                           DoctorSettingCubit.get(context).selectTime(
                    //                               context: context,
                    //                               index: index,
                    //                               type: kPickDateDayFrom,
                    //                               vendorType: kVendorTypeVoice
                    //                           );
                    //                         },
                    //                         rightTitle:
                    //                             '${DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].availabilityTimeList[index].wdayTo}' ??
                    //                                 'to',
                    //                         rightOnTap: () {
                    //                           DoctorSettingCubit.get(context).selectTime(
                    //                               context: context,
                    //                               index: index,
                    //                               type: kPickDateDayTo,
                    //                               vendorType: kVendorTypeVoice
                    //                           );
                    //                         }),
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
                    //                             '${DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].availabilityTimeList[index].wdayFrom2}' ??
                    //                                 'from',
                    //                         leftOnTap: () {
                    //                           DoctorSettingCubit.get(context).selectTime(
                    //                               context: context,
                    //                               index: index,
                    //                               type: kPickDateNightFrom,
                    //                           vendorType: kVendorTypeVoice
                    //                           );
                    //                         },
                    //                         rightTitle:
                    //                             '${DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].availabilityTimeList[index].wdayTo2}' ??
                    //                                 'to',
                    //                         rightOnTap: () {
                    //                           DoctorSettingCubit.get(context).selectTime(
                    //                               context: context,
                    //                               index: index,
                    //                               type: kPickDateNightTo,
                    //                               vendorType: kVendorTypeVoice
                    //                           );
                    //                         }),

                    //                     SizedBox(
                    //                       height: 8,
                    //                     ),
                    //                     buildRemoveButton(
                    //                         onPressed: () {
                    //                           DoctorSettingCubit.get(context).removeThisDay(availableDayID: index, vendorType: kVendorTypeVoice);
                    //                         }, title: 'Remove This Day'),
                    //                   ],
                    //                 ),
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
                    //             itemCount: DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].availabilityTimeList.length),
                    //         fallback: (context) => Center(
                    //           child: writeText14(
                    //               title:
                    //                   'Add your\navailable time\nfrom the plus icon\nin the bottom left\ncorner',
                    //               maxLines: 5),
                    //         ),
                    //       ),
                    //       drawCircleIconOnTap: () {
                    //         DoctorSettingCubit.get(context).addAvailableDayToTheList(vendorType: kVendorTypeVoice);
                    //       },
                    //       buildButtonOnPressed: () {
                    //         if (_voiceFormKey.currentState.validate()) {
                    //           DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].priceValue = addPriceVoiceController.text;
                    //           DoctorSettingCubit.get(context).updateVoiceData(
                    //               voicePrice: DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].priceValue,
                    //               voiceDayListFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].availabilityTimeList[0].wdayDayName,
                    //               voiceFromDayFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].availabilityTimeList[0].wdayFrom,
                    //               voiceToDayFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].availabilityTimeList[0].wdayTo,
                    //               voiceFromNightFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].availabilityTimeList[0].wdayFrom,
                    //               voiceToNightFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].availabilityTimeList[0].wdayTo2,
                    //               // voiceDayListSecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].availabilityTimeList[1].wdayDayName,
                    //               // voiceFromDaySecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].availabilityTimeList[1].wdayFrom,
                    //               // voiceToDaySecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].availabilityTimeList[1].wdayTo,
                    //               // voiceFromNightSecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].availabilityTimeList[1].wdayFrom2,
                    //               // voiceToNightSecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].availabilityTimeList[1].wdayTo2
                    //           );
                    //           showToast(message: 'First 2 Appointments Updated Successfully', error: false);
                    //           DoctorSettingCubit.get(context).availableLists[kVendorTypeVoice].availabilityTimeList.map((day) {
                    //             print('=========================================');
                    //             print(day.wdayDayName);
                    //             print(day.wdayFrom);
                    //             print(day.wdayTo);
                    //             print(day.wdayFrom2);
                    //             print(day.wdayTo2);
                    //             print('=========================================');
                    //           }).toList();
                    //         }
                    //       }),
                    // ),
                    // SizedBox(
                    //   child: buildExpandedCard(
                    //       initiallyExpanded: false,
                    //       expansionTitle:
                    //           '${DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].vendorAppointType}',
                    //       key: _videoFormKey,
                    //       buildSwitchBtnValue:
                    //           DoctorSettingCubit.get(context).videoSwitch,
                    //       buildSwitchBtnOnChange: (value) {
                    //         DoctorSettingCubit.get(context).toggleAndSaveSwitch(vendorType: kVendorTypeVideo, value: value);
                    //       },
                    //       buildTextFieldController: addPriceVideoController,
                    //       buildTextFieldValidator: (value) {
                    //         if (value.isEmpty) {
                    //           return 'Price';
                    //         }
                    //         return null;
                    //       },
                    //       list: ConditionalBuilder(
                    //         condition: DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList.length != 0,
                    //         builder: (context) => ListView.separated(
                    //             shrinkWrap: true,
                    //             itemBuilder: (context, index) => Column(
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
                    //                         onChanged: (selectedItem) {
                    //                           print(selectedItem);
                    //                           DoctorSettingCubit.get(context)
                    //                               .selectAndSaveDay(
                    //                                   value: selectedItem,
                    //                                   vendorType: kVendorTypeVideo,
                    //                                   indexOfListLength: index);
                    //                         },
                    //                         value: DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList[index].wdayDayName,
                    //                       ),
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
                    //                             '${DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList[index].wdayFrom}' ??
                    //                                 'from',
                    //                         leftOnTap: () {
                    //                           DoctorSettingCubit.get(context).selectTime(
                    //                               context: context,
                    //                               index: index,
                    //                               type: kPickDateDayFrom,
                    //                               vendorType: kVendorTypeVideo
                    //                           );
                    //                         },
                    //                         rightTitle:
                    //                             '${DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList[index].wdayTo}' ??
                    //                                 'to',
                    //                         rightOnTap: () {
                    //                           DoctorSettingCubit.get(context).selectTime(
                    //                               context: context,
                    //                               index: index,
                    //                               type: kPickDateDayTo,
                    //                               vendorType: kVendorTypeVideo
                    //                           );
                    //                         }),
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
                    //                             '${DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList[index].wdayFrom2}' ??
                    //                                 'from',
                    //                         leftOnTap: () {
                    //                           DoctorSettingCubit.get(context).selectTime(
                    //                               context: context,
                    //                               index: index,
                    //                               type: kPickDateNightFrom,
                    //                           vendorType: kVendorTypeVideo
                    //                           );
                    //                         },
                    //                         rightTitle:
                    //                             '${DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList[index].wdayTo2}' ??
                    //                                 'to',
                    //                         rightOnTap: () {
                    //                           DoctorSettingCubit.get(context).selectTime(
                    //                               context: context,
                    //                               index: index,
                    //                               type: kPickDateNightTo,
                    //                               vendorType: kVendorTypeVideo
                    //                           );
                    //                         }),

                    //                     SizedBox(
                    //                       height: 8,
                    //                     ),
                    //                     buildRemoveButton(
                    //                         onPressed: () {
                    //                           DoctorSettingCubit.get(context).removeThisDay(availableDayID: index, vendorType: kVendorTypeVideo);
                    //                         }, title: 'Remove This Day'),
                    //                   ],
                    //                 ),
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
                    //             itemCount: DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList.length),
                    //         fallback: (context) => Center(
                    //           child: writeText14(
                    //               title:
                    //                   'Add your\navailable time\nfrom the plus icon\nin the bottom left\ncorner',
                    //               maxLines: 5),
                    //         ),
                    //       ),
                    //       drawCircleIconOnTap: () {
                    //         DoctorSettingCubit.get(context).addAvailableDayToTheList(vendorType: kVendorTypeVideo);
                    //       },
                    //       buildButtonOnPressed: () {
                    //         DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList.map((day) {
                    //           print('=========================================');
                    //           print(day.wdayDayName);
                    //           print(day.wdayFrom);
                    //           print(day.wdayTo);
                    //           print(day.wdayFrom2);
                    //           print(day.wdayTo2);
                    //           print('=========================================');
                    //         }).toList();
                    //         if (_videoFormKey.currentState.validate()) {
                    //           DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].priceValue = addPriceVideoController.text;
                    //           DoctorSettingCubit.get(context).updateVideoData(
                    //               videoPrice: DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].priceValue,
                    //               videoDayListFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList[0].wdayDayName,
                    //               videoFromDayFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList[0].wdayFrom,
                    //               videoToDayFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList[0].wdayTo,
                    //               videoFromNightFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList[0].wdayFrom,
                    //               videoToNightFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList[0].wdayTo2,
                    //               // videoDayListSecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList[1].wdayDayName,
                    //               // videoFromDaySecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList[1].wdayFrom,
                    //               // videoToDaySecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList[1].wdayTo,
                    //               // videoFromNightSecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList[1].wdayFrom2,
                    //               // videoToNightSecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeVideo].availabilityTimeList[1].wdayTo2
                    //           );
                    //           showToast(message: 'First 2 Appointments Updated Successfully', error: false);

                    //         }
                    //       }),
                    // ),
                    // SizedBox(
                    //   child: buildExpandedCard(
                    //       initiallyExpanded: false,
                    //       expansionTitle:
                    //           '${DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].vendorAppointType}',
                    //       key: _spotFormKey,
                    //       buildSwitchBtnValue:
                    //           DoctorSettingCubit.get(context).spotSwitch,
                    //       buildSwitchBtnOnChange: (value) {
                    //         DoctorSettingCubit.get(context).toggleAndSaveSwitch(vendorType: kVendorTypeSpot, value: value);
                    //       },
                    //       buildTextFieldController: addPriceSpotController,
                    //       buildTextFieldValidator: (value) {
                    //         if (value.isEmpty) {
                    //           return 'Price';
                    //         }
                    //         return null;
                    //       },
                    //       list: ConditionalBuilder(
                    //         condition: DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList.length != 0,
                    //         builder: (context) => ListView.separated(
                    //             shrinkWrap: true,
                    //             itemBuilder: (context, index) => Column(
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
                    //                         onChanged: (selectedItem) {
                    //                           print(selectedItem);
                    //                           DoctorSettingCubit.get(context)
                    //                               .selectAndSaveDay(
                    //                                   value: selectedItem,
                    //                                   vendorType: kVendorTypeSpot,
                    //                                   indexOfListLength: index);
                    //                         },
                    //                         value: DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList[index].wdayDayName,
                    //                       ),
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
                    //                             '${DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList[index].wdayFrom}' ??
                    //                                 'from',
                    //                         leftOnTap: () {
                    //                           DoctorSettingCubit.get(context).selectTime(
                    //                               context: context,
                    //                               index: index,
                    //                               type: kPickDateDayFrom,
                    //                               vendorType: kVendorTypeSpot
                    //                           );
                    //                         },
                    //                         rightTitle:
                    //                             '${DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList[index].wdayTo}' ??
                    //                                 'to',
                    //                         rightOnTap: () {
                    //                           DoctorSettingCubit.get(context).selectTime(
                    //                               context: context,
                    //                               index: index,
                    //                               type: kPickDateDayTo,
                    //                               vendorType: kVendorTypeSpot
                    //                           );
                    //                         }),
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
                    //                             '${DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList[index].wdayFrom2}' ??
                    //                                 'from',
                    //                         leftOnTap: () {
                    //                           DoctorSettingCubit.get(context).selectTime(
                    //                               context: context,
                    //                               index: index,
                    //                               type: kPickDateNightFrom,
                    //                           vendorType: kVendorTypeSpot
                    //                           );
                    //                         },
                    //                         rightTitle:
                    //                             '${DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList[index].wdayTo2}' ??
                    //                                 'to',
                    //                         rightOnTap: () {
                    //                           DoctorSettingCubit.get(context).selectTime(
                    //                               context: context,
                    //                               index: index,
                    //                               type: kPickDateNightTo,
                    //                               vendorType: kVendorTypeSpot
                    //                           );
                    //                         }),

                    //                     SizedBox(
                    //                       height: 8,
                    //                     ),
                    //                     buildRemoveButton(
                    //                         onPressed: () {
                    //                           DoctorSettingCubit.get(context).removeThisDay(availableDayID: index, vendorType: kVendorTypeSpot);
                    //                         }, title: 'Remove This Day'),
                    //                   ],
                    //                 ),
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
                    //             itemCount: DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList.length),
                    //         fallback: (context) => Center(
                    //           child: writeText14(
                    //               title:
                    //                   'Add your\navailable time\nfrom the plus icon\nin the bottom left\ncorner',
                    //               maxLines: 5),
                    //         ),
                    //       ),
                    //       drawCircleIconOnTap: () {
                    //         DoctorSettingCubit.get(context).addAvailableDayToTheList(vendorType: kVendorTypeSpot);
                    //       },
                    //       buildButtonOnPressed: () {
                    //         if (_spotFormKey.currentState.validate()) {
                    //           DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].priceValue = addPriceSpotController.text;
                    //           DoctorSettingCubit.get(context).updateSpotData(
                    //               spotPrice: DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].priceValue,
                    //               spotDayListFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList[0].wdayDayName,
                    //               spotFromDayFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList[0].wdayFrom,
                    //               spotToDayFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList[0].wdayTo,
                    //               spotFromNightFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList[0].wdayFrom,
                    //               spotToNightFirst: DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList[0].wdayTo2,
                    //               // spotDayListSecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList[1].wdayDayName,
                    //               // spotFromDaySecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList[1].wdayFrom,
                    //               // spotToDaySecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList[1].wdayTo,
                    //               // spotFromNightSecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList[1].wdayFrom2,
                    //               // spotToNightSecond: DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList[1].wdayTo2
                    //           );
                    //           showToast(message: 'First 2 Appointments Updated Successfully', error: false);
                    //           DoctorSettingCubit.get(context).availableLists[kVendorTypeSpot].availabilityTimeList.map((day) {
                    //             print('=========================================');
                    //             print(day.wdayDayName);
                    //             print(day.wdayFrom);
                    //             print(day.wdayTo);
                    //             print(day.wdayFrom2);
                    //             print(day.wdayTo2);
                    //             print('=========================================');
                    //           }).toList();
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
