import 'package:accura_kosba_task/shared/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/get_vendor.dart';
import '../../../network/api_provider.dart';
import '../../../shared/end_points.dart';
import 'Pharmacy_states.dart';

class PharmacyCubit extends Cubit<PharmacyStates> {
  PharmacyCubit() : super(PharmacyInitialState());

  static PharmacyCubit get(context) => BlocProvider.of(context);

  VendorData vendorData = VendorData();

  // has the initial selected day
  // has day and night shift
  // get them by the index from the ui
  List<AvailabilityList> listOfWorkingTime = [];
  bool buttonSwitch = false;
  String discountInitialText = '';
  UnavailabilityList listOfUnavailableTime = UnavailabilityList();

  getData() {
    emit(PharmacyLoadingState());

    APIProvider.fetchData(path: GET_VENDOR_END_POINT, data: {
      'access_key': 'Jd5522SA523aaaW2e25e5rk',
      'access_password': 'J52Df3e6Wrtt5F2eeeWq220',
      'vendorId': '721',
    }).then((response) async {
      vendorData =  VendorData.fromJson(response.data);

      buttonSwitch = vendorData.result.receiveOrders == '0' ? false : true ;
      discountInitialText = vendorData.result.discount;
      listOfWorkingTime = vendorData.result.availabilityList;
      listOfUnavailableTime = vendorData.result.unavailabilityList;

      print('=========================================');
      print(response.data);
      print('=========================================');
      emit(PharmacySuccessState());
    }).catchError((e) {
      print('=========================================');
      print(e);
      print('=========================================');
      emit(PharmacyErrorState(e.toString()));
    });
  }

  toggleTheSwitch({@required value}) {
    buttonSwitch = value;
    emit(PharmacySwitchButtonState());
  }

  selectWeekDay({@required value, @required indexOfListLength}) {
    listOfWorkingTime[indexOfListLength].wdayDayName = value;
    emit(PharmacySelectWeekDayState());
  }
  
  // add this to the current list u present from
  // and add to another one to upload to db
  addAvailableDayToTheList({@required  dayFrom,@required  dayTo,@required  nightFrom,@required  nightTo}){
    String dayId =  listOfWorkingTime.last.wdayId;
    int dayIdIntoInteger = int.tryParse(dayId);
    dayIdIntoInteger++;

    listOfWorkingTime.add(AvailabilityList(
      wdayId: dayIdIntoInteger.toString(),
      wdayAdvId: vendorData.result.vendorId,
      wdayDayName: 'saturday',
      wdayFrom: dayFrom,
      wdayTo: dayTo,
      wdayFrom2: nightFrom,
      wdayTo2: nightTo ,
    ));
    emit(PharmacySelectWeekDayState());
  }
  removeThisDay({@required availableDayID}){

    if(listOfWorkingTime.length == 1){
      addAvailableDayToTheList(
          dayFrom: '10:00',
          dayTo: '10:00',
          nightFrom: '10:00',
          nightTo: '10:00'
      );
    }
    listOfWorkingTime.removeAt(availableDayID);
    emit(PharmacySelectWeekDayState());
  }



  Future<Null> selectTime({@required BuildContext context,@required int index,@required String type}) async {
    // get the current time
    TimeOfDay timeOfDay = TimeOfDay.now();
    // start the picker with the current time
    timeOfDay = await showTimePicker(context: context, initialTime: timeOfDay);
    String formattedDate = '${timeOfDay.hour}:${timeOfDay.minute}';

    // save the picked time into the list
    switch(type){
      case kPickDateDayFrom:
        listOfWorkingTime[index].wdayFrom = formattedDate;
        break;
      case kPickDateDayTo:
        listOfWorkingTime[index].wdayTo = formattedDate;
        break;
      case kPickDateNightFrom:
        listOfWorkingTime[index].wdayFrom2 = formattedDate;
        break;
      case kPickDateNightTo:
        listOfWorkingTime[index].wdayTo2 = formattedDate;
        break;
    }
    emit(PharmacySelectWeekDayState());

    listOfWorkingTime.map((day) {
      print('=========================================');
      print(day.wdayId);
      print(day.wdayAdvId);
      print(day.wdayDayName);
      print(day.wdayFrom);
      print(day.wdayTo);
      print(day.wdayFrom2);
      print(day.wdayTo2);
      print('=========================================');
    }).toList();

  }

}

