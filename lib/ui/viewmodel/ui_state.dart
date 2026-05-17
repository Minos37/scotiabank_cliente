abstract class UiState {
  const UiState();
}

class UiLoading extends UiState {
  const UiLoading();
}

class UiSuccess<T> extends UiState {
  final T data;

  const UiSuccess(this.data);
}

class UiError extends UiState {
  final String message;

  const UiError(this.message);
}

class UiEmpty extends UiState {
  const UiEmpty();
}
