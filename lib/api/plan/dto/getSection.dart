import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart' as j;
import 'package:template/api/base/BaseDto.dart';
part 'getSection.g.dart';

@j.JsonSerializable()
class SectionItem {
  @j.JsonKey(name: 'id')
  final String sectionId;

  @j.JsonKey(name: 'locationName')
  final String sectionName;

  @j.JsonKey(name: 'googleMapId')
  final String googleMapId;

  @j.JsonKey(name: 'bigImageUrl')
  final String? bigImaeUrl;

  final double latitude;
  final double longitude;
  final double starReview;

  @j.JsonKey(name: 'numberReview')
  final int numberOfReview;

  @j.JsonKey(name: 'summary')
  final String summary;

  final String otherInfo;
  final String address;
  final String telephone;
  final String keySearch;
  final String googleMapLink;
  final List<String> websites;
  final List<String> imageLinks;
  final List<String> comments;
  const SectionItem({
    required this.sectionId,
    required this.sectionName,
    this.googleMapId = '',
    this.bigImaeUrl,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.starReview = 0.0,
    this.numberOfReview = 0,
    this.summary = '',
    this.otherInfo = '',
    this.address = '',
    this.telephone = '',
    this.keySearch = '',
    this.googleMapLink = '',
    this.websites = const [],
    this.imageLinks = const [],
    this.comments = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'sectionId': sectionId,
      'sectionName': sectionName,
    };
  }

  factory SectionItem.fromJson(Map<String, dynamic> json) =>
      _$SectionItemFromJson(json);
}

@j.JsonSerializable()
class ResGetSections extends ResBaseDto {
  @j.JsonKey(name: 'content')
  final List<SectionItem> sections;

  const ResGetSections({
    required this.sections,
    int totalPages = 0,
    int totalElements = 0,
    Pageable pageable = const Pageable(),
    int size = 0,
  }) : super(
          totalPages: totalPages,
          totalElements: totalElements,
          pageable: pageable,
          size: size,
        );

  factory ResGetSections.fromJson(Map<String, dynamic> json) =>
      _$ResGetSectionsFromJson(json);
}

class ReqGetSections {
  final String? searchKey;
  const ReqGetSections({
    this.searchKey,
  });
}
