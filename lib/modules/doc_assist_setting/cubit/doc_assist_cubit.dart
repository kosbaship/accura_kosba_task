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

  bool _switchValue = false;
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

      print('\n=========================================================');
      print(doctorData.result.availabilityList.length);
      print(doctorData.result.availabilityList[0].availabilityTimeList[1].wdayDayName);
      print('=========================================================\n\n');

      emit(DocAssistSuccessState());
    }).catchError((e) {
      emit(DocAssistErrorState(e.toString()));
    });
  }


  // toggle the switch according to the api
  getSwitchValueByIndex({index}){
    if(doctorData.result.availabilityList[index].isActive == 1){
      _switchValue = true;
      return _switchValue;
    } else {
      _switchValue = false;
      return _switchValue;
    }
  }


  toggleTheSwitch({@required value}){
    _switchValue = value;
    emit(DocAssistSwitchButtonState());
  }

  selectWeekDay({@required value}){

    selectedDay = value;
    emit(DocAssistSelectWeekDayState());
  }

}