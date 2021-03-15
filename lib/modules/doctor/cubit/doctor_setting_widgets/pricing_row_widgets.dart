import 'package:accura_kosba_task/modules/doctor/cubit/doctor_setting_cubit/doctor_setting_cubit.dart';
import 'package:accura_kosba_task/shared/colors.dart';
import 'package:accura_kosba_task/shared/component.dart';
import 'package:accura_kosba_task/shared/styels.dart';
import 'package:flutter/material.dart';

class BuildPricingRow extends StatefulWidget {
  final int index;
  const BuildPricingRow({@required this.index});
  @override
  _BuildPricingRowState createState() => _BuildPricingRowState();
}

class _BuildPricingRowState extends State<BuildPricingRow> {
  TextEditingController addPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    addPriceController.text = DoctorSettingCubit.get(context)
        .doctorData
        .result
        .availabilityList[widget.index]
        .priceValue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pricing',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: font14,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'add price',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: font14.copyWith(color: kTitleGreyColor),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
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
                    buildPriceTextFormField(
                      /// edit
                      controller: addPriceController,
                      onChanged: (value) {
                        setState(() => DoctorSettingCubit.get(context)
                            .doctorData
                            .result
                            .availabilityList[widget.index]
                            .priceValue = value);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
