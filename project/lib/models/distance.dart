class Distance {
  // this class models the single heart rate data point
  final DateTime timestamp;
  //final int value;
  final int value ;

  Distance({required this.timestamp, required this.value});
  //Steps({ required this.value});

   @override
  String toString() {
    return 'Distance(time: $timestamp, value: $value)';
  }
}