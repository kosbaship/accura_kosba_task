import 'package:accura_kosba_task/network/api_provider.dart';
import 'package:accura_kosba_task/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  // we receive our list normally
  List listOfPostsData = [];
  
  getData() {
   emit(HomeLoadingState());

   APIProvider.fetchData(path: kPostsPath).then((listOfPosts) async{

     listOfPostsData = listOfPosts.data;

     emit(HomeSuccessState());
     print('\n=========================================================');
     print(listOfPostsData[0]['title']);
     print('=========================================================\n\n');
    }).catchError((e) {
      emit(HomeErrorState(e.toString()));
    });
  }

}