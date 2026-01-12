import 'dart:convert'; // For utf8.encode
import 'package:crypto/crypto.dart'; // For sha256

/// 计算 Map 的 SHA-256 哈希值
String calculateMapSha256(Map<String, dynamic> map) {
  //将 Map 的键按字母顺序排序，确保顺序一致
  var sortedKeys = map.keys.toList()..sort();

  // 将键值对转换成字符串，并用逗号分隔
  String mapString =
      sortedKeys.map((key) => '$key:${toSha256Value(map[key])}').join(',');
  print('========计算mapString结果 $mapString');
  // 将字符串进行 utf8 编码
  var bytes = utf8.encode(mapString);

  // 计算 SHA-256 哈希
  var digest = sha256.convert(bytes);

  return digest.toString(); // 返回哈希值的十六进制字符串表示
}

String toSha256Value(dynamic val) {
  String result = '';
  if (val is Map) {
    var sortedKeys = val.keys.toList()..sort();
    String mapString =
        sortedKeys.map((key) => '$key:${toSha256Value(val[key])}').join(',');
    result = '{$mapString}';
  } else if (val is List) {
    String listString = val.map((value) => toSha256Value(value)).join(',');
    result = '[$listString]';
  } else {
    result = '$val';
  }
  return result;
}

String hmac({required Map<String, dynamic> map, required hmacKey}) {
  //将 Map 的键按字母顺序排序，确保顺序一致
  var sortedKeys = map.keys.toList()..sort();
  // 将键值对转换成字符串，并用逗号分隔
  String mapString =
      sortedKeys.map((key) => '$key:${toSha256Value(map[key])}').join(',');
  // 使用 HMAC-SHA256 生成签名
  var hmac = Hmac(sha256, utf8.encode(hmacKey)); // 传入密钥
  var digest = hmac.convert(utf8.encode(mapString)); // 传入待签名数据
  return base64Encode(digest.bytes); // 返回 Base64 编码的签名
}

String demoHmac0() {
  return hmac(map: {
    'a': [
      2,
      3,
      4,
      5,
      {'a': 1, 'b': 2, 'a1': 3}
    ],
    'aa': 124,
    'bb': {'key0': 34, 'key1': 45, 'aa': 66},
    'ab': 'addd,fdhsfjdslfjskljfslfjdslfks,lfjsk'
  }, hmacKey: '234');
}

String demoHmac1() {
  return hmac(map: {
    'ab': 'addd,fdhsfjdslfjskljfslfjdslfks,lfjsk',
    'aa': 124,
    'a': [
      2,
      3,
      4,
      5,
      {'a': 1, 'b': 2, 'a1': 3}
    ],
    'bb': {'aa': 66, 'key0': 34, 'key1': 45},
  }, hmacKey: '234');
}
