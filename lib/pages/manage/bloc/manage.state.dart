part of 'manage.bloc.dart';

class ManageState extends Equatable {
  final LoadingStatus loadManagePageStatus;
  final EPageManageStatus pageManageStatus;
  final int pageIdx;
  const ManageState({
    required this.loadManagePageStatus,
    this.pageManageStatus = EPageManageStatus.init,
    this.pageIdx = 0,
  });

  factory ManageState.initialize() {
    return const ManageState(
        loadManagePageStatus: LoadingStatus.initialize, pageIdx: 0);
  }

  ManageState copyWith(
      {LoadingStatus? loadManagePageStatus,
      EPageManageStatus? pageManageStatus,
      int? pageIdx}) {
    return ManageState(
      loadManagePageStatus: loadManagePageStatus ?? this.loadManagePageStatus,
      pageManageStatus: pageManageStatus ?? this.pageManageStatus,
      pageIdx: pageIdx ?? this.pageIdx,
    );
  }

  @override
  List<Object?> get props => [loadManagePageStatus, pageManageStatus, pageIdx];
}
