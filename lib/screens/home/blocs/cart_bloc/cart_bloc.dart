import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartInitial(itemCounter: 0)) {
    on<AddItemEvent>((event, emit) {
      emit(CartState(itemCounter: state.itemCounter + 1));
    });
    on<RemoveItemEvent>((event, emit) {
      emit(CartState(itemCounter: state.itemCounter - 1));
    });
  }
}
