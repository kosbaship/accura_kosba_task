abstract class DocAssistStates {}

class DocAssistInitialState extends DocAssistStates {}

class DocAssistLoadingState extends DocAssistStates {}

class DocAssistSuccessState extends DocAssistStates {}

class DocAssistErrorState extends DocAssistStates {
  final error;
  DocAssistErrorState(this.error);
}


class DocAssistSwitchButtonState extends DocAssistStates {}


class DocAssistSelectWeekDayState extends DocAssistStates {}
