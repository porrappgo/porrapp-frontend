/** Represents a generic resource state, typically used for handling asynchronous
data fetching.
*/
/// [T] is the type of data associated with the resource.
abstract class Resource<T> {}

/// Indicates the initial state before any operation has started.
class Initial extends Resource {}

/// Indicates that a loading operation is in progress.
class Loading extends Resource {}

/// Indicates that a loading operation is in progress and requires a full-screen overlay.
class LoadingPage extends Resource {}

/// Represents a successful state containing the resulting data.
///
/// [T] is the type of the data returned.
class Success<T> extends Resource<T> {
  /// The data returned from a successful operation.
  final T data;

  Success(this.data);
}

/// Represents an error state with an associated error message.
class Error<T> extends Resource<T> {
  /// The error message describing what went wrong.
  final String message;

  Error(this.message);
}
