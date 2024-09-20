import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RouteDetailProvider extends ChangeNotifier {
  Map<String, bool> _checkboxStates = {};
  Map<String, String> _visitedTimes = {};

  // Check if the checkbox for a store is checked
  bool isChecked(String storeName) => _checkboxStates[storeName] ?? false;

  // Get the visited time for a store
  String visitedTime(String storeName) => _visitedTimes[storeName] ?? '';

  // Toggle the checkbox and set/remove the visited time
  void toggleCheckbox(String storeName, bool? value) {
    _checkboxStates[storeName] = value ?? false;

    if (_checkboxStates[storeName]!) {
      // If checked, set the current time in the desired format
      _visitedTimes[storeName] = DateFormat('dd-MMM-yyyy hh:mm a').format(DateTime.now());
    } else {
      // If unchecked, remove the visited time for the store
      _visitedTimes.remove(storeName);
    }
    notifyListeners(); // Notify listeners to rebuild UI
  }
}
