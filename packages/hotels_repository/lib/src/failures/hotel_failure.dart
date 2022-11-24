import 'package:equatable/equatable.dart';

/// {@template hotels_failure}
/// Base failure for the hotels repository failures.
/// {@endtemplate}
class HotelsFailure with EquatableMixin implements Exception {
  /// {@macro hotels_failure}
  const HotelsFailure(this.error, this.stackTrace);

  /// The error that was caught.
  final Object error;

  /// The Stacktrace associated with the [error].
  final StackTrace stackTrace;

  @override
  List<Object?> get props => [error, stackTrace];
}
