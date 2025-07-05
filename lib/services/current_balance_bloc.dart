import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BalanceEvent {}

class GetBalance extends BalanceEvent {}

class UpdateBalance extends BalanceEvent {
  final double doubleNewBalance;
  UpdateBalance(this.doubleNewBalance);
}

class CurrentBalance extends Bloc<BalanceEvent, double> {
  CurrentBalance() : super(0) {
    on<GetBalance>((event, emit) => emit(state));
    on<UpdateBalance>((event, emit) => emit(event.doubleNewBalance));
  }
}
