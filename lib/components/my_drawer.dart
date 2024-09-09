import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/controller/theme_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => 
    Drawer(
      backgroundColor: Get.find<ThemeController>().themeData.colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // logo 
              DrawerHeader(child: Center(
                child: SvgPicture.asset('assets/icons/drawer_logo.svg')
              )),
              // home tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text('HOME', style: GoogleFonts.kanit(fontSize: 20),),
                  leading: SvgPicture.asset('assets/icons/home.svg', width: 30, height: 30,),
                  onTap: () {
                    // pop drawer
                    Get.back();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text('SETTINGS', style: GoogleFonts.kanit(fontSize: 20),),
                  leading: SvgPicture.asset('assets/icons/settings.svg', width: 30, height: 30,),
                  onTap: () {
                    // pop drawer
                    Get.back();
                  },
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Divider(
            thickness: 0.06,
            color: Colors.grey,
          ),
          Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text('Dark Theme', style: GoogleFonts.kanit(fontSize: 20),),
                  leading: CupertinoSwitch(
                    value: Get.find<ThemeController>().isDarkMode, 
                    onChanged: (value) => Get.find<ThemeController>().toggleTheme()),
                  onTap: () {
                    // pop drawer
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    )
    );
  }
}