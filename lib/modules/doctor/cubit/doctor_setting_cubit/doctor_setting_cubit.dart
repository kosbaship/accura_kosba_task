import 'package:accura_kosba_task/models/get_doctor.dart';
import 'package:accura_kosba_task/network/api_provider.dart';
import 'package:accura_kosba_task/shared/constants.dart';
import 'package:accura_kosba_task/shared/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'doctor_setting_states.dart';

class DoctorSettingCubit extends Cubit<DoctorSettingStates> {
  DoctorSettingCubit() : super(DoctorSettingInitialState());

  static DoctorSettingCubit get(context) => BlocProvider.of(context);

  DoctorData doctorData = DoctorData();

  getDoctorSettingsData() {
    emit(DoctorSettingLoadingState());

    APIProvider.fetchData(path: GET_DOCTOR_END_POINT, data: {
      'access_key': 'Jd5522SA523aaaW2e25e5rk',
      'access_password': 'J52Df3e6Wrtt5F2eeeWq220',
      'doctorId': '665',
    }).then((response) async {
      doctorData = DoctorData.fromJson(response.data);
      emit(DoctorSettingSuccessState());
    }).catchError((e) {
      emit(DoctorSettingErrorState(error: e.toString()));
    });
  }

  updateDoctorSettingsData() {
    emit(DoctorSettingLoadingState());

    Map<String, dynamic> _body = {
      'access_key': 'Jd5522SA523aaaW2e25e5rk',
      'access_password': 'J52Df3e6Wrtt5F2eeeWq220',
      'userId': '665',
      'typesPrices': '${reformatePriceForApi()}',
    };

    /// clinic
    for (var i = 0;
        i <
            doctorData.result.availabilityList[CLINIC_INDEX]
                .availabilityTimeList.length;
        i++) {
      _body.addAll({
        'disableClinic':
            '${doctorData.result.availabilityList[CLINIC_INDEX].isActive}' ?? '0'
      });
      _body.addAll({
        'clinicDays[$i]':
            '${doctorData.result.availabilityList[CLINIC_INDEX].availabilityTimeList[i].wdayDayName}' ??
                ''
      });
      _body.addAll({
        'clinicFrom[$i]':
            '${doctorData.result.availabilityList[CLINIC_INDEX].availabilityTimeList[i].wdayFrom}' ??
                ''
      });
      _body.addAll({
        'clinicTo[$i]':
            '${doctorData.result.availabilityList[CLINIC_INDEX].availabilityTimeList[i].wdayTo}' ??
                ''
      });
      _body.addAll({
        'clinicFrom2[$i]':
            '${doctorData.result.availabilityList[CLINIC_INDEX].availabilityTimeList[i].wdayFrom2}' ??
                ''
      });
      _body.addAll({
        'clinicTo2[$i]':
            '${doctorData.result.availabilityList[CLINIC_INDEX].availabilityTimeList[i].wdayTo2}' ??
                ''
      });
    }

    /// voice
    for (var i = 0;
        i <
            doctorData.result.availabilityList[VOICE_INDEX].availabilityTimeList
                .length;
        i++) {
      _body.addAll({
        'disableVoice':
            '${doctorData.result.availabilityList[VOICE_INDEX].isActive}' ?? '0'
      });
      _body.addAll({
        'voiceDays[$i]':
            '${doctorData.result.availabilityList[VOICE_INDEX].availabilityTimeList[i].wdayDayName}' ??
                ''
      });
      _body.addAll({
        'voiceFrom[$i]':
            '${doctorData.result.availabilityList[VOICE_INDEX].availabilityTimeList[i].wdayFrom}' ??
                ''
      });
      _body.addAll({
        'voiceTo[$i]':
            '${doctorData.result.availabilityList[VOICE_INDEX].availabilityTimeList[i].wdayTo}' ??
                ''
      });
      _body.addAll({
        'voiceFrom2[$i]':
            '${doctorData.result.availabilityList[VOICE_INDEX].availabilityTimeList[i].wdayFrom2}' ??
                ''
      });
      _body.addAll({
        'voiceTo2[$i]':
            '${doctorData.result.availabilityList[VOICE_INDEX].availabilityTimeList[i].wdayTo2}' ??
                ''
      });
    }

    /// video
    for (var i = 0;
        i <
            doctorData.result.availabilityList[VIDEO_INDEX].availabilityTimeList
                .length;
        i++) {
      _body.addAll({
        'disableVideo':
            '${doctorData.result.availabilityList[VIDEO_INDEX].isActive}' ?? '0'
      });
      _body.addAll({
        'videoDays[$i]':
            '${doctorData.result.availabilityList[VIDEO_INDEX].availabilityTimeList[i].wdayDayName}' ??
                ''
      });
      _body.addAll({
        'videoFrom[$i]':
            '${doctorData.result.availabilityList[VIDEO_INDEX].availabilityTimeList[i].wdayFrom}' ??
                ''
      });
      _body.addAll({
        'videoTo[$i]':
            '${doctorData.result.availabilityList[VIDEO_INDEX].availabilityTimeList[i].wdayTo}' ??
                ''
      });
      _body.addAll({
        'videoFrom2[$i]':
            '${doctorData.result.availabilityList[VIDEO_INDEX].availabilityTimeList[i].wdayFrom2}' ??
                ''
      });
      _body.addAll({
        'videoTo2[$i]':
            '${doctorData.result.availabilityList[VIDEO_INDEX].availabilityTimeList[i].wdayTo2}' ??
                ''
      });
    }

    /// spot
    for (var i = 0;
        i <
            doctorData.result.availabilityList[SPOT_INDEX].availabilityTimeList
                .length;
        i++) {
      _body.addAll({
        'disableSpot':
            '${doctorData.result.availabilityList[SPOT_INDEX].isActive}' ?? '0'
      });
      _body.addAll({
        'spotDays[$i]':
            '${doctorData.result.availabilityList[SPOT_INDEX].availabilityTimeList[i].wdayDayName}' ??
                ''
      });
      _body.addAll({
        'spotFrom[$i]':
            '${doctorData.result.availabilityList[SPOT_INDEX].availabilityTimeList[i].wdayFrom}' ??
                ''
      });
      _body.addAll({
        'spotTo[$i]':
            '${doctorData.result.availabilityList[SPOT_INDEX].availabilityTimeList[i].wdayTo}' ??
                ''
      });
      _body.addAll({
        'spotFrom2[$i]':
            '${doctorData.result.availabilityList[SPOT_INDEX].availabilityTimeList[i].wdayFrom2}' ??
                ''
      });
      _body.addAll({
        'spotTo2[$i]':
            '${doctorData.result.availabilityList[SPOT_INDEX].availabilityTimeList[i].wdayTo2}' ??
                ''
      });
    }
    print(_body);
    FormData formData = FormData.fromMap(_body);
    APIProvider.fetchData(path: UPDATE_DOCTOR_END_POINT, data: formData)
        .then((response) async {
      if (response.data['status'] == 200) {
        emit(
            DoctorSettingSuccessState(message: 'Settings Updated Successfuly'));
      } else {
        emit(DoctorSettingErrorState());
      }
    }).catchError((e) {
      emit(DoctorSettingErrorState(error: e.toString()));
    });
  }

  reformatePriceForApi() {
    String result = '';
    for (var i = 0; i < doctorData.result.availabilityList.length; i++) {
      if (i == CLINIC_INDEX)
        result +=
            'clinic_' + doctorData.result.availabilityList[i].priceValue + '|';
      if (i == VOICE_INDEX)
        result +=
            'voice_' + doctorData.result.availabilityList[i].priceValue + '|';
      if (i == VIDEO_INDEX)
        result +=
            'video_' + doctorData.result.availabilityList[i].priceValue + '|';
      if (i == SPOT_INDEX)
        result += 'spot_' + doctorData.result.availabilityList[i].priceValue;
    }
    return result;
  }
}
