import 'package:flutter_bloc/flutter_bloc.dart';
import 'detail_event.dart';
import 'detail_state.dart';
import '../../data/repository/product_repository.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final ProductRepository repository;

  DetailBloc(this.repository) : super(DetailInitial()) {
    on<LoadDetail>((event, emit) async {
      emit(DetailLoading());
      try {
        final product = (await repository.getProducts())
            .firstWhere((item) => item.id == event.productId);
        emit(DetailLoaded(product));
      } catch (e) {
        emit(DetailError(e.toString()));
      }
    });
  }
}
