import 'package:own_redux/store.dart';

import 'actions/status_actions.dart';
import 'actions/user_actions.dart';
import 'models/app_state.dart';
import 'models/user.dart';
import 'reducers/root_reducer.dart';

class Listener {
  String call(AppState state) 
    => "Got the state: ${state.user.name}, ${state.user.age}, ${state.user.accessLevel}, ${state.status}";
}

main() {
  final newUserData = User(
    name: "Bob", 
    age: 44
  );

  final initialState = AppState(
    user: User(name: "John", age: 22), 
    status: AppStatus.ready,
  );

  final store = Store<AppState>(rootReducer, initialState: initialState);

  final listener = Listener();
  store.changeStream.listen((state) => print(listener(state)));

  store.dispatch(AppIsLoadingAction());
  store.dispatch(ChangeUserAction(newUserData));
  store.dispatch(AppIsReadyAction());
}