import 'dart:convert';

import '../delta_markdown/src/html_renderer.dart';
import '../flutter_quill.dart' hide Text;

class QuillConverter {
  QuillConverter._();

  static String deltaToHtml(Delta? delta) {
    var html = '';

    try {
      final convertedValue = jsonEncode(delta!.toJson());
      final markdown = deltaToMarkdown(convertedValue);
      html = markdownToHtml(markdown);
    } catch (_) {
      html = '';
    }

    return html;
  }
}
