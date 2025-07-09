import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Downloader {
  static Future<bool> downloadVideo(String url) async {
    try {
      final status = await Permission.storage.request();
      if (!status.isGranted) return false;
      final dir = await getExternalStorageDirectory();
      final savePath = '${dir!.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';
      await Dio().download(url, savePath);
      return true;
    } catch (_) {
      return false;
    }
  }
}
