class RecommendedPlace {
  final double latitude, longtitude;
  final String name;
  final String address, businessType;
  final String imageUrl;
  const RecommendedPlace(
      {required this.latitude,
      required this.longtitude,
      required this.name,
      required this.address,
      required this.businessType,
      this.imageUrl =
          'https://easydrawingguides.com/wp-content/uploads/2022/11/how-to-draw-a-restaurant-featured-image-1200.png'});
}
