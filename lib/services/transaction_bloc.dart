import 'package:flutter_bloc/flutter_bloc.dart';

abstract class TransactionEvent {}

class AddTransaction extends TransactionEvent {}

class RemoveTransaction extends TransactionEvent {}

class UpdateTransaction extends TransactionEvent {
  final int newTransaction;
  UpdateTransaction(this.newTransaction);
}

class TransactionBloc extends Bloc<TransactionEvent, int> {
  TransactionBloc() : super(0) {
    on<AddTransaction>((event, emit) => emit(state + 1));
    on<RemoveTransaction>((event, emit) => emit(state - 1));
    on<UpdateTransaction>((event, emit) => emit(event.newTransaction));
  }
}
