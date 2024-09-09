import 'package:flutter/material.dart';
import 'package:flutter_music_player/controller/theme_controller.dart';
import 'package:get/get.dart';

class PlayerBox extends StatelessWidget {
  final Widget? child;

  const PlayerBox({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // is dark mode
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: Get.find<ThemeController>().themeData.colorScheme.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // darker shadow on bottom right
          BoxShadow(
            color: isDarkMode
            ? Colors.black
            : Colors.grey.shade500,
            offset: const Offset(2, 2)
          ),
          // lighter shadow on top left
         BoxShadow(
            color: isDarkMode
            ? Colors.grey.shade800
            : Colors.white,
            offset: const Offset(-2, -2)
          ),
        ]
      ),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}
