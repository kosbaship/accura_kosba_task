import 'package:accura_kosba_task/modules/pharma/cubit/Pharmacy_cubit.dart';
import 'package:accura_kosba_task/modules/pharma/cubit/Pharmacy_states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/get_vendor.dart';
import '../../shared/colors.dart';
import '../../shared/component.dart';
import '../../shared/constants.dart';
import '../../shared/styels.dart';

class PharmacyScreen extends StatelessWidget {
  final discountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PharmacyCubit()..getData(),
      child: BlocConsumer<PharmacyCubit, PharmacyStates>(
        listener: (context, state) {},
        builder: (context, state) {

          VendorData vendorData = PharmacyCubit.get(context).vendorData;
          List<AvailabilityList> listOfWorkingTime = PharmacyCubit.get(context).listOfWorkingTime;
          discountController.text = PharmacyCubit.get(context).discountInitialText;
          UnavailabilityList listOfUnavailableTime = PharmacyCubit.get(context).listOfUnavailableTime;


          return Scaffold(
            backgroundColor: kSecondaryColor,
            appBar: drawAppBar(context: context),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ConditionalBuilder(
                condition: state is! PharmacyLoadingState,
                builder: (context) => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              color: kTitleDarkColor,
                            ),
                          ),
                          buildSwitchBtn(
                            value: PharmacyCubit.get(context).buttonSwitch,
                            onChanged: (value) {
                              PharmacyCubit.get(context)
                                  .toggleTheSwitch(value: value);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount For Request',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: font14.copyWith(
                              color: kTitleDarkColor,
                            ),
                          ),
                          Container(
                            width: 110,
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 14,
                                  top: 8.5,
                                  child: Text(
                                    '%',
                                    style: font12,
                                  ),
                                ),
                                buildTextFormField(
                                  startPadding: 25.0,
                                  controller: discountController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Discount';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Working time',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: font14,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // drop down button
                            SizedBox(
                              child: buildTDropdownButton(
                                items: daysOfTheWeek.map((day) {
                                  return DropdownMenuItem(
                                    value: day,
                                    child: Text(day),
                                  );
                                }).toList(),
                                onChanged: (selectedItem) {
                                  print(selectedItem);

                                  PharmacyCubit.get(context).selectPharmacyWeekDay(
                                      value: selectedItem,
                                      indexOfListLength: index);
                                },
                                value: listOfWorkingTime[index].wdayDayName,
                              ),
                            ),
                            // day shift
                            writeText14(title: 'Day Shift'),
                            SizedBox(
                              height: 4.0,
                            ),
                            SizedBox(
                              child: chooseDateRow(
                                  leftTitle:
                                      '${listOfWorkingTime[index].wdayFrom}' ??
                                          'from',
                                  leftOnTap: () {
                                    PharmacyCubit.get(context).selectTime(
                                        context: context,
                                        index: index,
                                        type: kPickDateDayFrom);
                                  },
                                  rightTitle:
                                      '${listOfWorkingTime[index].wdayTo}' ??
                                          'to',
                                  rightOnTap: () {
                                    PharmacyCubit.get(context).selectTime(
                                        context: context,
                                        index: index,
                                        type: kPickDateDayTo);
                                  }),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            // Night Shift
                            writeText14(title: 'Night Shift'),
                            SizedBox(
                              height: 4.0,
                            ),
                            SizedBox(
                              child: chooseDateRow(
                                  leftTitle:
                                      '${listOfWorkingTime[index].wdayFrom2}' ??
                                          'from',
                                  leftOnTap: () {
                                    PharmacyCubit.get(context).selectTime(
                                        context: context,
                                        index: index,
                                        type: kPickDateNightFrom);
                                  },
                                  rightTitle:
                                      '${listOfWorkingTime[index].wdayTo2}' ??
                                          'to',
                                  rightOnTap: () {
                                    PharmacyCubit.get(context).selectTime(
                                        context: context,
                                        index: index,
                                        type: kPickDateNightTo);
                                  }),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            buildRemoveButton(
                                onPressed: () {
                                  PharmacyCubit.get(context).removeThisDay(availableDayID: index);
                                }, title: 'Remove This Day'),
                            SizedBox(
                              height: 8,
                            ),
                            drawDivider(),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                        itemCount: vendorData.result.availabilityList.length,
                      ),
                      // ===================================
                      // ================= add available day
                      // ===================================
                      Row(
                        children: [
                          drawCircleIcon(
                              onTap: () {
                            PharmacyCubit.get(context).addAvailableDayToTheList(
                                dayFrom: '16:00',
                                dayTo: '12:00',
                                nightFrom: '12:00',
                                nightTo: '08:00'
                            );
                          }),
                          InkWell(
                            onTap: () {
                              PharmacyCubit.get(context).addAvailableDayToTheList(
                                  dayFrom: '10:00',
                                  dayTo: '10:00',
                                  nightFrom: '10:00',
                                  nightTo: '10:00'
                              );
                            },
                            child: Text(
                              '  add another day',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: font14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'Unavailability',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: font14,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      InkWell(
                        splashColor: kTitleGreyColor,
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(24.0),
                              ),
                              color: kSecondaryColor,
                              border: Border.all(
                                width: 1,
                                color: kTitleGreyColor,
                              )),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${listOfUnavailableTime.from}' ??
                                    'start',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: font14.copyWith(
                                    color: kTitleGreyColor),
                              ),
                              ClipOval(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                      'assets/images/clocicon.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),
                      // un available days
                      InkWell(
                        splashColor: kTitleGreyColor,
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(24.0),
                              ),
                              color: kSecondaryColor,
                              border: Border.all(
                                width: 1,
                                color: kTitleGreyColor,
                              )),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${listOfUnavailableTime.to}' ??
                                    'end',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: font14.copyWith(
                                    color: kTitleGreyColor),
                              ),
                              ClipOval(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                      'assets/images/clocicon.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: kSecondaryColor,
                        ),
                        child: buildSaveButton(
                            onPressed: () {}, title: 'Save Settings'),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => Center(
                    child: CircularProgressIndicator(
                  backgroundColor: kMainColor,
                )),
              ),
            ),
          );
        },
      ),
    );
  }
}
