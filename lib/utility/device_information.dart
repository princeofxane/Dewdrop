import 'package:flutter/material.dart';
import 'dart:math';

double screenWidth(context) {
  return MediaQuery.of(context).size.width;
}
double screenHeight(context) {
  return MediaQuery.of(context).size.height;
}

T? tryCast<T>(dynamic x, {T? fallback}){
  try{
    return (x as T);
  }
  on Exception catch(e){
    print('CastError when trying to cast $x to $T!');
    return fallback;
  }
}

/* ---------- random string generator ---------- */
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(
    Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))
    )
);
/* --------------------------------------------- */

T? cast<T>(x) => x is T ? x : null;
