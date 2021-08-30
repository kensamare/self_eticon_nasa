import 'package:self_eticon_nasa/models/mars_photo_model.dart';

abstract class MainScreenState {}

class MainScreenLoadingState extends MainScreenState {}

class MainScreenLoadedState extends MainScreenState {
  final List<MarsPhotoModel> result;

  MainScreenLoadedState({required this.result});
}

class MainScreenErrorState extends MainScreenState {
  final String errorMsg;

  MainScreenErrorState({required this.errorMsg});
}
