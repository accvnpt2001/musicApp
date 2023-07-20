import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadHelper {
  static downloadFile(String url) async {
    final baseStorage = await getExternalStorageDirectory();

    var status = await Permission.storage.request();
    if (status.isGranted) {
      await FlutterDownloader.enqueue(
        url: url,
        headers: {}, // optional: header send with url (auth token etc)
        savedDir: baseStorage!.path,
        showNotification: true, // show download progress in status bar (for Android)
        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
      );
    }
  }
}
