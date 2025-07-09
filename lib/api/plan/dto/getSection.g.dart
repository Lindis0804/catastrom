// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getSection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectionItem _$SectionItemFromJson(Map<String, dynamic> json) => SectionItem(
      sectionId: json['id'] as String,
      sectionName: json['locationName'] as String,
      googleMapId: json['googleMapId'] as String? ?? '',
      bigImaeUrl: json['bigImageUrl'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      starReview: (json['starReview'] as num?)?.toDouble() ?? 0.0,
      numberOfReview: (json['numberReview'] as num?)?.toInt() ?? 0,
      summary: json['summary'] as String? ?? '',
      otherInfo: json['otherInfo'] as String? ?? '',
      address: json['address'] as String? ?? '',
      telephone: json['telephone'] as String? ?? '',
      keySearch: json['keySearch'] as String? ?? '',
      googleMapLink: json['googleMapLink'] as String? ?? '',
      websites: (json['websites'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      imageLinks: (json['imageLinks'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SectionItemToJson(SectionItem instance) =>
    <String, dynamic>{
      'id': instance.sectionId,
      'locationName': instance.sectionName,
      'googleMapId': instance.googleMapId,
      'bigImageUrl': instance.bigImaeUrl,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'starReview': instance.starReview,
      'numberReview': instance.numberOfReview,
      'summary': instance.summary,
      'otherInfo': instance.otherInfo,
      'address': instance.address,
      'telephone': instance.telephone,
      'keySearch': instance.keySearch,
      'googleMapLink': instance.googleMapLink,
      'websites': instance.websites,
      'imageLinks': instance.imageLinks,
      'comments': instance.comments,
    };

ResGetSections _$ResGetSectionsFromJson(Map<String, dynamic> json) =>
    ResGetSections(
      sections: (json['content'] as List<dynamic>)
          .map((e) => SectionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
      totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
      pageable: json['pageable'] == null
          ? const Pageable()
          : Pageable.fromJson(json['pageable'] as Map<String, dynamic>),
      size: (json['size'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ResGetSectionsToJson(ResGetSections instance) =>
    <String, dynamic>{
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'pageable': instance.pageable,
      'size': instance.size,
      'content': instance.sections,
    };
