import 'package:own_redux/store.dart';

typedef ThunkAction<T> = dynamic Function(Store<T> store);

abstract class ThunkActionClass<T> {
  dynamic call(Store<T> store);
}

typedef ExtraArgumentThunkAction<T, S> = dynamic Function(Store<T> store, S argument);

abstract class ExtraArgumentThunkActionClass<T, S> {
  dynamic call(Store<T> store, S argument);
}

dynamic thunkMiddleware<T>(
  Store<T> store,
  dynamic action,
  Dispatcher next,
) {
  if (action is ThunkAction<T>) return action(store);
  return next(action);
}

class ExtraArgumentThunkMiddleware<T, S> implements MiddlewareClass<T> {
  const ExtraArgumentThunkMiddleware(this.argument);
  
  final S argument;

  @override
  dynamic call(Store<T> store, action, Dispatcher next) {
    if (action is ExtraArgumentThunkAction<T, S>) return action(store, argument);
    return next(action);
  }
}