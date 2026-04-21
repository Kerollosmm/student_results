import 'dart:html' as html;
import 'dart:typed_data';
import 'file_saver.dart';

class WebFileSaver implements FileSaver {
  @override
  Future<void> saveAndShare(Uint8List bytes, String fileName, String text) async {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}

FileSaver getFileSaver() => WebFileSaver();
