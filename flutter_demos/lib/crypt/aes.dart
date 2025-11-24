/* File: aes.dart
 * Created by GYGES.Harrison on 2024/11/6 at 09:50
 * Copyright © 2024 GYGES Limited.
 */

import 'dart:convert';
import 'dart:math';
import 'package:encrypt/encrypt.dart' as encrypt;

String aesEncryptCBC(String keyStr, String ivStr, String plainText) {
  // 将密钥和 IV 转换为字节数组
  final key = encrypt.Key(const Utf8Encoder().convert(keyStr));
  final iv = encrypt.IV(const Utf8Encoder().convert(ivStr));

  // 使用 AES CBC 模式，NoPadding 填充
  final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));

  // 将明文转换为字节数组
  final inputBytes = const Utf8Encoder().convert(plainText);

  // 加密数据
  final encrypted = encrypter.encryptBytes(inputBytes, iv: iv);
  // var list = convertListToHex(encrypted.bytes);
  // print('====== $list');
  // 返回加密数据的 Base64 编码字符串
  return encrypted.base64;
}

String aesDecryptCBC(String keyStr, String ivStr, String encryptedBase64) {
  // 将密钥和 IV 转换为字节数组
  final key = encrypt.Key(const Utf8Encoder().convert(keyStr));
  final iv = encrypt.IV(const Utf8Encoder().convert(ivStr));

  // 使用 AES CBC 模式，NoPadding 填充
  final encryptor = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));

  // 将 Base64 编码的密文转换为字节数组
  final encryptedBytes = encrypt.Encrypted.fromBase64(encryptedBase64);

  // 解密数据
  final decrypted = encryptor.decryptBytes(encryptedBytes, iv: iv);

  // 将解密后的字节数据转换为字符串并去除可能的填充空格
  return const Utf8Decoder().convert(decrypted).trim();
}

String randomStr(int len) {
  final random = Random();
  const chars =
      '1234567890AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  final randomString =
      List.generate(len, (index) => chars[random.nextInt(chars.length)]).join();
  return randomString;
}

// String aesEncrypt(String input, String key, String iv,
//     {String? padding = 'PKCS7'}) {
//   final aes =
//   Encrypter(AES(Key.fromUtf8(key), mode: AESMode.ecb, padding: padding));
//   List<int> list = utf8.encode(input).toList();
//   if (list.length % 16 > 0) {
//     int balance = 16 - (list.length % 16);
//     list.addAll(List.filled(balance, 0));
//   }
//   return aes
//       .encryptBytes(list, iv: IV.fromUtf8(iv), associatedData: Uint8List(8))
//       .base64;
// }
//
// String encryptCBC(String keyStr, String ivStr, String inputData) {
//
//   List<int> input = utf8.encode(inputData).toList();
//   // AES密钥，使用UTF-8编码
//   final key = Key(Utf8Encoder().convert(keyStr));
//
//   // IV向量，使用UTF-8编码
//   final iv = IV(Utf8Encoder().convert(ivStr));
//
//   // 使用AES CBC模式和PKCS7填充
//   final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'CBC/PKCS5Padding')); //AES/CBC/PKCS5Padding
//
//   // 加密输入数据
//   final encrypted = encrypter.encryptBytes(input, iv: iv);
//
//   // 返回加密后的字节数据
//   //Uint8List list = encrypted.bytes;
//   return encrypted.base64;
// }
//
// // String ecbEncrypt(String input, String key) {
// //   final aes = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.ecb));
// //   List<int> list = utf8.encode(input).toList();
// //   if (list.length % 16 > 0) {
// //     int balance = 16 - (list.length % 16);
// //     list.addAll(List.filled(balance, 0));
// //   }
// //   return aes.encryptBytes(list, associatedData: Uint8List(8)).base64;
// // }
// //
// // String ecbDecrypt(String input, String key) {
// //   final ecb = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.ecb));
// //   return ecb.decrypt64(input, associatedData: Uint8List(8));
// // }
//
// String aes128Encrypt(String input, String key, String iv) {
//   final aes = Encrypter(AES(Key.fromBase16(key), mode: AESMode.cbc));
//   return aes
//       .encryptBytes(convertHexToList(input),
//       iv: IV(Uint8List.fromList(convertHexToList(iv))))
//       .base16;
// }
//
//
// String aes128Decrypt(String input, String key, String iv) {
//   final aes = Encrypter(AES(Key.fromBase16(key), mode: AESMode.cbc));
//   try {
//     return convertListToHex(aes.decryptBytes(Encrypted.fromBase16(input),
//         iv: IV(Uint8List.fromList(convertHexToList(iv)))));
//   } catch (_) {
//     return '';
//   }
// }
//
String convertListToHex(List<int> list) {
  return list.map((int value) {
    // Convert each integer to a 2-digit hex string
    return value.toRadixString(16).padLeft(2, '0');
  }).join(); // Join all hex strings into a single string
}
//
// int convertHexToInt(String hex, {bool big = true}) {
//   if (big) {
//     return int.parse(hex, radix: 16);
//   }
//   return int.parse(convertListToHex(convertHexToList(hex).reversed.toList()),
//       radix: 16);
// }
//
// List<int> convertIntToList(int value, {int? length, bool big = true}) {
//   List<int> bytes = [];
//   if (length == null) {
//     bytes = convertHexToList(value.toRadixString(16));
//   } else {
//     bytes = List<int>.filled(length, 0);
//     for (var i = 0; i < length; i++) {
//       bytes[i] = (value >> ((length - 1 - i) * 8)) & 0xFF;
//     }
//   }
//   if (!big) {
//     bytes = bytes.reversed.toList();
//   }
//   return bytes;
// }
//
// List<int> convertHexToList(String hexString) {
//   String hexStr = hexString;
//   if (hexString.length % 2 != 0) {
//     hexStr = "0$hexString";
//   }
//   List<int> result = [];
//   for (int i = 0; i < hexStr.length; i += 2) {
//     // Take two characters from the string
//     String hex = hexStr.substring(i, i + 2);
//     // Convert hex string to integer
//     int value = int.parse(hex, radix: 16);
//     result.add(value);
//   }
//   return result;
// }
