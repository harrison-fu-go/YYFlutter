/* File: string_util.dart
 * Created by GYGES.Harrison on 2024/11/22 at 11:30
 * Copyright © 2024 GYGES Limited.
 */
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

String limitToByteLen(String input, int maxBytes) {
  List<int> encoded = utf8.encode(input); //change to UTF-8 List.
  //if encode.length < max bytes, then return the original string
  if (encoded.length <= maxBytes) {
    return input;
  }
  //find the single char max bytes location.
  int cutIndex = maxBytes;
  while (cutIndex > 0 && (encoded[cutIndex] & 0xC0) == 0x80) {
    cutIndex--; //jump middle bytes.
  }
  //cut & decode to string.
  List<int> truncated = encoded.sublist(0, cutIndex);
  return utf8.decode(truncated, allowMalformed: true); //save decode.
}

extension ExtensionListInt on List<int> {

  // //include start. but not unclude end.
  String toStrByRange({required int start, required int end}) {
    end = end.clamp(start, length);
    List<int> subList = sublist(start, end);
    subList = getCompleteUtf8Bytes(subList);
    String result = utf8.decode(subList, allowMalformed: true);
    return result;
  }

  String toStrByLoc({required int loc, required int len}) {
    return toStrByRange(start: loc, end: loc + len);
  }

  ///check if the  UTF-8 bytes list integrity， if not then return the integrity part.
  List<int> getCompleteUtf8Bytes(List<int> bytes) {
    int continuationBytes = 0;
    for (int i = bytes.length - 1; i >= 0; i--) {
      ///from tail to header
      int byte = bytes[i];

      if ((byte & 0xC0) == 0x80) {
        //is body byte. (10xxxxxx)
        continuationBytes++;
      } else {
        if (continuationBytes == 0) {
          //is the header
          if ((byte & 0x80) == 0) {
            return bytes; //integrity single byte char.
          } else {
            return bytes.sublist(0, i); //remove the error byte. then return .
          }
        }
        //check the char's bytes count.
        int expectedBytes;
        if ((byte & 0xE0) == 0xC0) {
          expectedBytes = 1; // 2 bytes char
        } else if ((byte & 0xF0) == 0xE0) {
          expectedBytes = 2; // 3 bytes char
        } else if ((byte & 0xF8) == 0xF0) {
          expectedBytes = 3; // 4 bytes char
        } else {
          //error start
          throw FormatException("Invalid UTF-8 start byte: $byte");
        }

        //check if the bytes length right.
        if (continuationBytes == expectedBytes) {
          return bytes; //integrity
        } else {
          // Un- integrity cut to i length（remove un-integrity part.）
          return bytes.sublist(0, i);
        }
      }
    }
    //unknown chars bytes.
    return Uint8List(0);
  }

  //the totoal count , means dataLen + 1(start --> the count.)
  (String?, int)? get8nStr({required int start}) {
    if (length < start) {
      return null;
    }
    int len = this[start];
    start = start + 1;
    String? val;
    if (length >= start + len) {
      val = toStrByLoc(loc: start, len: len);
    }
    return (val, len + 1);
  }

  //the totoal count , means dataLen + 1(start --> the count.)
  (List<String>, int)? getAll8nStrs({required int start}) {
    if (length <= start) {
      return null;
    }
    int allStrsCount = this[start]; //1 bytes.
    int dataLength = 1;
    int tempStart = start + 1;
    List<String> strs = [];
    for (int i = 0; i < allStrsCount; i++) {
      var val = get8nStr(start: tempStart);
      if (val != null) {
        String? str = val.$1;
        if (str != null) {
          strs.add(str);
          tempStart = tempStart + val.$2;
        }
        dataLength = dataLength + val.$2;
      }
    }
    return (strs, dataLength);
  }

}
