import 'package:accura_kosba_task/modules/doctor/cubit/doctor_setting_cubit/doctor_setting_cubit.dart';
import 'package:accura_kosba_task/shared/colors.dart';
import 'package:accura_kosba_task/shared/styels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 class BuildActivationRow extends StatefulWidget {
  final int appoinmentTypeIndex;
  const BuildActivationRow({@required this.appoinmentTypeIndex});
  @override
  _BuildActivationRowState createState() => _BuildActivationRowState();
}

class _BuildActivationRowState extends State<BuildActivationRow> {
  bool switchCaseValue;

  @override
  Widget build(BuildContext context) {
    switchCaseValue = DoctorSettingCubit.get(context)
                .doctorData
                .result
                .availabilityList[widget.appoinmentTypeIndex]
                .isActive ==
            1
        ? true
        : false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Activation',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: font14,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// edit
            Text(
              switchCaseValue ? 'On' : 'Off',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: font14.copyWith(
                color: kTitleGreyColor,
              ),
            ),
            CupertinoSwitch(
              activeColor: kExpansionTitleColor,
              value: switchCaseValue,
              onChanged: (value) {
                setState(() => DoctorSettingCubit.get(context)
                    .doctorData
                    .result
                    .availabilityList[widget.appoinmentTypeIndex]
                    .isActive = value == true ? 1 : 0);
               },
            ),
          ],
        ),
      ],
    );
  }
}

 