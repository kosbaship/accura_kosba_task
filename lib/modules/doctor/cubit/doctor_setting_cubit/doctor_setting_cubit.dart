import 'package:accura_kosba_task/models/get_doctor.dart';
import 'package:accura_kosba_task/network/api_provider.dart';
import 'package:accura_kosba_task/shared/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'doctor_setting_states.dart';

class DoctorSettingCubit extends Cubit<DoctorSettingStates> {
  DoctorSettingCubit() : super(DoctorSettingInitialState());

  static DoctorSettingCubit get(context) => BlocProvider.of(context);

  DoctorData doctorData = DoctorData();

  getData() {
    emit(DoctorSettingLoadingState());

    APIProvider.fetchData(path: GET_DOCTOR_END_POINT, data: {
      'access_key': 'Jd5522SA523aaaW2e25e5rk',
      'access_password': 'J52Df3e6Wrtt5F2eeeWq220',
      'doctorId': '665',
    }).then((response) async {
      doctorData = DoctorData.fromJson(response.data);

      emit(DoctorSettingSuccessState());
    }).catchError((e) {
      emit(DoctorSettingErrorState(e.toString()));
    });
  }
}
