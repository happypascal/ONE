class Const {
  static const DEFAULT_ADDRESS = '192.168.8.1';

  //Coils
  //TODO add const for release
  static int OPEN_CLOSE_SET = 133;
  static const int HUM_MINUS = 8;
  static const int HUM_PLUS = 9;
  static const int TEMP_MINUS = 35;
  static const int TEMP_PLUS = 34;

  //Holding Registers
  static const int HUM_MEASURE = 20;
  static const int HUM_SET = 0;
  static const int TEMP_MEASURE = 50;
  static const int TEMP_SET = 1;
  static const int OPEN_CLOSE_STATE = 33;

  static const String IMAGE_OPEN = 'assets/open.png';
  static const String IMAGE_CLOSE = 'assets/close.png';
  static const String IMAGE_MINUS = 'assets/minus.png';
  static const String IMAGE_PLUS = 'assets/plus.png';
}
