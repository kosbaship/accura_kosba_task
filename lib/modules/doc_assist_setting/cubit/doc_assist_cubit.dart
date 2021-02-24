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

  bool switchValue = false;
  String selectedDay = 'Day';
  DoctorData doctorData = DoctorData();

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

      // toggle the switch according to the api
      if(doctorData.result.availabilityList[0].isActive == 1){
        switchValue = true;
      } else {
        switchValue = false;
      }


      print('\n=========================================================');
      print(doctorData.result.availabilityList.length);
      print(doctorData.result.availabilityList[0].availabilityTimeList[1].wdayDayName);
      print('=========================================================\n\n');

      emit(DocAssistSuccessState());
    }).catchError((e) {
      emit(DocAssistErrorState(e.toString()));
    });
  }

  toggleTheSwitch({@required value}){
    switchValue = value;
    emit(DocAssistSwitchButtonState());
  }

  selectWeekDay({@required value}){

    selectedDay = value;
    emit(DocAssistSelectWeekDayState());
  }

}