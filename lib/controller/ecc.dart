import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;




class Ecc {
// Encrypt a string
  static const String k = 'q1wertyuiopasd0fghjklz5x6c7v8b9n';
  // static const String k ='12';

  String encryption(String plainText) {
    final key = encrypt.Key.fromUtf8(k);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return base64.encode(encrypted.bytes);
  }

// Decrypt a string
  String decryption(String cipherText) {
    final key = encrypt.Key.fromUtf8(k);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypt.Encrypted.fromBase64(cipherText);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }
}





 
