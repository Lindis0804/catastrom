class ReqGetTimelineByTripCode {
  final String tripCode;

  const ReqGetTimelineByTripCode({
    required this.tripCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'tripCode': tripCode,
    };
  }

  @override
  String toString() {
    return 'ReqGetTimelineByTripCode(tripCode: $tripCode)';
  }
}
