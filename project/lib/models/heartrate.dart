//import 'dart:math';

class HR {
  // this class models the single heart rate data point
  final DateTime timestamp;
  final int value;

  HR({required this.timestamp, required this.value});

   @override
  String toString() {
    return 'HR(time: $timestamp, value: $value)';
  }
}