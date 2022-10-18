import 'package:own_redux/store.dart';

Reducer<T> combineReducers<T>(Iterable<Reducer<T>> reducers) {
  return (T state, dynamic action) {
    for (final reducer in reducers) {
      state = reducer(state, action);
    }
    return state;
  };
}

class TypedReducer<T, A> implements ReducerClass<T> {
  const TypedReducer(this.reducer);

  final T Function(T state, A action) reducer;

  @override
  T call(T state, action) {
    if (action is A) return reducer(state, action);
    return state;
  }
}

class TypedMiddleware<T, A> implements MiddlewareClass<T> {
  const TypedMiddleware(this.middleware);

  final dynamic Function(Store<T> store, A action, Dispatcher next) middleware;

  @override
  void call(Store<T> store, action, Dispatcher next) {
    if (action is A) {
      middleware(store, action, next);
    } else {
      next(action);
    }
  }
}