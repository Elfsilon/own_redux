import 'package:own_redux/utils.dart';

import '../actions/status_actions.dart';
import '../models/app_state.dart';

final appStatusReducer = combineReducers<AppStatus>([
  TypedReducer<AppStatus, AppIsReadyAction>(appIsReadyReducer),
  TypedReducer<AppStatus, AppIsLoadingAction>(appIsLoadingReducer),
]);

AppStatus appIsReadyReducer(AppStatus state, dynamic action) => AppStatus.ready;

AppStatus appIsLoadingReducer(AppStatus state, dynamic action) => AppStatus.loading;