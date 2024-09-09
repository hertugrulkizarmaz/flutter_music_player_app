import 'package:flutter/material.dart';
import 'package:flutter_music_player/components/my_drawer.dart';
import 'package:flutter_music_player/controller/playlist_controller.dart';
import 'package:flutter_music_player/models/song.dart';
import 'package:flutter_music_player/pages/song_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get the playlist controller
  late final PlayListController playListController;

  @override
  void initState() {
    super.initState();
    // get playlist controller using GetX
    playListController = Get.find<PlayListController>();
  }

  // go to a song
  void goToSong(int songIndex) {
    // update current song index
    playListController.currentSongIndex = songIndex;

    //navigate to song page
    Get.to(() => const SongPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('PLAYLIST', style: GoogleFonts.kanit(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: GetBuilder<PlayListController>(
        builder: (controller) {
          // get the playlist
          final List<Song> playList = controller.playList;

          // return list view UI 
          return ListView.builder(
            itemCount: playList.length,
            itemBuilder: (context, index) {
              // get individual song
              final Song song = playList[index];

              // get list tile UI
              return ListTile(
                title: Text(song.songName, style: GoogleFonts.kanit(fontSize: 20),),
                subtitle: Text(song.artistName, style: GoogleFonts.kanit(),),
                leading: Image.asset(song.albumCoverPath),
                onTap: () => goToSong(index),
              );
            },
          );
        },
      ),
    );
  }
}
