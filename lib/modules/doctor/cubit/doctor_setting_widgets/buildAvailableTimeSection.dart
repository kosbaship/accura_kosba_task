import 'package:accura_kosba_task/models/get_doctor.dart';
import 'package:accura_kosba_task/modules/doctor/cubit/doctor_setting_cubit/doctor_setting_cubit.dart';
import 'package:accura_kosba_task/shared/colors.dart';
import 'package:accura_kosba_task/shared/component.dart';
import 'package:accura_kosba_task/shared/constants.dart';
import 'package:accura_kosba_task/shared/helper_class_config.dart';
import 'package:accura_kosba_task/shared/helper_classes.dart';
import 'package:accura_kosba_task/shared/styels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BuildAvailableTimeSection extends StatefulWidget {
  final int appoinmentTypeIndex;
  const BuildAvailableTimeSection({@required this.appoinmentTypeIndex});
  @override
  _BuildAvailableTimeSectionState createState() =>
      _BuildAvailableTimeSectionState();
}

class _BuildAvailableTimeSectionState extends State<BuildAvailableTimeSection> {
  double listHeight;
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
        293.0;

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
                    /// drop down Button section
                    buildTDropdownButton(
                      items: daysOfTheWeek.map((day) {
                        return DropdownMenuItem(
                          value: day,
                          child: Text(day),
                        );
                      }).toList(),
                      onChanged: (selectedItem) {
                        setState(() => DoctorSettingCubit.get(context)
                            .doctorData
                            .result
                            .availabilityList[widget.appoinmentTypeIndex]
                            .availabilityTimeList[availableTimeListIndex]
                            .wdayDayName = selectedItem);
                      },
                      value: DoctorSettingCubit.get(context)
                          .doctorData
                          .result
                          .availabilityList[widget.appoinmentTypeIndex]
                          .availabilityTimeList[availableTimeListIndex]
                          .wdayDayName,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),

                    /// day shift title
                    Text(
                      'Day Shift',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: font14.copyWith(color: kTitleGreyColor),
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
                                style: font12.copyWith(color: kTitleGreyColor),
                              ),
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
                                style: font12.copyWith(color: kTitleGreyColor),
                              ),
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
                      style: font14.copyWith(color: kTitleGreyColor),
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
                                style: font12.copyWith(color: kTitleGreyColor),
                              ),
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
                                style: font12.copyWith(color: kTitleGreyColor),
                              ),
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

                    /// remove day button
                    Center(
                      child: RawMaterialButton(
                        elevation: 1,
                        onPressed: () {
                          setState(() => DoctorSettingCubit.get(context)
                              .doctorData
                              .result
                              .availabilityList[widget.appoinmentTypeIndex]
                              .availabilityTimeList
                              .removeAt(availableTimeListIndex));
                        },
                        fillColor: kRemoveColor,
                        splashColor: kMainColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Icon(
                                  Icons.close,
                                  color: kSecondaryColor,
                                  size: 40.0,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Remove this day',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: font14.copyWith(color: kSecondaryColor),
                              ),
                            ],
                          ),
                        ),
                        shape: const StadiumBorder(),
                      ),
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
        const SizedBox(
          height: 16.0,
        ),

        /// add day button
        Center(
          child: RawMaterialButton(
            elevation: 3,
            onPressed: () {
              if (DoctorSettingCubit.get(context)
                      .doctorData
                      .result
                      .availabilityList[widget.appoinmentTypeIndex]
                      .availabilityTimeList
                      .length <
                  7) {
                setState(() => DoctorSettingCubit.get(context)
                    .doctorData
                    .result
                    .availabilityList[widget.appoinmentTypeIndex]
                    .availabilityTimeList
                    .add(AvailabilityTimeList(
                        wdayDayName: daysOfTheWeek[0],
                        wdayFrom: '08:00',
                        wdayTo: '16:00',
                        wdayFrom2: '00:00',
                        wdayTo2: '08:00')));
              } else {
                showToast(
                    message: 'You can\'t add more than a week', error: true);
              }
            },
            fillColor: kSecondaryColor,
            splashColor: kMainColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
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
                                .length ==
                            0
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
        ),
      ],
    );
  }
}
