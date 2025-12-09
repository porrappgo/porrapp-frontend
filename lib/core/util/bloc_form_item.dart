/// A model class representing a single form item managed by a BLoC.
///
/// Contains the current [value] of the form field and an optional [error] message.
///
/// The [BlocFormItem] is immutable and provides a [copyWith] method for creating
/// modified copies with updated values or errors.
class BlocFormItem {
  final String value;
  final String? error;

  const BlocFormItem({this.value = '', this.error});

  BlocFormItem copyWith({String? value, String? error}) {
    return BlocFormItem(value: value ?? this.value, error: error ?? this.error);
  }
}
