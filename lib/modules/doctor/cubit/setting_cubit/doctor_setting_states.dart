abstract class DoctorSettingStates {}

class DoctorSettingInitialState extends DoctorSettingStates {}

class DoctorSettingLoadingState extends DoctorSettingStates {}

class DoctorSettingSuccessState extends DoctorSettingStates {}

class DoctorSettingErrorState extends DoctorSettingStates {
  final error;
  DoctorSettingErrorState(this.error);
}


class DoctorSettingSwitchButtonState extends DoctorSettingStates {}


class DoctorSettingClinicSelectWeekDayState extends DoctorSettingStates {}
class DoctorSettingVoiceSelectWeekDayState extends DoctorSettingStates {}
class DoctorSettingVideoSelectWeekDayState extends DoctorSettingStates {}
class DoctorSettingSpotSelectWeekDayState extends DoctorSettingStates {}
