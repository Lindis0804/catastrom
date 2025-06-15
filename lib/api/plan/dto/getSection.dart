class SectionItem {
  final String sectionId, sectionName;
  const SectionItem({
    required this.sectionId,
    required this.sectionName,
  });

  Map<String, dynamic> toJson() {
    return {
      'sectionId': sectionId,
      'sectionName': sectionName,
    };
  }

  factory SectionItem.fromJson(Map<String, dynamic> json) {
    return SectionItem(
      sectionId: json['sectionId'] ?? '',
      sectionName: json['sectionName'] ?? '',
    );
  }
}

class ResGetSections {
  final List<SectionItem> sections;
  const ResGetSections({
    required this.sections,
  });
}

class ReqGetSections {
  final String? searchKey;
  const ReqGetSections({
    this.searchKey,
  });
}
