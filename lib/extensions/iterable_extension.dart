extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  Map<T, List<E>> groupBy<S, T>(T Function(E) key) {
    var map = <T, List<E>>{};
    for (var element in this) {
      (map[key(element)] ??= []).add(element);
    }
    return map;
  }

  E? firstOrDefault([bool Function(E element)? test]) {
    if (test == null) {
      Iterator<E> it = iterator;
      if (!it.moveNext()) {
        return null;
      }
      return it.current;
    }
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
