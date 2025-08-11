class Location {
  final String id;
  final String googleMapId;
  final String locationName;
  final String? bigImageUrl;
  final double? latitude;
  final double? longitude;
  final double? starReview;
  final int? numberReview;
  final String? summary;
  final String? otherInfor;
  final String? address;
  final String? telephone;
  final String? keySearch;
  final String? googleMapLink;
  // Add open_close, price as needed
  final Object? services;
  final Object? openClose;
  final List<String>? websites;
  final List<String>? imageLinks;
  final List<String>? comments;

  const Location({
    required this.id,
    required this.googleMapId,
    required this.locationName,
    this.bigImageUrl,
    this.latitude,
    this.longitude,
    this.starReview,
    this.numberReview,
    this.summary,
    this.otherInfor,
    this.address,
    this.telephone,
    this.keySearch,
    this.googleMapLink,
    this.services,
    this.openClose,
    this.websites,
    this.imageLinks,
    this.comments,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] as String,
      googleMapId: json['googleMapId'] as String,
      locationName: json['locationName'] as String,
      bigImageUrl: json['bigImageUrl'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      starReview: json['starReview'] != null
          ? (json['starReview'] as num).toDouble()
          : null,
      numberReview: json['numberReview'] as int?,
      summary: json['summary'] as String?,
      otherInfor: json['otherInfor'] as String?,
      address: json['address'] as String?,
      telephone: json['telephone'] as String?,
      keySearch: json['keySearch'] as String?,
      googleMapLink: json['googleMapLink'] as String?,
      services: json['services'],
      openClose: json['openClose'],
      websites: json['websites'] != null
          ? List<String>.from(json['websites'] as List)
          : null,
      imageLinks: json['imageLinks'] != null
          ? List<String>.from(json['imageLinks'] as List)
          : null,
      comments: json['comments'] != null
          ? List<String>.from(json['comments'] as List)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'googleMapId': googleMapId,
      'locationName': locationName,
      'bigImageUrl': bigImageUrl,
      'latitude': latitude,
      'longitude': longitude,
      'starReview': starReview,
      'numberReview': numberReview,
      'summary': summary,
      'otherInfor': otherInfor,
      'address': address,
      'telephone': telephone,
      'keySearch': keySearch,
      'googleMapLink': googleMapLink,
      'services': services,
      'openClose': openClose,
      'websites': websites,
      'imageLinks': imageLinks,
      'comments': comments,
    };
  }
}
