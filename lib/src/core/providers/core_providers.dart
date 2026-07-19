import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// Shared [Logger] instance used by data-layer repositories to record
/// failures before mapping them to a result.
final loggerProvider = Provider<Logger>((ref) => Logger());
