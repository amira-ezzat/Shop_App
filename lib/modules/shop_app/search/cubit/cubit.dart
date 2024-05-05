import 'package:bloc/bloc.dart';
import 'package:chats_app/modules/shop_app/search/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../model/shop_app/search_model.dart';
import '../../../../shared/compononse/constants.dart';
import '../../../../shared/network/end_point.dart';
import '../../../../shared/network/remote/dio_helpeer.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel?  model;
  void search(String? text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(
        url:SEARCH,
        token: token,
        data:{
      'text':text,
        }).then((value) {
      // print(value.data);
      model= SearchModel.fromJson(value.data);
      // print(value.data['message']);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }

}