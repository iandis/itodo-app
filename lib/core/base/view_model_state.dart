enum VMStatus {
  init,
  loading,
  loadingMore,
  loaded,
  error,
}

abstract class VMState {
  VMStatus get status;
  String? get error;

  bool get isLoading => status == VMStatus.loading;
  bool get isLoadingMore => status == VMStatus.loadingMore;
  bool get isBusy => isLoading || isLoadingMore;
  bool get isError => status == VMStatus.error;
}
