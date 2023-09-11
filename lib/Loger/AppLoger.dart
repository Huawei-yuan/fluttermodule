import 'package:logger/logger.dart';

final AppLoger loger = AppLoger();

///封装Loger日志，用于配置和app打印日志
class AppLoger {
  static final AppLoger _singleton = AppLoger._internal();
  final Logger _logger = Logger(
    filter: DevelopmentFilter(),
    printer: PrettyPrinter(
        methodCount: 2, // Number of method calls to be displayed
        errorMethodCount: 8, // Number of method calls if stacktrace is provided
        lineLength: 120, // Width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
    ),
    output: null //Use the default LogOutput (-> send everything to console)

  );

  factory AppLoger() {
    return _singleton;
  }

  AppLoger._internal();

  void t(dynamic message) {
    _logger.t(message);
  }

  void d(dynamic message) {
    _logger.d(message);
  }

  void i(dynamic message) {
    _logger.i(message);
  }

  void w(dynamic message) {
    _logger.w(message);
  }

  void e(dynamic message) {
    _logger.e(message);
  }

  void f(dynamic message, {  Object? error, StackTrace? stackTrace}) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  void log(dynamic message, {Level level = Level.info}) {
    _logger.log(level, message);
  }

  // 可以添加其他方法来支持不同的日志输出目标，例如文件、Logcat、云端等
  void logError(dynamic error, [StackTrace? stackTrace]) {
    _logger.e(error, stackTrace: stackTrace);
  }
}