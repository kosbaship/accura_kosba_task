abstract class DoctorSettingStates {}

class DoctorSettingInitialState extends DoctorSettingStates {}

class DoctorSettingLoadingState extends DoctorSettingStates {}

class DoctorSettingSuccessState extends DoctorSettingStates {}

class DoctorSettingErrorState extends DoctorSettingStates {
  final error;
  DoctorSettingErrorState(this.error);
}
