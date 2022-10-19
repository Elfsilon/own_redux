import 'package:own_redux/utils.dart';

import '../models/app_state.dart';
import 'status_reducer.dart';
import 'user_reducers.dart';

AppState rootReducer(AppState state, action) => AppState(
  user: userReducer(state.user, action), 
  status: appStatusReducer(state.status, action),
);