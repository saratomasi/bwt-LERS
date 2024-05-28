class RHR {
  // this class models the single heart rate data point
  final DateTime timestamp;
  final double value;

  RHR({required this.timestamp, required this.value});

   @override
  String toString() {
    return 'RHR(time: $timestamp,value: $value)';
  }
}