

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/get_vendor.dart';
import '../../../network/api_provider.dart';
import '../../../shared/end_points.dart';
import 'Pharmacy_states.dart';

class PharmacyCubit extends Cubit<PharmacyStates> {
  PharmacyCubit() : super(PharmacyInitialState());

  static PharmacyCubit get(context) => BlocProvider.of(context);

  VendorData vendorData = VendorData();
  // List<AvailabilityTimeList> buttonSelectedList = [];
  //
  // List<String> pharmaSelectedDays = ['day', 'day', 'day', 'day', 'day', 'day', 'day'];

  bool buttonSwitch = false;


  getData() {

    emit(PharmacyLoadingState());

    APIProvider.fetchData(
        path: GET_VENDOR_END_POINT,
        data: {
          'access_key': 'Jd5522SA523aaaW2e25e5rk',
          'access_password': 'J52Df3e6Wrtt5F2eeeWq220',
          'vendorId': '721',
      }
    ).then((response) async{
      // vendorData =  VendorData.fromJson(response.data);

      // clinicSwitch = doctorData.result.availabilityList[0].isActive == 1;
      // clinicSelectedList =  doctorData.result.availabilityList[0].availabilityTimeList;

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




  toggleTheSwitch({@required value}){
       buttonSwitch = value;
    emit(PharmacySwitchButtonState());
  }

  // selectWeekDay({@required value, @required index, @required indexOfListLength}){
  //
  //       pharmaSelectedDays[indexOfListLength] = value;
  //       emit(PharmacyClinicSelectWeekDayState());
  //
  // }

}
