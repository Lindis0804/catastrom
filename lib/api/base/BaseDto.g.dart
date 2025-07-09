// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BaseDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sort _$SortFromJson(Map<String, dynamic> json) => Sort(
      sorted: json['sorted'] as bool? ?? false,
      empty: json['empty'] as bool? ?? false,
      unsorted: json['unsorted'] as bool? ?? false,
    );

Map<String, dynamic> _$SortToJson(Sort instance) => <String, dynamic>{
      'sorted': instance.sorted,
      'empty': instance.empty,
      'unsorted': instance.unsorted,
    };

Pageable _$PageableFromJson(Map<String, dynamic> json) => Pageable(
      paged: json['paged'] as bool? ?? false,
      pageNumber: (json['pageNumber'] as num?)?.toInt() ?? 0,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 1,
      offset: (json['offset'] as num?)?.toInt() ?? 0,
      sort: json['sort'] == null
          ? const Sort()
          : Sort.fromJson(json['sort'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PageableToJson(Pageable instance) => <String, dynamic>{
      'paged': instance.paged,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'offset': instance.offset,
      'sort': instance.sort,
    };

ResBaseDto _$ResBaseDtoFromJson(Map<String, dynamic> json) => ResBaseDto(
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
      totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
      pageable: json['pageable'] == null
          ? const Pageable()
          : Pageable.fromJson(json['pageable'] as Map<String, dynamic>),
      size: (json['size'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ResBaseDtoToJson(ResBaseDto instance) =>
    <String, dynamic>{
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'pageable': instance.pageable,
      'size': instance.size,
    };
