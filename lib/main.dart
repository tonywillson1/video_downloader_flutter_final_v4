import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'downloader.dart';

void main() {
  runApp(const VideoDownloaderApp());
}

class VideoDownloaderApp extends StatelessWidget {
  const VideoDownloaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '视频下载助手',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String content = '等待识别剪贴板中的链接...';
  bool downloading = false;

  void checkClipboard() async {
    final text = await FlutterClipboard.paste();
    if (text.contains("douyin.com") || text.contains("xiaohongshu.com")) {
      setState(() => content = "检测到链接，准备下载");
    }
  }

  void download() async {
    setState(() => downloading = true);
    final success = await Downloader.downloadVideo(content);
    setState(() {
      downloading = false;
      content = success ? "下载成功！" : "下载失败";
    });
  }

  @override
  void initState() {
    super.initState();
    checkClipboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("视频下载助手")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(content),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: downloading ? null : download,
              child: downloading ? const CircularProgressIndicator() : const Text("下载无水印视频"),
            )
          ],
        ),
      ),
    );
  }
}
