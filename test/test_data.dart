import 'package:own_redux/store.dart';

enum Actions { increment, decrement }

int intReducer(int state, dynamic action) {
  return action == Actions.increment ? state + 1 : state - 1;
}

class TestMiddleware extends MiddlewareClass<int> {
  int counter = 0;

  @override
  void call(Store<int> store, action, Dispatcher next) {
    counter++;
    next(action);
  }
}