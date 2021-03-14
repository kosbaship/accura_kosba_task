import 'package:accura_kosba_task/models/get_doctor.dart';
import 'package:accura_kosba_task/network/api_provider.dart';
import 'package:accura_kosba_task/shared/constants.dart';
import 'package:accura_kosba_task/shared/end_points.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'doctor_setting_states.dart';

class DoctorSettingCubit extends Cubit<DoctorSettingStates> {
  DoctorSettingCubit() : super(DoctorSettingInitialState());

  static DoctorSettingCubit get(context) => BlocProvider.of(context);

  DoctorData doctorData = DoctorData();
  List<AvailabilityList> availableLists = [];
  String clinicAddPriceInitialText = '';
  String voiceAddPriceInitialText = '';
  String videoAddPriceInitialText = '';
  String spotAddPriceInitialText = '';


  bool clinicSwitch = false;
  bool videoSwitch = false;
  bool voiceSwitch = false;
  bool spotSwitch = false;

  getData() {
    emit(DoctorSettingLoadingState());

    APIProvider.fetchData(
        path: GET_DOCTOR_END_POINT,
        data: {
        'access_key': 'Jd5522SA523aaaW2e25e5rk',
        'access_password': 'J52Df3e6Wrtt5F2eeeWq220',
        'doctorId': '796',
      }
    ).then((response) async{
      doctorData =  DoctorData.fromJson(response.data);

      availableLists = doctorData.result.availabilityList;

      // switch initial value
      clinicSwitch = doctorData.result.availabilityList[kVendorTypeClinic].isActive == 1 ? true : false;
      voiceSwitch = doctorData.result.availabilityList[kVendorTypeVoice].isActive == 1 ? true : false;
      videoSwitch = doctorData.result.availabilityList[kVendorTypeVideo].isActive == 1 ? true : false;
      spotSwitch = doctorData.result.availabilityList[kVendorTypeSpot].isActive == 1 ? true : false;

      // edit text initial value
      clinicAddPriceInitialText = availableLists[kVendorTypeClinic].priceValue;
      voiceAddPriceInitialText = availableLists[kVendorTypeVoice].priceValue;
      videoAddPriceInitialText = availableLists[kVendorTypeVideo].priceValue;
      spotAddPriceInitialText = availableLists[kVendorTypeSpot].priceValue;


      emit(DoctorSettingSuccessState());
    }).catchError((e) {
      emit(DoctorSettingErrorState(e.toString()));
    });
  }

  updateClinicData({
    @required clinicPrice,
    @required clinicDayListFirst,
    @required clinicFromDayFirst,
    @required clinicToDayFirst,
    @required clinicFromNightFirst,
    @required clinicToNightFirst,
    @required clinicDayListSecond,
    @required clinicFromDaySecond,
    @required clinicToDaySecond,
    @required clinicFromNightSecond,
    @required clinicToNightSecond,
  }) {
    emit(DoctorSettingLoadingState());

    APIProvider.fetchData(
        path: UPDATE_DOCTOR_END_POINT,
        data: {
          'access_key': 'Jd5522SA523aaaW2e25e5rk',
          'access_password': 'J52Df3e6Wrtt5F2eeeWq220',
          'userId': '796',
          'typesPrices': 'clinic_$clinicPrice',
          'clinicDays[0]': clinicDayListFirst,
          'clinicFrom[0]': clinicFromDayFirst,
          'clinicTo[0]': clinicToDayFirst,
          'clinicFrom2[0]': clinicFromNightFirst,
          'clinicTo2[0]': clinicToNightFirst,
          'clinicDays[1]': clinicDayListSecond,
          'clinicFrom[1]': clinicFromDaySecond,
          'clinicTo[1]': clinicToDaySecond,
          'clinicFrom2[1]': clinicFromNightSecond,
          'clinicTo2[1]': clinicToNightSecond,
        }
    ).then((response) async{

      print('\n=========================================================');
      print(response.data);
      print('=========================================================\n\n');
      emit(DoctorSettingSuccessState());
    }).catchError((e) {
      emit(DoctorSettingErrorState(e.toString()));
    });
  }

  updateVoiceData({
    @required voicePrice,
    @required voiceDayListFirst,
    @required voiceFromDayFirst,
    @required voiceToDayFirst,
    @required voiceFromNightFirst,
    @required voiceToNightFirst,
    // @required voiceDayListSecond,
    // @required voiceFromDaySecond,
    // @required voiceToDaySecond,
    // @required voiceFromNightSecond,
    // @required voiceToNightSecond,
  }) {
    emit(DoctorSettingLoadingState());

    APIProvider.fetchData(
        path: UPDATE_DOCTOR_END_POINT,
        data: {
          'access_key': 'Jd5522SA523aaaW2e25e5rk',
          'access_password': 'J52Df3e6Wrtt5F2eeeWq220',
          'userId': '796',
          'typesPrices': 'voice_$voicePrice',
          'voiceDays[0]': voiceDayListFirst,
          'voiceFrom[0]': voiceFromDayFirst,
          'voiceTo[0]': voiceToDayFirst,
          'voiceFrom2[0]': voiceFromNightFirst,
          'voiceTo2[0]': voiceToNightFirst,
          // 'voiceDays[1]': voiceDayListSecond,
          // 'voiceFrom[1]': voiceFromDaySecond,
          // 'voiceTo[1]': voiceToDaySecond,
          // 'voiceFrom2[1]': voiceFromNightSecond,
          // 'voiceTo2[1]': voiceToNightSecond,
        }
    ).then((response) async{

      print('\n=========================================================');
      print(response.data);
      print('=========================================================\n\n');
      emit(DoctorSettingSuccessState());
    }).catchError((e) {
      emit(DoctorSettingErrorState(e.toString()));
    });
  }

  updateVideoData({
    @required videoPrice,
    @required videoDayListFirst,
    @required videoFromDayFirst,
    @required videoToDayFirst,
    @required videoFromNightFirst,
    @required videoToNightFirst,
    // @required videoDayListSecond,
    // @required videoFromDaySecond,
    // @required videoToDaySecond,
    // @required videoFromNightSecond,
    // @required videoToNightSecond,
  }) {
    emit(DoctorSettingLoadingState());

    APIProvider.fetchData(
        path: UPDATE_DOCTOR_END_POINT,
        data: {
          'access_key': 'Jd5522SA523aaaW2e25e5rk',
          'access_password': 'J52Df3e6Wrtt5F2eeeWq220',
          'userId': '796',
          'typesPrices': 'video_$videoPrice',
          'videoDays[0]': videoDayListFirst,
          'videoFrom[0]': videoFromDayFirst,
          'videoTo[0]': videoToDayFirst,
          'videoFrom2[0]': videoFromNightFirst,
          'videoTo2[0]': videoToNightFirst,
          // 'videoDays[1]': videoDayListSecond,
          // 'videoFrom[1]': videoFromDaySecond,
          // 'videoTo[1]': videoToDaySecond,
          // 'videoFrom2[1]': videoFromNightSecond,
          // 'videoTo2[1]': videoToNightSecond,
        }
    ).then((response) async{

      print('\n=========================================================');
      print(response.data);
      print('=========================================================\n\n');
      emit(DoctorSettingSuccessState());
    }).catchError((e) {
      emit(DoctorSettingErrorState(e.toString()));
    });
  }

  updateSpotData({
    @required spotPrice,
    @required spotDayListFirst,
    @required spotFromDayFirst,
    @required spotToDayFirst,
    @required spotFromNightFirst,
    @required spotToNightFirst,
    // @required spotDayListSecond,
    // @required spotFromDaySecond,
    // @required spotToDaySecond,
    // @required spotFromNightSecond,
    // @required spotToNightSecond,
  }) {
    emit(DoctorSettingLoadingState());

    APIProvider.fetchData(
        path: UPDATE_DOCTOR_END_POINT,
        data: {
          'access_key': 'Jd5522SA523aaaW2e25e5rk',
          'access_password': 'J52Df3e6Wrtt5F2eeeWq220',
          'userId': '796',
          'typesPrices': 'spot_$spotPrice',
          'spotDays[0]': spotDayListFirst,
          'spotFrom[0]': spotFromDayFirst,
          'spotTo[0]': spotToDayFirst,
          'spotFrom2[0]': spotFromNightFirst,
          'spotTo2[0]': spotToNightFirst,
          // 'spotDays[1]': spotDayListSecond,
          // 'spotFrom[1]': spotFromDaySecond,
          // 'spotTo[1]': spotToDaySecond,
          // 'spotFrom2[1]': spotFromNightSecond,
          // 'spotTo2[1]': spotToNightSecond,
        }
    ).then((response) async{

      print('\n=========================================================');
      print(response.data);
      print('=========================================================\n\n');
      emit(DoctorSettingSuccessState());
    }).catchError((e) {
      emit(DoctorSettingErrorState(e.toString()));
    });
  }
 
  toggleAndSaveSwitch({@required int vendorType, @required bool value}){
    switch (vendorType) {
      case kVendorTypeClinic:
        clinicSwitch = value;
        clinicSwitch ? availableLists[kVendorTypeClinic].isActive = 1 : availableLists[vendorType].isActive = 0;
        break;
      case kVendorTypeVoice:
        voiceSwitch = value;
        voiceSwitch ? availableLists[kVendorTypeVoice].isActive = 1 : availableLists[vendorType].isActive = 0;
        break;
      case kVendorTypeVideo:
        videoSwitch = value;
        videoSwitch ? availableLists[kVendorTypeVideo].isActive = 1 : availableLists[vendorType].isActive = 0;
        break;
      case kVendorTypeSpot:
        spotSwitch = value;
        spotSwitch ? availableLists[kVendorTypeSpot].isActive = 1 : availableLists[vendorType].isActive = 0;
        break;
    }
    emit(DoctorSettingSwitchButtonState());
  }

  selectAndSaveDay({@required int vendorType, @required value, @required indexOfListLength}){
    switch (vendorType) {
      case kVendorTypeClinic:
        availableLists[kVendorTypeClinic].availabilityTimeList[indexOfListLength].wdayDayName = value;
        emit(DoctorSettingClinicSelectWeekDayState());
        break;
      case kVendorTypeVoice:
        availableLists[kVendorTypeVoice].availabilityTimeList[indexOfListLength].wdayDayName = value;
        emit(DoctorSettingVoiceSelectWeekDayState());
        break;
      case kVendorTypeVideo:
        availableLists[kVendorTypeVideo].availabilityTimeList[indexOfListLength].wdayDayName = value;
        emit(DoctorSettingVoiceSelectWeekDayState());
        break;
      case kVendorTypeSpot:
        availableLists[kVendorTypeSpot].availabilityTimeList[indexOfListLength].wdayDayName = value;
        emit(DoctorSettingSpotSelectWeekDayState());
        break;
    }
  }


  // add this to the current list u present from
  // and add to another one to upload to db
  addAvailableDayToTheList({@required vendorType}){

    availableLists[vendorType].availabilityTimeList.add(
      AvailabilityTimeList(
      wdayDayName: 'saturday',
      wdayFrom: '00:00',
      wdayTo: '00:00',
      wdayFrom2: '00:00',
      wdayTo2: '00:00' ,
    ));
    switch (vendorType) {
      case kVendorTypeClinic:
        emit(DoctorSettingClinicSelectWeekDayState());
        break;
      case kVendorTypeVoice:
        emit(DoctorSettingVoiceSelectWeekDayState());
        break;
      case kVendorTypeVideo:
        emit(DoctorSettingVoiceSelectWeekDayState());
        break;
      case kVendorTypeSpot:
        emit(DoctorSettingSpotSelectWeekDayState());
        break;
    }
  }


  removeThisDay({@required availableDayID, @required vendorType}){
    if(availableLists[vendorType].availabilityTimeList.length == 1){
      addAvailableDayToTheList(
        vendorType: vendorType,
      );
    }
    availableLists[vendorType].availabilityTimeList.removeAt(availableDayID);
    switch (vendorType) {
      case kVendorTypeClinic:
        emit(DoctorSettingClinicSelectWeekDayState());
        break;
      case kVendorTypeVoice:
        emit(DoctorSettingVoiceSelectWeekDayState());
        break;
      case kVendorTypeVideo:
        emit(DoctorSettingVoiceSelectWeekDayState());
        break;
      case kVendorTypeSpot:
        emit(DoctorSettingSpotSelectWeekDayState());
        break;
    }
  }

  Future<Null> selectTime({@required BuildContext context,@required int index,@required String type, @required vendorType}) async {
    // get the current time
    TimeOfDay timeOfDay = TimeOfDay.now();
    // start the picker with the current time
    timeOfDay = await showTimePicker(context: context, initialTime: timeOfDay);
    String formattedDate = '${timeOfDay.hour}:${timeOfDay.minute}';

    // save the picked time into the list
    switch(type){
      case kPickDateDayFrom:
        availableLists[vendorType].availabilityTimeList[index].wdayFrom = formattedDate;
        break;
      case kPickDateDayTo:
        availableLists[vendorType].availabilityTimeList[index].wdayTo = formattedDate;
        break;
      case kPickDateNightFrom:
        availableLists[vendorType].availabilityTimeList[index].wdayFrom2 = formattedDate;
        break;
      case kPickDateNightTo:
        availableLists[vendorType].availabilityTimeList[index].wdayTo2 = formattedDate;
        break;
    }
    switch (vendorType) {
      case kVendorTypeClinic:
        emit(DoctorSettingClinicSelectWeekDayState());
        break;
      case kVendorTypeVoice:
        emit(DoctorSettingVoiceSelectWeekDayState());
        break;
      case kVendorTypeVideo:
        emit(DoctorSettingVoiceSelectWeekDayState());
        break;
      case kVendorTypeSpot:
        emit(DoctorSettingSpotSelectWeekDayState());
        break;
    }

    // availableLists[vendorType].availabilityTimeList.map((day) {
    //   print('=========================================');
    //   print(day.wdayDayName);
    //   print(day.wdayFrom);
    //   print(day.wdayTo);
    //   print(day.wdayFrom2);
    //   print(day.wdayTo2);
    //   print('=========================================');
    // }).toList();

  }


}
