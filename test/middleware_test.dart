import 'package:own_redux/store.dart';
import 'package:test/test.dart';

import 'test_data.dart';

void main() {
  group("middleware tests", () {
    test('test counter middleware', () {
      final middleware = TestMiddleware();
      final store = Store<int>(
        intReducer, 
        initialState: 0,
        distinct: true,
        middleware: [middleware],
      );
      store.dispatch(Actions.increment);
      expect(middleware.counter == 1, true);
    });
  });
}