class Location {
  final int id, locationType;
  final String address, businessType, description, name;
  final double latitude, longtitude;
  final String? parking, space, specialFood, suitable;
  final double price;

  const Location(
      {required this.id,
      this.locationType = 0,
      required this.address,
      required this.businessType,
      required this.description,
      required this.name,
      required this.latitude,
      required this.longtitude,
      this.parking,
      this.space,
      this.specialFood,
      this.suitable,
      this.price = 0.0});
}
