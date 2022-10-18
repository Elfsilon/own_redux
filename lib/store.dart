typedef Reducer<T> = T Function(T state, dynamic action);

abstract class ReducerClass<T> {
  T call(T state, dynamic action);
}

typedef Dispatcher = dynamic Function(dynamic action);

typedef Middleware<T> = dynamic Function(
  Store<T> store,
  dynamic action,
  Dispatcher next,
);

abstract class MiddlewareClass<T> {
  void call(
    Store<T> store,
    dynamic action,
    Dispatcher next,
  );
}

class Store<T> {
  Reducer<T> reducer;

  late T _state;
  late List<Dispatcher> _dispatchers;

  Store(this.reducer, {
    required T initialState,
    List<Middleware<T>> middleware = const [],
    bool distinct = false,
  }) {
    _state = initialState;
    _dispatchers = _initDispatchers(
      middleware: middleware, 
      dispatcher: _createDispatcher(distinct),
    );
  }

  T get state => _state;

  Dispatcher _createDispatcher(bool distinct) {
    return (dynamic action) {
      final state = reducer(_state, action);
      if (distinct && state == _state) return;
      _state = state;
    };
  }

  List<Dispatcher> _initDispatchers({
    required List<Middleware<T>> middleware,
    required Dispatcher dispatcher,
  }) {
    final dispatchers = <Dispatcher>[dispatcher];

    for (final currentMiddleware in middleware.reversed) {
      final nextDispatcher = dispatchers.last;
      dispatchers.add(
        (dynamic action) => currentMiddleware(this, action, nextDispatcher)
      );
    }

    return dispatchers.reversed.toList();
  }

  dynamic dispatch(dynamic action) {
    return _dispatchers.first(action);
  }
}