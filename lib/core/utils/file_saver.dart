import 'dart:typed_data';

abstract class FileSaver {
  Future<void> saveAndShare(Uint8List bytes, String fileName, String text);
}

FileSaver getFileSaver() => throw UnsupportedError('Cannot create a FileSaver');
