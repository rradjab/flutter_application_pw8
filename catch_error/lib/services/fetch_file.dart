import 'package:flutter/services.dart';

Future<String> fetchFileFromAssets(String assetsPath) async {
  return await Future.delayed(
    const Duration(seconds: 5),
  ).then((value) => rootBundle
      .loadString(assetsPath)
      .then((file) => file.toString())
      .onError((error, stackTrace) => 'файл не найден'));
}
