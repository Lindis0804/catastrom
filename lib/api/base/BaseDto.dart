import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart' as j;
part 'BaseDto.g.dart';

@j.JsonSerializable()
class Sort {
  final bool sorted;
  final bool empty;
  final bool unsorted;
  const Sort({
    this.sorted = false,
    this.empty = false,
    this.unsorted = false,
  });
  factory Sort.fromJson(Map<String, dynamic> json) => _$SortFromJson(json);
}

@j.JsonSerializable()
class Pageable {
  final bool paged;
  final int pageNumber;
  final int pageSize;
  final int offset;
  final Sort sort;
  const Pageable({
    this.paged = false,
    this.pageNumber = 0,
    this.pageSize = 1,
    this.offset = 0,
    this.sort = const Sort(),
  });
  factory Pageable.fromJson(Map<String, dynamic> json) =>
      _$PageableFromJson(json);
}

@j.JsonSerializable()
class ResBaseDto {
  final int totalPages;
  final int totalElements;
  final Pageable pageable;
  final int size;

  const ResBaseDto({
    this.totalPages = 0,
    this.totalElements = 0,
    this.pageable = const Pageable(),
    this.size = 0,
  });
  factory ResBaseDto.fromJson(Map<String, dynamic> json) =>
      _$ResBaseDtoFromJson(json);
}
