import 'package:customsoft_exam/src/services/data/http_service/headers/header.dart';

class ContentType extends CustomHeaders<ContentTypeHeader> {
  late Map<String, String> header;
  final ContentTypeHeader selection;

  ContentType(this.selection) : super(selection) {
    for (ContentTypeSelections selection in ContentTypeSelections.values) {
      if (this.selection.headerType == selection) {
        this.header = this.selection.getHeader;
        continue;
      }
    }
  }
}

class AplicationJson implements ContentTypeHeader {
  Map<String, String> get getHeader =>
      {'Content-Type': 'application/json; charset=utf-8'};
  ContentTypeSelections get headerType =>
      ContentTypeSelections.x_www_form_urlencoded;
}

class AplicationPDF implements ContentTypeHeader {
  Map<String, String> get getHeader =>
      {'Content-Type': 'application/pdf; charset=utf-8'};
  ContentTypeSelections get headerType =>
      ContentTypeSelections.x_www_form_urlencoded;
}

class AplicationXWWWFormUrlEncoded implements ContentTypeHeader {
  Map<String, String> get getHeader =>
      {"Content-Type": "application/x-www-form-urlencoded"};
  ContentTypeSelections get headerType => ContentTypeSelections.json;
}

abstract class ContentTypeHeader implements Header<ContentTypeSelections> {}

abstract class CustomHeaders<T> {
  late Map<String, String> header;
  final T selection;

  CustomHeaders(this.selection);
}
