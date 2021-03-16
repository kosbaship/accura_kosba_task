
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
import 'cubit/doctor_setting_widgets/buildAvailableTimeSection.dart';
import 'cubit/doctor_setting_widgets/pricing_row_widgets.dart';

class DoctorSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorSettingCubit()..getDoctorSettingsData(),
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
                    physics: NeverScrollableScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 90,
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: <Widget>[
                          ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: 4,
                              itemBuilder: (context, appoinmentTypeIndex) {
                                return Column(
                                  children: [
                                    Container(
                                      height: 1,
                                      color: kExpansionBorderColor,
                                    ),
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
                                    DoctorSettingCubit.get(context)
                                        .updateDoctorSettingsData();
                                    // for (var i = 0;
                                    //     i <
                                    //         DoctorSettingCubit.get(context)
                                    //             .doctorData
                                    //             .result
                                    //             .availabilityList
                                    //             .length;
                                    //     i++) {
                                    //   print(
                                    //       '----------- > ${DoctorSettingCubit.get(context).doctorData.result.availabilityList[i].isActive}');
                                    //   print(
                                    //       '----------- > ${DoctorSettingCubit.get(context).doctorData.result.availabilityList[i].priceValue}');
                                    //   for (AvailabilityTimeList availableTime
                                    //       in DoctorSettingCubit.get(context)
                                    //           .doctorData
                                    //           .result
                                    //           .availabilityList[i]
                                    //           .availabilityTimeList) {
                                    //     print(
                                    //         '----------- > ${availableTime.wdayDayName}');
                                    //     print(
                                    //         '----------- > ${availableTime.wdayFrom}');
                                    //     print(
                                    //         '----------- > ${availableTime.wdayTo}');
                                    //     print(
                                    //         '----------- > ${availableTime.wdayFrom2}');
                                    //     print(
                                    //         '----------- > ${availableTime.wdayTo2}');
                                    //   }
                                    // }
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
