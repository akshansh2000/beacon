import 'dart:convert';

RegExp regex =
    RegExp("(?<=^https:\/\/app\.beacon\.cce\/)[A-Za-z0-9+\/]+={0,2}\$");

String encodeIdToUrl(String id) {
  return "https://app.beacon.cce/" + base64Encode(Utf8Encoder().convert(id));
}

String decodeIdFromUrl(String url) {
  return String.fromCharCodes(base64Decode(regex.firstMatch(url).group(0)));
}
