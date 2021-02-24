import 'package:accura_kosba_task/network/api_provider.dart';
import 'package:accura_kosba_task/shared/constants.dart';
import 'package:accura_kosba_task/shared/end_points.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'doc_assist_states.dart';

class DocAssistCubit extends Cubit<DocAssistStates> {
  DocAssistCubit() : super(DocAssistInitialState());

  static DocAssistCubit get(context) => BlocProvider.of(context);

  bool switchValue = true;
  String selectedDay = 'Saturday';


  getData() {
    emit(DocAssistLoadingState());
    print('\n=========================================================');
    print('Getting Your Data');
    print('=========================================================\n\n');

    APIProvider.fetchData(
        path: GET_DOCTOR_END_POINT,
        data: {
        kAccessKey: kAccessKeyValue,
        kAccessPassword: kAccessPasswordValue,
        kDoctorID: kDoctorIDValue,
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

  toggleTheSwitch({@required value}){
    switchValue = value;
    emit(DocAssistSwitchButtonState());
  }

  selectWeekDay({@required value}){

    selectedDay = value;
    emit(DocAssistSelectWeekDayState());
  }

}