import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'file_saver.dart';

class MobileFileSaver implements FileSaver {
  @override
  Future<void> saveAndShare(Uint8List bytes, String fileName, String text) async {
    final directory = await getTemporaryDirectory();
    final file = await File('${directory.path}/$fileName').create();
    await file.writeAsBytes(bytes);

    await Share.shareXFiles(
      [XFile(file.path)],
      text: text,
    );
  }
}

FileSaver getFileSaver() => MobileFileSaver();
