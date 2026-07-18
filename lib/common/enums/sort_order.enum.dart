enum ESortOrder {
  asc,
  desc;

  String get apiValue => this == ESortOrder.asc ? 'ASC' : 'DESC';

  String get label => this == ESortOrder.asc ? 'Tăng dần' : 'Giảm dần';
}
