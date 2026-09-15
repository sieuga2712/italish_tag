/// Formats a date as `dd/MM/yyyy`, matching the design doc's date examples.
///
/// A tiny hand-rolled formatter rather than pulling in `intl` — this is the
/// only date formatting the app needs so far.
String formatDate(DateTime date) {
  final local = date.toLocal();
  String two(int n) => n.toString().padLeft(2, '0');
  return '${two(local.day)}/${two(local.month)}/${local.year}';
}
