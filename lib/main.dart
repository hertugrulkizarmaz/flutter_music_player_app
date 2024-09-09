import 'package:flutter/material.dart';
import 'package:flutter_music_player/controller/playlist_controller.dart';
import 'package:flutter_music_player/controller/theme_controller.dart';
import 'package:flutter_music_player/pages/home_page.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController());
  Get.put(PlayListController());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themecontroller) {
        return GetBuilder<PlayListController>(
          builder: (playlistcontroller) {
            return GetMaterialApp(
              home: const HomePage(),
        theme: themecontroller.themeData,
        debugShowCheckedModeBanner: false,
      );
        });
      },
    );
  }
}
