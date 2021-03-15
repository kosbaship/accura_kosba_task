import 'package:accura_kosba_task/shared/colors.dart';
import 'package:accura_kosba_task/shared/component.dart';
import 'package:accura_kosba_task/shared/styels.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/setting_cubit/doctor_setting_cubit.dart';
import 'cubit/setting_cubit/doctor_setting_states.dart';

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
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 90,
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: <Widget>[
                          ListView.builder(
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return ExpansionTileCard(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                  finalPadding: EdgeInsets.zero,
                                  baseColor: kExpansionBGColor,
                                  expandedColor: kExpansionBGColor,

                                  /// edit
                                  initiallyExpanded: false,
                                  elevation: 0.0,
                                  title: Text(
                                    /// edit
                                    'Clinic',
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
                                          // edit
                                          BuildSwitchButtonRow(),
                                          const SizedBox(
                                            height: 16.0,
                                          ),
                                          DrawFancyDivider(),
                                          const SizedBox(
                                            height: 16.0,
                                          ),
                                          // add price
                                          BuildPricingRow(),
                                          SizedBox(
                                            height: 16.0,
                                          ),
                                          SizedBox(
                                            height: 16.0,
                                          ),
                                          // choose day
                                          Text(
                                            'Available',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: font14,
                                          ),
                                          SizedBox(
                                            height: 4.0,
                                          ),
                                          SizedBox(

                                              /// edit
                                              height: 315,
                                              child: Container()),
                                          SizedBox(
                                            height: 16.0,
                                          ),
                                          RawMaterialButton(
                                            elevation: 1,
                                            onPressed: () {},
                                            fillColor: kSecondaryColor,
                                            splashColor: kMainColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 24),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: 40,
                                                    height: 40,
                                                    child: Icon(
                                                      Icons.add,
                                                      color:
                                                          kExpansionTitleColor,
                                                      size: 40.0,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    'add day',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: font14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            shape: const StadiumBorder(),
                                          ),
                                          index == 3
                                              ? SizedBox(
                                                  height: 70.0,
                                                )
                                              : SizedBox(
                                                  height: 0.0,
                                                )
                                        ],
                                      ),
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

                                  /// edit
                                  onPressed: () {},
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

class BuildSwitchButtonRow extends StatefulWidget {
  @override
  _BuildSwitchButtonRowState createState() => _BuildSwitchButtonRowState();
}

class _BuildSwitchButtonRowState extends State<BuildSwitchButtonRow> {
  bool switchCase = false;

  @override
  Widget build(BuildContext context) {
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
              switchCase ? 'On' : 'Off',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: font14.copyWith(
                color: kTitleGreyColor,
              ),
            ),
            CupertinoSwitch(
              activeColor: kExpansionTitleColor,
              value: switchCase,
              onChanged: (value) {
                setState(() => switchCase = value);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class BuildPricingRow extends StatefulWidget {
  @override
  _BuildPricingRowState createState() => _BuildPricingRowState();
}

class _BuildPricingRowState extends State<BuildPricingRow> {
  var addPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      validator: (value) {},
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
