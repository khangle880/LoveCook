import 'package:rxdart/rxdart.dart';

class ThrottleHelper {
  late final PublishSubject<Function()> throttler;
  ThrottleHelper() {
    throttler = PublishSubject<Function()>();
  }

  Function() throttle(int throttleDurationInMillis, Function() function) {
    throttler
        .throttleTime(Duration(milliseconds: throttleDurationInMillis))
        .forEach(
      (f) {
        f();
      },
    );

    return () {
      throttler.add(function);
    };
  }

  dispose() {
    throttler.close();
  }
}
