import 'package:intl/intl.dart';
import 'package:html/parser.dart';

class Utils {
  static final formatCurrency = NumberFormat.currency(
    locale: 'vi-VN',
    symbol: 'VND',
    decimalDigits: 0,
  );

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }
}
