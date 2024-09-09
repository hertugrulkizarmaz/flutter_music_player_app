import 'package:flutter/material.dart';
import 'package:flutter_music_player/components/player_box.dart';
import 'package:flutter_music_player/controller/playlist_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class SongPage extends StatelessWidget {
  const SongPage({super.key});

  // Convert duration into min:sec
  String formatTime(Duration duration) {
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${duration.inMinutes}:$twoDigitSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayListController>(
      builder: (controller) {
        // Get playlist
        final playList = controller.playList;

        // Get current song index
        final currentSong = playList[controller.currentSongIndex ?? 0];

        // Return scaffold UI
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            title: Text('P L A Y L I S T', style: GoogleFonts.kanit(fontWeight: FontWeight.bold),),
            centerTitle: true,
            actions: [
               IconButton(
                onPressed: () {}, 
                icon: const Icon(Icons.menu)
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Album artwork
                  PlayerBox(
                    child: Column(
                      children: [
                        // Album image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(currentSong.albumCoverPath),
                        ),

                        // Song and artist name and icon
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Song and artist name
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentSong.songName,
                                        style: GoogleFonts.kanit(fontWeight: FontWeight.bold, fontSize: 20),
                                      ),
                                      Text(currentSong.artistName, style: GoogleFonts.kanit(),),
                                    ],
                                  ),
                                  // Favorite icon
                                  const Icon(Icons.favorite, color: Colors.redAccent),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25,),

                  // Song duration progress
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Start time
                            Text(formatTime(controller.currentDuration)),

                            // Shuffle icon
                            GestureDetector(
                              onTap: () => controller.shufflePlaylist(),
                              child: const Icon(Icons.shuffle),
                            ),

                            // Repeat icon
                            GestureDetector(
                              onTap: () => controller.toggleRepeat(),
                              child: controller.isRepeating 
                                ? const Icon(Icons.repeat_on)
                                : const Icon(Icons.repeat),
                            ),

                            // End time
                            Text(formatTime(controller.totalDuration)),
                          ],
                        ),
                      ),

                      // Song duration slider
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 0,
                          ),
                        ),
                        child: Slider(
                          min: 0,
                          max: controller.totalDuration.inSeconds.toDouble(),
                          value: (controller.currentDuration.inSeconds.toDouble() < controller.totalDuration.inSeconds.toDouble())
                            ? controller.currentDuration.inSeconds.toDouble() 
                            : controller.totalDuration.inSeconds.toDouble(),
                          activeColor: Colors.green, 
                          onChanged: (double newValue) {
                            // Logic when the user is sliding
                          },
                          onChangeEnd: (double newValue) {
                            // Sliding has finished, go to that position in song duration
                            controller.seek(Duration(seconds: newValue.toInt()));
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10,),

                  // Playback controls
                  Row(
                    children: [
                      // Skip previous
                      Expanded(
                        child: GestureDetector(
                          onTap: controller.playPreviousSong,
                          child: const PlayerBox(
                            child: Icon(Icons.skip_previous),
                          ),
                        ),
                      ),

                      const SizedBox(width: 20,),

                      // Play/pause
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: controller.pauseOrResume,
                          child: PlayerBox(
                            child: Icon(
                              controller.isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 20,),

                      // Skip forward
                      Expanded(
                        child: GestureDetector(
                          onTap: controller.playNextSong,
                          child: const PlayerBox(
                            child: Icon(Icons.skip_next),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
