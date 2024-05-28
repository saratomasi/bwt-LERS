class Steps {
  // this class models the single heart rate data point
  final DateTime timestamp;
  //final int value;
  final int value ;

  Steps({required this.timestamp, required this.value});
  //Steps({ required this.value});

   @override
  String toString() {
    return 'Steps(time: $timestamp, value: $value)';
  }
}