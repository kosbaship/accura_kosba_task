abstract class PharmacyStates {}

class PharmacyInitialState extends PharmacyStates {}

class PharmacyLoadingState extends PharmacyStates {}

class PharmacySuccessState extends PharmacyStates {}

class PharmacyErrorState extends PharmacyStates {
  final error;
  PharmacyErrorState(this.error);
}


class PharmacySwitchButtonState extends PharmacyStates {}


class PharmacyClinicSelectWeekDayState extends PharmacyStates {}
