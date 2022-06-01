import 'package:rxdart/rxdart.dart';

class PaginationHelper<T> {
  int _count = 0;
  bool isLoading = false;
  late final int limit;
  List<T> items = [];
  final Function()? listener;

  final PaginationConfig _config = PaginationConfig();

  final Future<List<T>?> Function(PaginationConfig config) asyncTask;

  final Function()? onRefresh;

  BehaviorSubject<bool> bsIsLoadingMore = BehaviorSubject.seeded(false);

  PaginationHelper(
      {required this.asyncTask, int? limit, this.listener, this.onRefresh}) {
    this.limit = limit ?? 14;
  }

  void updateList(List<T> newItems) {
    items = newItems;
    listener?.call();
  }

  Future<void> run() {
    int nextPage = isFirstLoad ? _config.page : _config.page + 1;
    if (_count > 0) {
      bsIsLoadingMore.add(true);
    }

    _config.page = nextPage;
    return asyncTask.call(_config).then((value) {
      isLoading = false;
      if (value != null) {
        items.addAll(value);
      }
      listener?.call();
      bsIsLoadingMore.add(false);
      return value;
    }).catchError((e) {
      bsIsLoadingMore.add(false);
    });
  }

  bool get isFirstLoad => _count == 0 && items.isEmpty && _config.canLoadMore;

  bool get canLoadMore => _config.canLoadMore;

  Future<void> refresh() async {
    _count = 0;
    items = [];
    _config.page = 1;
    _config.canLoadMore = true;
    if (onRefresh != null) {
      return onRefresh!.call();
    }
  }
}

class PaginationConfig {
  bool canLoadMore;
  int page;

  PaginationConfig({this.canLoadMore = true, this.page = 1});
}
