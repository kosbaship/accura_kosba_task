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
  List<AvailabilityTimeList> clinicSelectedList = [];
  List<AvailabilityTimeList> voiceSelectedList = [];
  List<AvailabilityTimeList> videoSelectedList = [];
  List<AvailabilityTimeList> spotSelectedList = [];

  List<String> clinicSelectedDays = ['Day', 'Day', 'Day', 'Day', 'Day'];
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
      clinicSelectedList =  doctorData.result.availabilityList[0].availabilityTimeList;
      voiceSelectedList =  doctorData.result.availabilityList[1].availabilityTimeList;
      videoSelectedList =  doctorData.result.availabilityList[2].availabilityTimeList;
      spotSelectedList =  doctorData.result.availabilityList[3].availabilityTimeList;


      emit(DocAssistSuccessState());
    }).catchError((e) {
      emit(DocAssistErrorState(e.toString()));
    });
  }

  updateData({
    @required typePrice,
    @required disableClinic,
    @required clinicDayListItemValue,
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
          'typesPrices': '$typePrice',
          'disableClinic': '$disableClinic',
          'clinicDays[0]': '$clinicDayListItemValue',
          'clinicFrom[0]': '$clinicFromMorningTime',
          'clinicTo[0]': '$clinicToMorningTime',
          'clinicFrom2[0]': '$clinicFromNightTime',
          'clinicTo2[0]': '$clinicToNightTime',
        }
    ).then((response) async{

      print('\n=========================================================');
      print(response.data);
      print('=========================================================\n\n');
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

  selectWeekDay({@required value, @required index, @required indexOfListLength}){
    print('\n=========================================================');
    print(index);
    print(value);
    print('=========================================================\n\n');
    switch (index) {
      case 0:
        clinicSelectedDays[indexOfListLength] = value;
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

    print('\n=========================================================');
    print(doctorData.result.availabilityList[0].availabilityTimeList[index].wdayDayName);
    print(index);
    print(sectionIndex);
    print(clinicSelectedDay);
    print(voiceSelectedDay);
    print(videoSelectedDay);
    print(spotSelectedDay);
    print('=========================================================\n\n');
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
  }

}
