class CallerModel {
  String callerName='';
  String callerNumber;
  int callCount;
  int totalDuration; // in seconds
  int incomingCalls;
  int outgoingCalls;
  int missedCalls;

  CallerModel({
    required this.callerName,
    required this.callerNumber,
    required this.callCount,
    required this.totalDuration,
    required this.incomingCalls,
    required this.outgoingCalls,
    required this.missedCalls,
  });
}
