abstract class DocAssistStates {}

class DocAssistInitialState extends DocAssistStates {}

class DocAssistLoadingState extends DocAssistStates {}

class DocAssistSuccessState extends DocAssistStates {}

class DocAssistErrorState extends DocAssistStates {
  final error;
  DocAssistErrorState(this.error);
}


class DocAssistSwitchButtonState extends DocAssistStates {}


class DocAssistClinicSelectWeekDayState extends DocAssistStates {}
class DocAssistVoiceSelectWeekDayState extends DocAssistStates {}
class DocAssistVideoSelectWeekDayState extends DocAssistStates {}
class DocAssistSpotSelectWeekDayState extends DocAssistStates {}
