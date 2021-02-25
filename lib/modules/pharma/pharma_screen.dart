import 'package:accura_kosba_task/modules/pharma/cubit/Pharmacy_cubit.dart';
import 'package:accura_kosba_task/modules/pharma/cubit/Pharmacy_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/get_vendor.dart';
import '../../shared/colors.dart';
import '../../shared/component.dart';
import '../../shared/styels.dart';

class PharmacyScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PharmacyCubit()..getData(),
      child: BlocConsumer<PharmacyCubit, PharmacyStates>(
        listener: (context, state) {},
        builder: (context, state) {
          VendorData vendorData = PharmacyCubit.get(context).vendorData;
          return Scaffold(
          backgroundColor: kSecondaryColor,
          appBar: drawAppBar(context: context),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Receive request',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: font14.copyWith(
                        color: kTitleGreyColor,
                      ),
                    ),
                    buildSwitchBtn(
                      value: PharmacyCubit.get(context).buttonSwitch,
                      onChanged: (value){
                        PharmacyCubit.get(context).toggleTheSwitch(value: value);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        },
      ),
    );
  }
}
