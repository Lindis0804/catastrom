class SubPlanDto {
  final int locationId;
  final String startTime, endTime;

  const SubPlanDto(
      {required this.locationId,
      required this.startTime,
      required this.endTime});
}

class CreatePlanDto {
  final int type;
  final String startTime, endTime;
  final List<SubPlanDto>? subPlans;

  const CreatePlanDto(
      {this.type = 0,
      required this.startTime,
      required this.endTime,
      this.subPlans});
}
