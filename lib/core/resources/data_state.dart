abstract class DataState<T> {
  final T? data;
  final String? error;

  DataState(this.data, this.error);
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T? data) : super(data, null);
}

class DataFaild<T> extends DataState<T> {
  DataFaild(String error) : super(null, error);
}
