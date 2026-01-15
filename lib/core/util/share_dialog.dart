import 'package:share_plus/share_plus.dart';

Future<ShareResultStatus> showShareDialog({String? text, Uri? uri}) async {
  /**
   * Show a share dialog with the given text.
   * Returns the result status of the share action.
   *
   * Parameters:
   * - text: The text to be shared.
   * - uri: An optional URI to be shared (not used in this implementation).
   */
  final ShareParams params;

  if (text != null && uri != null) {
    params = ShareParams(text: "$text ${uri.toString()}");
  } else if (text != null) {
    params = ShareParams(text: text);
  } else if (uri != null) {
    params = ShareParams(uri: uri);
  } else {
    throw ArgumentError('Debe proporcionar text o uri');
  }

  final result = await SharePlus.instance.share(params);
  return result.status;
}
