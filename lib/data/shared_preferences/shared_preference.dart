import 'package:flutter/material.dart';

abstract class SharedPreference{

  Future <void> setStringPreferenceValue(String key, String value, {BuildContext context});

  Future <void> setIntPreferenceValue(String key, int value);

  Future <void> setDoublePreferenceValue(String key, double value);

  Future <void> setBoolPreferenceValue(String key, bool value) ;

  Future<String> getStringPreferenceValue(String key);

  Future<int> getIntPreferenceValue(String key);

  Future<double?> getDoublePreferenceValue(String key);

  Future<bool> getBoolPreferenceValue(String key);

  Future removePreferenceValue(String key);

}