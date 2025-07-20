class ReqSearchUsersPageable {
  final int page;
  final int size;

  const ReqSearchUsersPageable({
    this.page = 0,
    this.size = 1,
  });
}

class ReqSearchUsers {
  final int? id;
  final String? username;
  final ReqSearchUsersPageable? pageable;

  const ReqSearchUsers({
    this.id,
    this.username,
    this.pageable,
  });
}
