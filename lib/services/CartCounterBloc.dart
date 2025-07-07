import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CartCounterEvent {}

class Increment extends CartCounterEvent {}

class Decrement extends CartCounterEvent {}

class CounterState {
  final int quantity;
  CounterState({required this.quantity});
}

class CartCounterBloc extends Bloc<CartCounterEvent, CounterState> {
  CartCounterBloc() : super(CounterState(quantity: 1)) {
    on<Increment>(
      (event, emit) => emit(CounterState(quantity: state.quantity + 1)),
    );
    on<Decrement>((event, emit) {
      if (state.quantity > 1) {
        emit(CounterState(quantity: state.quantity - 1));
      }
    });
  }
}
