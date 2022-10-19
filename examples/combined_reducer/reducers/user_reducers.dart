import 'package:own_redux/utils.dart';

import '../actions/user_actions.dart';
import '../models/user.dart';

final userReducer = combineReducers<User>([
  TypedReducer<User, ChangeUserAction>(changeUserReducer),
]);

User changeUserReducer(User state, ChangeUserAction action) => action.user;