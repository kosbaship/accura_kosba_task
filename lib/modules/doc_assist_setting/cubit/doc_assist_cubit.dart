import 'package:accura_kosba_task/models/get_doctor.dart';
import 'package:accura_kosba_task/network/api_provider.dart';
import 'package:accura_kosba_task/shared/constants.dart';
import 'package:accura_kosba_task/shared/end_points.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'doc_assist_states.dart';

class DocAssistCubit extends Cubit<DocAssistStates> {
  DocAssistCubit() : super(DocAssistInitialState());

  static DocAssistCubit get(context) => BlocProvider.of(context);

  DoctorData doctorData = DoctorData();
  String clinicSelectedDay = 'Day';
  String voiceSelectedDay = 'Day';
  String videoSelectedDay = 'Day';
  String spotSelectedDay = 'Day';
  bool clinicSwitch = false;
  bool videoSwitch = false;
  bool voiceSwitch = false;
  bool spotSwitch = false;

  getData() {
    emit(DocAssistLoadingState());

    APIProvider.fetchData(
        path: GET_DOCTOR_END_POINT,
        data: {
        kAccessKey: kAccessKeyValue,
        kAccessPassword: kAccessPasswordValue,
        kDoctorID: kDoctorIDValue,
      }
    ).then((response) async{
      doctorData =  DoctorData.fromJson(response.data);

      clinicSwitch = doctorData.result.availabilityList[0].isActive == 1;
      videoSwitch = doctorData.result.availabilityList[1].isActive == 1;
      voiceSwitch = doctorData.result.availabilityList[2].isActive == 1;
      spotSwitch = doctorData.result.availabilityList[3].isActive == 1;

      emit(DocAssistSuccessState());
    }).catchError((e) {
      emit(DocAssistErrorState(e.toString()));
    });
  }

  updateData({
    @required expansionTitle,
    @required switchTitle,
    @required clinicPrice,
    @required videoPrice,
    @required voicePrice,
    @required spotPrice,
    @required disableClinic,
    @required clinicDayListIndex,
    @required clinicDayListItemValue,
    @required clinicDaySectionIndex,
    @required clinicFromMorningTime,
    @required clinicToMorningTime,
    @required clinicFromNightTime,
    @required clinicToNightTime,
  }) {
    emit(DocAssistLoadingState());

    APIProvider.fetchData(
        path: UPDATE_DOCTOR_END_POINT,
        data: {
          kAccessKey: kAccessKeyValue,
          kAccessPassword: kAccessPasswordValue,
          kDoctorID: kDoctorIDValue,
          'typesPrices': 'clinic_$clinicPrice|video_$videoPrice|voice_$voicePrice|spot_$spotPrice',
          'disable$switchTitle': '$disableClinic',
          '$expansionTitle'+'Days[$clinicDayListIndex]': '$clinicDayListItemValue',
          '$expansionTitle'+'From[$clinicDaySectionIndex]': '$clinicFromMorningTime',
          '$expansionTitle'+'To[$clinicDaySectionIndex]': '$clinicToMorningTime',
          '$expansionTitle'+'From2[$clinicDaySectionIndex]': '$clinicFromNightTime',
          '$expansionTitle'+'To2[$clinicDaySectionIndex]': '$clinicToNightTime',
        }
    ).then((response) async{

      emit(DocAssistSuccessState());
    }).catchError((e) {
      emit(DocAssistErrorState(e.toString()));
    });
  }


  toggleTheSwitch({@required value, @required index}){
    switch (index) {
      case 0:
        clinicSwitch = value;
        break;
      case 2:
        videoSwitch = value;
        break;
      case 1:
        voiceSwitch = value;
        break;
      case 3:
        spotSwitch = value;
        break;
    }
    emit(DocAssistSwitchButtonState());
  }

  selectWeekDay({@required value, @required index,}){
    print('\n=========================================================');
    print(index);
    print(value);
    print('=========================================================\n\n');
    switch (index) {
      case 0:
        clinicSelectedDay = value;
        break;
      case 2:
        videoSelectedDay = value;
        break;
      case 1:
        voiceSelectedDay = value;
        break;
      case 3:
        spotSelectedDay = value;
        break;
    }
    emit(DocAssistSelectWeekDayState());
  }

  selectDayFromDB({@required index, @required sectionIndex}){
    String sectionSelectDay ;

    switch (doctorData.result.availabilityList[0].availabilityTimeList[index].wdayDayName) {
      case 'saturday':
        sectionSelectDay = kSaturday;
        break;
      case 'sunday':
        sectionSelectDay = kSunday;
        break;
      case 'monday':
        sectionSelectDay = kMonday;
        break;
      case 'tuesday':
        sectionSelectDay = kTuesday;
        break;
      case 'wednesday':
        sectionSelectDay = kWednesday;
        break;
      case 'thursday':
        sectionSelectDay = kThursday;
        break;
      case 'friday':
        sectionSelectDay = kFriday;
        break;
    }
    if(sectionIndex == 0 ){
       clinicSelectedDay =  sectionSelectDay;
    }
    if(sectionIndex == 1 ){
      voiceSelectedDay =  sectionSelectDay;
    }
    if(sectionIndex == 2 ){
      videoSelectedDay =  sectionSelectDay;
    }
    if(sectionIndex == 3 ){
      spotSelectedDay =  sectionSelectDay;
    }
    emit(DocAssistSelectWeekDayState());
  }



}
