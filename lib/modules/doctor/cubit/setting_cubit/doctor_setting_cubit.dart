import 'package:accura_kosba_task/models/get_doctor.dart';
import 'package:accura_kosba_task/network/api_provider.dart';
import 'package:accura_kosba_task/shared/constants.dart';
import 'package:accura_kosba_task/shared/end_points.dart';
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
}


