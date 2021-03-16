abstract class DoctorSettingStates {}

class DoctorSettingInitialState extends DoctorSettingStates {}

class DoctorSettingLoadingState extends DoctorSettingStates {}

class DoctorSettingSuccessState extends DoctorSettingStates {
  final message;

  DoctorSettingSuccessState({this.message});
}

class DoctorSettingErrorState extends DoctorSettingStates {
  final error;
  DoctorSettingErrorState({this.error});
}
