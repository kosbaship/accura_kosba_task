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

  List<String> clinicSelectedDays = ['day', 'day', 'day', 'day', 'day', 'day', 'day'];
  List<String> voiceSelectedDays = ['day', 'day', 'day', 'day', 'day', 'day', 'day'];
  List<String> videoSelectedDays = ['day', 'day', 'day', 'day', 'day', 'day', 'day'];
  List<String> spotSelectedDays = ['day', 'day', 'day', 'day', 'day', 'day', 'day'];

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
    emit(DocAssistLoadingState());

    APIProvider.fetchData(
        path: UPDATE_DOCTOR_END_POINT,
        data: {
          kAccessKey: kAccessKeyValue,
          kAccessPassword: kAccessPasswordValue,
          kDoctorID: kDoctorIDValue,
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
    switch (index) {
      case 0:
        clinicSelectedDays[indexOfListLength] = value;
        emit(DocAssistClinicSelectWeekDayState());
        break;
      case 1:
        voiceSelectedDays[indexOfListLength] = value;
        emit(DocAssistVoiceSelectWeekDayState());
        break;
      case 2:
        videoSelectedDays[indexOfListLength] = value;
        emit(DocAssistVideoSelectWeekDayState());
        break;
      case 3:
        spotSelectedDays[indexOfListLength]= value;
        emit(DocAssistSpotSelectWeekDayState());
        break;
    }
  }

}
