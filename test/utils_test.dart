import 'dart:developer';

import 'package:own_redux/store.dart';
import 'package:own_redux/utils.dart';
import 'package:test/test.dart';

class Action1 {}
class Action2 {}
class Action3 {}

String reducer1(String state, dynamic action) => "reducer1";
String reducer2(String state, dynamic action) => "reducer2";

void main() {
  group("combined reducer tests", () {
    test('non-typed reducer invokes all subredusers', () {
      final reducer = combineReducers([
        reducer1, 
        reducer2,
      ]);
      final store = Store<String>(reducer, initialState: "");
      expect(store.state == "", true);
      store.dispatch(Action1());
      expect(store.state == "reducer2", true);
    });

    test("reducer doesn't handle unknown actions", () {
      final reducer = combineReducers<String>([
        TypedReducer<String, Action1>(reducer1),
        TypedReducer<String, Action2>(reducer2),
      ]);
      final store = Store<String>(reducer, initialState: "");
      expect(store.state == "", true);
      store.dispatch(Action1());
      expect(store.state == "reducer1", true);
      store.dispatch(Action2());
      expect(store.state == "reducer2", true, reason: "State is not reducer2");
      store.dispatch(Action3());
      expect(store.state == "reducer2", true);      
    });

    test("typed reducers work with untyped", () {
      final reducer = combineReducers<String>([
        reducer1,
        TypedReducer<String, Action2>(reducer2),
      ]);
      final store = Store<String>(reducer, initialState: "");
      expect(store.state == "", true);
      store.dispatch(Action1());
      expect(store.state == "reducer1", true);
    });
  });
}