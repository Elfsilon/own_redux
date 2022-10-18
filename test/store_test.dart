import 'package:own_redux/store.dart';
import 'package:test/test.dart';

import 'test_data.dart';

void main() {
  group("store tests", () {
    test('init store', () {
      final store = Store<int>(intReducer, initialState: 0);
      expect(store.state == 0, true);
      store.dispatch(Actions.increment);
      expect(store.state == 1, true);
    });
  });
}