import 'package:flutter_bloc/flutter_bloc.dart';

import 'doc_assist_states.dart';

class DocAssistCubit extends Cubit<DocAssistStates> {
  DocAssistCubit() : super(DocAssistInitialState());

  static DocAssistCubit get(context) => BlocProvider.of(context);

  bool switchValue=true;
  // we receive our list normally
  // List listOfPostsData = [];
  // getData() {
  //   emit(DocAssistLoadingState());
  //
  //   APIProvider.fetchData(path: kPostsPath).then((listOfPosts) async{
  //
  //     listOfPostsData = listOfPosts.data;
  //
  //     emit(DocAssistSuccessState());
  //     print('\n=========================================================');
  //     print(listOfPostsData[0]['title']);
  //     print('=========================================================\n\n');
  //   }).catchError((e) {
  //     emit(DocAssistErrorState(e.toString()));
  //   });
  // }

  toggleTheSwitch({value}){
    switchValue = value;
    emit(DocAssistSwitchButtonState());
  }

}