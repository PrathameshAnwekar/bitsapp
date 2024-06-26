import 'package:logger_plus/logger_plus.dart';

final _logger = Logger(
  printer: PrettyPrinter(
      methodCount: 5, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 60, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
      ),
);

void dlog(String message) {
  // _logger.d("DEBUG:\t$message");
}

void elog(String message) {
  _logger.e("ERROR:\t$message");
}

void ilog(String message) {
  _logger.i("INFO:\t$message");
}

void wtflog(String message) {
  _logger.wtf("WTF:\t$message");
}

void wlog(String message) {
  _logger.w("WARNING:\t$message");
}

void vlog(String message) {
  _logger.v("VERBOSE:\t$message");
}
