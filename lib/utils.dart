import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

String replaceCharAt(String oldString, int index, String newChar) {
  return oldString.substring(0, index) +
      newChar +
      oldString.substring(index + 1);
}

extension E on String {
  String lastChars(int n) => substring(length - n);
}

extension StringExtension on String {
  String capitalize() {
    if (isNotEmpty) {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    }
    return this;
  }
}

Future<void> urlLauncher(String url, {bool? webview}) async {
  if (!await launchUrl(
    Uri.parse(url),
    mode: webview == true
        ? LaunchMode.inAppWebView
        : LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}

showToast(String text) {
  Fluttertoast.showToast(
      msg: text, toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
}

String removeHtmlTags(String html) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return html.replaceAll(exp, '');
}

class ThreatType {
  final String _text;
  bool _isSecure = true;

  ThreatType(this._text);

  void threatFound() => _isSecure = false;

  String get state => '$_text: ${_isSecure ? "Secured" : "Detected"}\n';
}
