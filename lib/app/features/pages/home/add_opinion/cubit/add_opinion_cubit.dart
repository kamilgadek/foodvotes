import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


part 'add_opinion_state.dart';

class AddOpinionCubit extends Cubit<AddOpinionState> {
  AddOpinionCubit()
      : super(const AddOpinionState(
          pizzaName: '',
          restaurantName: '',
          rating: 0,
          isLoading: false,
        ));

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const AddOpinionState(
        pizzaName: '',
        restaurantName: '',
        rating: 0,
        isLoading: true,
      ),
    );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
