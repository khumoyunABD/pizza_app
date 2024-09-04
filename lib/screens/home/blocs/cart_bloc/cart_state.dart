part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState({
    required this.itemCounter,
  });
  final int itemCounter;

  @override
  List<Object> get props => [itemCounter];
}

final class CartInitial extends CartState {
  const CartInitial({required super.itemCounter});
}
