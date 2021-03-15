import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'helper_class_config.dart';

class CommonAlertRFlutter {
  static onAlertWithCustomContentPressed(context,
      {String title,
      Widget contentWidget,
      FontWeight fontWeight,
      String desc,
      Color descTextColor,
      List<DialogButton> buttons,
      AlertType alertType}) {
    return Alert(
            type: alertType ?? AlertType.none,
            style: AlertStyle(
                isCloseButton: false,
                titleStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: fontWeight ?? FontWeight.w500,
                    color: descTextColor ?? AppRepo.greenColor),
                descStyle: TextStyle(
                    fontSize: 14, color: descTextColor ?? AppRepo.greenColor),
                constraints: BoxConstraints(minHeight: 180, maxWidth: 100)),
            context: context,
            desc: desc,
            title: title ?? '',
            content: contentWidget ?? Container(),
            buttons: buttons ?? [])
        .show();
  }

 
  static showDatePickerWidget(BuildContext context, double height,
          Function onDateTimeChanged, CupertinoDatePickerMode mode,
          {DateTime minimumDate,
          DateTime maximumDate,
          double fontSize,
          Color dateTimeTextColor,
          DateTime initDate}) =>
      Container(
        height: height ?? 90,
        child: CupertinoTheme(
          data: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              dateTimePickerTextStyle: TextStyle(
                  fontSize: fontSize ?? 15,
                  color: dateTimeTextColor ?? AppRepo.blackColor),
            ),
          ),
          child: CupertinoDatePicker(
            mode: mode,
            initialDateTime: initDate == null ? DateTime.now() : initDate,
            minimumDate:
                minimumDate ?? DateTime.now().subtract(Duration(days: 7300)),
            maximumDate:
                maximumDate ?? DateTime.now().add(Duration(days: 7300)),
            onDateTimeChanged: onDateTimeChanged,
          ),
        ),
      );
}

class NavigatorUtil {
  static popRoutePage(BuildContext context) {
    if (Navigator.canPop(context)) {
      try {
        Future.delayed(
          Duration.zero,
          () => Navigator.pop(context),
        );
      } catch (e) {}
    }
  }
}
