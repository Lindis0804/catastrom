enum LoadingStatus {
  initialize,
  loading,
  loaded,
  error;

  bool get isInitial => this == LoadingStatus.initialize;

  bool get isLoading => this == LoadingStatus.loading;

  bool get isLoaded => this == LoadingStatus.loaded;

  bool get isError => this == LoadingStatus.error;

  bool get isCompleted =>
      this == LoadingStatus.loaded || this == LoadingStatus.error;

  bool get isNotCompleted => !isCompleted;
}
