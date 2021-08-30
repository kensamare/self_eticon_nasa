import 'package:eticon_api/api_errors.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_eticon_nasa/models/mars_photo_model.dart';
import 'package:self_eticon_nasa/screens/main_screen/cubit/main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenLoadingState());

  Future<void> getData() async {
    try {
      List<MarsPhotoModel> result = [];
      Map<String, dynamic> response = await Api.get(
          method: 'rovers/curiosity/photos',
          query: {
            'api_key': 'hTyuBrb3xGcFIbQkGlsb8aMPurTJjQKuB20eAe65',
            'sol': 1000
          });
      for(var photo in response['photos']){
        result.add(MarsPhotoModel.fromJson(photo));
      }
      emit(MainScreenLoadedState(result: result));
    } on APIException catch (error) {
      if (error.code == 0) {
        emit(MainScreenErrorState(errorMsg: 'No Internet connection'));
      } else {
        emit(MainScreenErrorState(errorMsg: 'Ups...'));
      }
    }
  }
}
