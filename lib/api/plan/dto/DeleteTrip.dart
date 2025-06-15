enum EDeleteTripStatus { SUCCESS, FAIL }

class ReqDeleteTrip {
  final String tripCode;
  const ReqDeleteTrip({required this.tripCode});
}

class ResDeleteTrip {
  final EDeleteTripStatus status;

  const ResDeleteTrip({required this.status});
}
