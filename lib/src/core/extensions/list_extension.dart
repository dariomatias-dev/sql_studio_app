/// Adds convenience mapping helpers to [List].
extension ListExtension<R> on List<R> {
  /// Maps each element to a new value using [toElement], which also
  /// receives the element's index.
  List<T> builder<T>(
    T Function(
      R e,
      int index,
    )
    toElement,
  ) {
    return List.generate(
      length,
      (index) {
        return toElement(
          elementAt(index),
          index,
        );
      },
    );
  }
}
