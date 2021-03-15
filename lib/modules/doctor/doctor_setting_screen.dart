import 'package:accura_kosba_task/shared/colors.dart';
import 'package:accura_kosba_task/shared/component.dart';
import 'package:accura_kosba_task/shared/helper_class_config.dart';
import 'package:accura_kosba_task/shared/helper_classes.dart';
import 'package:accura_kosba_task/shared/styels.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'cubit/doctor_setting_cubit/doctor_setting_cubit.dart';
import 'cubit/doctor_setting_cubit/doctor_setting_states.dart';
import 'cubit/doctor_setting_widgets/activation_row_widgets.dart';
import 'cubit/doctor_setting_widgets/pricing_row_widgets.dart';

class DoctorSetting extends StatelessWidget {
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
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 90,
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: <Widget>[
                          ListView.builder(
                              itemCount: 4,
                              itemBuilder: (context, appoinmentTypeIndex) {
                                return Column(
                                  children: [
                                    ExpansionTileCard(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                      finalPadding: EdgeInsets.zero,
                                      baseColor: kExpansionBGColor,
                                      expandedColor: kExpansionBGColor,
                                      initiallyExpanded: false,
                                      elevation: 0.0,
                                      title: Text(
                                        DoctorSettingCubit.get(context)
                                            .doctorData
                                            .result
                                            .availabilityList[
                                                appoinmentTypeIndex]
                                            .vendorAppointType,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: font18.copyWith(
                                            color: kExpansionTitleColor),
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
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // actvation section
                                              BuildActivationRow(
                                                appoinmentTypeIndex:
                                                    appoinmentTypeIndex,
                                              ),
                                              const SizedBox(
                                                height: 16.0,
                                              ),
                                              DrawFancyDivider(),
                                              const SizedBox(
                                                height: 16.0,
                                              ),
                                              // pricing section
                                              BuildPricingRow(
                                                appoinmentTypeIndex:
                                                    appoinmentTypeIndex,
                                              ),
                                              const SizedBox(
                                                height: 16.0,
                                              ),
                                              DrawFancyDivider(),
                                              const SizedBox(
                                                height: 16.0,
                                              ),
                                              // available time section
                                              BuildAvailableTimeSection(
                                                appoinmentTypeIndex:
                                                    appoinmentTypeIndex,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    appoinmentTypeIndex == 3
                                        ? SizedBox(
                                            height: 70,
                                          )
                                        : SizedBox(
                                            height: 0,
                                          ),
                                  ],
                                );
                              }),
                          Visibility(
                            visible: true,
                            child: Positioned(
                              bottom: MediaQuery.of(context).size.height * 0.02,
                              left: MediaQuery.of(context).size.width * 0.02,
                              right: MediaQuery.of(context).size.width * 0.02,
                              child: buildSaveButton(
                                  onPressed: () {
                                    for (var i = 0;
                                        i <
                                            DoctorSettingCubit.get(context)
                                                .doctorData
                                                .result
                                                .availabilityList
                                                .length;
                                        i++) {
                                      print(
                                          '----------- > ${DoctorSettingCubit.get(context).doctorData.result.availabilityList[i].isActive}');
                                      print(
                                          '----------- > ${DoctorSettingCubit.get(context).doctorData.result.availabilityList[i].priceValue}');
                                    }
                                  },
                                  title: 'Save Settings'),
                            ),
                          ),
                        ],
                      ),
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

class BuildAvailableTimeSection extends StatefulWidget {
  final int appoinmentTypeIndex;
  const BuildAvailableTimeSection({@required this.appoinmentTypeIndex});
  @override
  _BuildAvailableTimeSectionState createState() =>
      _BuildAvailableTimeSectionState();
}

class _BuildAvailableTimeSectionState extends State<BuildAvailableTimeSection> {
  double listHeight = 50;
  @override
  Widget build(BuildContext context) {
    // you can't generate list builder inside list builder without specefing the hight
    // so I thinking about making the height dynamic
    listHeight = DoctorSettingCubit.get(context)
            .doctorData
            .result
            .availabilityList[widget.appoinmentTypeIndex]
            .availabilityTimeList
            .length
            .toDouble() *
        250.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: font14,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: DrawFancyDivider(),
        ),
        const SizedBox(
          height: 8.0,
        ),
        SizedBox(
          height: listHeight,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: DoctorSettingCubit.get(context)
                  .doctorData
                  .result
                  .availabilityList[widget.appoinmentTypeIndex]
                  .availabilityTimeList
                  .length,
              itemBuilder: (context, availableTimeListIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// day shift title
                    Text(
                      'Day Shift',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: font14,
                    ),
                    Text(
                      DoctorSettingCubit.get(context)
                          .doctorData
                          .result
                          .availabilityList[widget.appoinmentTypeIndex]
                          .availabilityTimeList[availableTimeListIndex]
                          .wdayDayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: font14,
                    ),

                    /// day shift row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'from',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: font14,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),

                            /// day shift from
                            FlatButton(
                              onPressed: () async {
                                DateTime fullDatTime = DateTime.now();
                                CommonAlertRFlutter
                                    .onAlertWithCustomContentPressed(context,
                                        title: 'Day Shift Start',
                                        buttons: [
                                          DialogButton(
                                            onPressed: () {
                                              setState(() =>
                                                  print('======== \$ Cancel'));
                                              NavigatorUtil.popRoutePage(
                                                  context);
                                            },
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: AppRepo.whiteColor),
                                            ),
                                            color: AppRepo.redColor,
                                          ),
                                          DialogButton(
                                            onPressed: () {
                                              setState(() {
                                                DoctorSettingCubit.get(context)
                                                        .doctorData
                                                        .result
                                                        .availabilityList[widget
                                                            .appoinmentTypeIndex]
                                                        .availabilityTimeList[
                                                            availableTimeListIndex]
                                                        .wdayFrom =
                                                    '${fullDatTime.hour}:${fullDatTime.minute}';
                                              });

                                              NavigatorUtil.popRoutePage(
                                                  context);
                                            },
                                            child: Text(
                                              'Confirm',
                                              style: TextStyle(
                                                  color: AppRepo.whiteColor),
                                            ),
                                            color: AppRepo.greenColor,
                                          ),
                                        ],
                                        contentWidget: CommonAlertRFlutter
                                            .showDatePickerWidget(
                                          context,
                                          90,
                                          (dateTime) => setState(() {
                                            fullDatTime = dateTime;
                                          }),
                                          CupertinoDatePickerMode.time,
                                        ));
                              },
                              child: Text(
                                  DoctorSettingCubit.get(context)
                                          .doctorData
                                          .result
                                          .availabilityList[
                                              widget.appoinmentTypeIndex]
                                          .availabilityTimeList[
                                              availableTimeListIndex]
                                          .wdayFrom ??
                                      '09:00',
                                  style: TextStyle(color: Colors.black)),
                              textColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.grey,
                                      width: 1.5,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(20)),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'to',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: font14,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),

                            /// day shift to
                            FlatButton(
                              onPressed: () async {
                                DateTime fullDatTime = DateTime.now();
                                CommonAlertRFlutter
                                    .onAlertWithCustomContentPressed(context,
                                        title: 'Day Shift End',
                                        buttons: [
                                          DialogButton(
                                            onPressed: () {
                                              setState(() =>
                                                  print('======== \$ Cancel'));
                                              NavigatorUtil.popRoutePage(
                                                  context);
                                            },
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: AppRepo.whiteColor),
                                            ),
                                            color: AppRepo.redColor,
                                          ),
                                          DialogButton(
                                            onPressed: () {
                                              setState(() {
                                                DoctorSettingCubit.get(context)
                                                        .doctorData
                                                        .result
                                                        .availabilityList[widget
                                                            .appoinmentTypeIndex]
                                                        .availabilityTimeList[
                                                            availableTimeListIndex]
                                                        .wdayTo =
                                                    '${fullDatTime.hour}:${fullDatTime.minute}';
                                              });

                                              NavigatorUtil.popRoutePage(
                                                  context);
                                            },
                                            child: Text(
                                              'Confirm',
                                              style: TextStyle(
                                                  color: AppRepo.whiteColor),
                                            ),
                                            color: AppRepo.greenColor,
                                          ),
                                        ],
                                        contentWidget: CommonAlertRFlutter
                                            .showDatePickerWidget(
                                          context,
                                          90,
                                          (dateTime) => setState(() {
                                            fullDatTime = dateTime;
                                          }),
                                          CupertinoDatePickerMode.time,
                                        ));
                              },
                              child: Text(
                                  DoctorSettingCubit.get(context)
                                          .doctorData
                                          .result
                                          .availabilityList[
                                              widget.appoinmentTypeIndex]
                                          .availabilityTimeList[
                                              availableTimeListIndex]
                                          .wdayTo ??
                                      '17:00',
                                  style: TextStyle(color: Colors.black)),
                              textColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.grey,
                                      width: 1.5,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(20)),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),

                    /// night shift title
                    Text(
                      'Night Shift',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: font14,
                    ),

                    /// Night shift row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'from',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: font14,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),

                            /// Night shift from
                            FlatButton(
                              onPressed: () async {
                                DateTime fullDatTime = DateTime.now();
                                CommonAlertRFlutter
                                    .onAlertWithCustomContentPressed(context,
                                        title: 'Night Shift Start',
                                        buttons: [
                                          DialogButton(
                                            onPressed: () {
                                              setState(() =>
                                                  print('======== \$ Cancel'));
                                              NavigatorUtil.popRoutePage(
                                                  context);
                                            },
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: AppRepo.whiteColor),
                                            ),
                                            color: AppRepo.redColor,
                                          ),
                                          DialogButton(
                                            onPressed: () {
                                              setState(() {
                                                DoctorSettingCubit.get(context)
                                                        .doctorData
                                                        .result
                                                        .availabilityList[widget
                                                            .appoinmentTypeIndex]
                                                        .availabilityTimeList[
                                                            availableTimeListIndex]
                                                        .wdayFrom2 =
                                                    '${fullDatTime.hour}:${fullDatTime.minute}';
                                              });

                                              NavigatorUtil.popRoutePage(
                                                  context);
                                            },
                                            child: Text(
                                              'Confirm',
                                              style: TextStyle(
                                                  color: AppRepo.whiteColor),
                                            ),
                                            color: AppRepo.greenColor,
                                          ),
                                        ],
                                        contentWidget: CommonAlertRFlutter
                                            .showDatePickerWidget(
                                          context,
                                          90,
                                          (dateTime) => setState(() {
                                            fullDatTime = dateTime;
                                          }),
                                          CupertinoDatePickerMode.time,
                                        ));
                              },
                              child: Text(
                                  DoctorSettingCubit.get(context)
                                          .doctorData
                                          .result
                                          .availabilityList[
                                              widget.appoinmentTypeIndex]
                                          .availabilityTimeList[
                                              availableTimeListIndex]
                                          .wdayFrom2 ??
                                      '09:00',
                                  style: TextStyle(color: Colors.black)),
                              textColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.grey,
                                      width: 1.5,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(20)),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'to',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: font14,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),

                            /// Night shift to
                            FlatButton(
                              onPressed: () async {
                                DateTime fullDatTime = DateTime.now();
                                CommonAlertRFlutter
                                    .onAlertWithCustomContentPressed(context,
                                        title: 'Night Shift End',
                                        buttons: [
                                          DialogButton(
                                            onPressed: () {
                                              setState(() =>
                                                  print('======== \$ Cancel'));
                                              NavigatorUtil.popRoutePage(
                                                  context);
                                            },
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: AppRepo.whiteColor),
                                            ),
                                            color: AppRepo.redColor,
                                          ),
                                          DialogButton(
                                            onPressed: () {
                                              setState(() {
                                                DoctorSettingCubit.get(context)
                                                        .doctorData
                                                        .result
                                                        .availabilityList[widget
                                                            .appoinmentTypeIndex]
                                                        .availabilityTimeList[
                                                            availableTimeListIndex]
                                                        .wdayTo2 =
                                                    '${fullDatTime.hour}:${fullDatTime.minute}';
                                              });

                                              NavigatorUtil.popRoutePage(
                                                  context);
                                            },
                                            child: Text(
                                              'Confirm',
                                              style: TextStyle(
                                                  color: AppRepo.whiteColor),
                                            ),
                                            color: AppRepo.greenColor,
                                          ),
                                        ],
                                        contentWidget: CommonAlertRFlutter
                                            .showDatePickerWidget(
                                          context,
                                          90,
                                          (dateTime) => setState(() {
                                            fullDatTime = dateTime;
                                          }),
                                          CupertinoDatePickerMode.time,
                                        ));
                              },
                              child: Text(
                                  DoctorSettingCubit.get(context)
                                          .doctorData
                                          .result
                                          .availabilityList[
                                              widget.appoinmentTypeIndex]
                                          .availabilityTimeList[
                                              availableTimeListIndex]
                                          .wdayTo2 ??
                                      '17:00',
                                  style: TextStyle(color: Colors.black)),
                              textColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.grey,
                                      width: 1.5,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(20)),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: DrawFancyDivider(),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                  ],
                );
              }),
        ),
        const SizedBox(
          height: 8.0,
        ),
        DrawFancyDivider(),
        const SizedBox(
          height: 8.0,
        ),
        SizedBox(
          height: 16.0,
        ),
        RawMaterialButton(
          elevation: 1,
          onPressed: () {},
          fillColor: kSecondaryColor,
          splashColor: kMainColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(
                    Icons.add,
                    color: kExpansionTitleColor,
                    size: 40.0,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  DoctorSettingCubit.get(context)
                          .doctorData
                          .result
                          .availabilityList[widget.appoinmentTypeIndex]
                          .availabilityTimeList
                          .isEmpty
                      ? 'add available day'
                      : 'add another day',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: font14,
                ),
              ],
            ),
          ),
          shape: const StadiumBorder(),
        ),
      ],
    );
  }
}
