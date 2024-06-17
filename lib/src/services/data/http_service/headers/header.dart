mixin Header <T>{
  Map<String, String> get getHeader;
  T get headerType;
}

enum ContentTypeSelections { json, x_www_form_urlencoded }

enum AuthorizationSelections { basicAuth , bearer}