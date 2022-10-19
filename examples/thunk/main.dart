import 'package:own_redux/middleware/thunk/redux_thunk.dart';
import 'package:own_redux/store.dart';
import 'package:own_redux/utils.dart';

// State
class AppState {
  const AppState({
    required this.counter,
    required this.isLoading,
  });

  final int counter;
  final bool isLoading;
}

// Actions
class SetAppIsLoadingAction {}
class SetAppIsReadyAction {}
class SetAppCounterAction {
  const SetAppCounterAction(this.value);

  final int value;
}

// Thunk actions
ThunkAction<AppState> fetchCounter() => (store) async {
  store.dispatch(SetAppIsLoadingAction());
  await Future.delayed(const Duration(seconds: 2));
  store.dispatch(SetAppCounterAction(3));
  store.dispatch(SetAppIsReadyAction());
};

// Reducers
AppState rootReducer(AppState state, action) => AppState(
  counter: appCounterReducer(state.counter, action), 
  isLoading: appStatusReducer(state.isLoading, action)
);

final appStatusReducer = combineReducers<bool>([
  TypedReducer<bool, SetAppIsLoadingAction>(setIsLoadingReducer),
  TypedReducer<bool, SetAppIsReadyAction>(setIsReadyReducer),
]);
bool setIsLoadingReducer(bool state, action) => true;
bool setIsReadyReducer(bool state, action) => false;

final appCounterReducer = combineReducers<int>([
  TypedReducer<int, SetAppCounterAction>(setAppCounterReducer),
]);
int setAppCounterReducer(int state, SetAppCounterAction action) => action.value;

// Logger
class Listener {
  String call(AppState state) => "Got the state: ${state.counter}, ${state.isLoading}";
}

void main() {
  final initialState = AppState(counter: 0, isLoading: false);
  final store = Store<AppState>(
    rootReducer, 
    initialState: initialState,
    middleware: [thunkMiddleware],
  );
  print("Initial store: ${store.state.counter}, ${store.state.isLoading}");

  final listener = Listener();
  store.changeStream.listen((state) {
    print(listener(state));
  });

  store.dispatch(fetchCounter());
}