import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cb_home_screen.freezed.dart';

class CbHomeScreen extends Cubit<StHomeScreen> {
  CbHomeScreen() : super(const StHomeScreen.loaded());

  Future<void> getData() async {
    // try {
    //     Map<String, dynamic> response =
    //         await Api.get(method: 'method', testMode: true);
    //     emit(StHomeScreenLoaded());
    //   } on APIException catch (e) {
    //     emit(StHomeScreenError(error: e.code));
    //   }
  }
}

@freezed
abstract class StHomeScreen with _$StHomeScreen {
  const factory StHomeScreen.loading() = _Loading;
  const factory StHomeScreen.error(int? error, String? message) = _Error;
  const factory StHomeScreen.loaded() = _Loaded;
}