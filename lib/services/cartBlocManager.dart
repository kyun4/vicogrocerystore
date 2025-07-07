import 'package:vico_grocery_store/services/CartCounterBloc.dart';

class CartBlocManager {
  final Map<String, CartCounterBloc> _blocMap = {};

  CartCounterBloc getBlocForItem(String cartId) {
    return _blocMap.putIfAbsent(cartId, () => CartCounterBloc());
  }

  void disposeAll() {
    _blocMap.values.forEach((bloc) => bloc.close());
  }
}
