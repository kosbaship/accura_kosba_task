import 'package:accura_kosba_task/shared/colors.dart';
import 'package:accura_kosba_task/shared/component.dart';
import 'package:accura_kosba_task/shared/styels.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                              itemBuilder: (context, index) {
                                return ExpansionTileCard(
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
                                        .availabilityList[index]
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
                                            index: index,
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
                                            index: index,
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
                                            index: index,
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
  final int index;
  const BuildAvailableTimeSection({@required this.index});
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
            .availabilityList[widget.index]
            .availabilityTimeList
            .length
            .toDouble() *
        50.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          height: listHeight,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  height: 50,
                  width: 50,
                  color: index == 2 ? Colors.amber : Colors.red,
                );
              }),
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
                  'add day',
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
