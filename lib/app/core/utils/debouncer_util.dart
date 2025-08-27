// ignore_for_file: unnecessary_this

import 'dart:async';
import 'dart:ui';

class DebouncerUtil {
  Duration? delay;
  Timer? _timer;
  VoidCallback? _callback;

  DebouncerUtil({this.delay = const Duration(milliseconds: 500)});


  void debounce(VoidCallback callback) {
    _callback = callback;
    cancel();
    _timer = Timer(delay!, this.flush);
  }
 
  void cancel() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void flush() {
    _callback!();
    cancel();
  }
}
