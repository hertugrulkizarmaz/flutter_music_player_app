import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_music_player/models/song.dart';
import 'package:get/get.dart';


class PlayListController extends GetxController {
  // playlist of songs
  final List<Song> _playList = [
    Song(
      songName: 'Acoustic', 
      artistName: 'Liborio Conti', 
      albumCoverPath: 'assets/images/caucasus.jpg', 
      audioPath: 'audio/acoustic.mp3'),
    Song(
      songName: 'Always Be There', 
      artistName: 'Liberty Conta', 
      albumCoverPath: 'assets/images/falls.jpg', 
      audioPath: 'audio/alwaysbethere.mp3'),
    Song(
      songName: 'Amazing', 
      artistName: 'Liberto Faccino', 
      albumCoverPath: 'assets/images/forest.jpg', 
      audioPath: 'audio/amazing.mp3'),
    Song(
      songName: 'Deeper Meaning', 
      artistName: 'Liberto Facciano', 
      albumCoverPath: 'assets/images/forest2.jpg', 
      audioPath: 'audio/deepermeaning.mp3'),
    Song(
      songName: 'Inspiring Upbeat', 
      artistName: 'Fiberto Lacciano', 
      albumCoverPath: 'assets/images/inspiration.jpg', 
      audioPath: 'audio/inspiring-upbeat.mp3'),
    Song(
      songName: 'Mandolin', 
      artistName: 'Ilberto Fachino', 
      albumCoverPath: 'assets/images/iris.jpg', 
      audioPath: 'audio/mandolin.mp3'),
    Song(
      songName: 'Skyline', 
      artistName: 'Bilberto Saccino', 
      albumCoverPath: 'assets/images/nature.jpg', 
      audioPath: 'audio/skyline.mp3'),
    Song(
      songName: 'Somewhere', 
      artistName: 'Gilberto Sacciano', 
      albumCoverPath: 'assets/images/nature2.jpg', 
      audioPath: 'audio/somewhere.mp3'),
    Song(
      songName: 'Sunshine', 
      artistName: 'Alberto Laccino', 
      albumCoverPath: 'assets/images/nature3.jpg', 
      audioPath: 'audio/sunshine.mp3'),
    Song(
      songName: 'Upbeat Inspiration', 
      artistName: 'Alexandro Facciano', 
      albumCoverPath: 'assets/images/nature4.jpg', 
      audioPath: 'audio/upbeatinspiration.mp3'),
    Song(
      songName: 'Vacation', 
      artistName: 'Al Pacciano', 
      albumCoverPath: 'assets/images/nature5.jpg', 
      audioPath: 'audio/vacation.mp3'),
  ];

  // current song playing index
  int? _currentSongIndex;

  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  PlayListController() {
    listenToDuration();
  }
  // initially not playing
  bool _isPlaying = false;

  // repating song
  bool _isRepeating = false;

  // play the song
  void play() async {
    final String path = _playList[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); //stop current song
    await _audioPlayer.play(AssetSource(path)); // play the new song
    _isPlaying = true;
    update();
  }

  // pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
  }

  // resume song
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
  }

  // pause or resume
  void pauseOrResume() async {
    if(_isPlaying) {
      pause();
    } else {
      resume();
    }
    update();
  }

  // shuffle list
  void shufflePlaylist() {
    _playList.shuffle(Random());
    _currentSongIndex = 0;
    play();
    update();
  }

  // repeat song
  void toggleRepeat() {
    _isRepeating = !_isRepeating;
    update();
  }

  // seek to a specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // play next song
  void playNextSong() async {
    if(_currentSongIndex != null) {
      if(_currentSongIndex! < _playList.length - 1) {
        // go to the next song if it's not the last song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        // if it's the last song, loop back to first song
        currentSongIndex = 0;
      }
    }
  }

  // play previous song
  void playPreviousSong() async {
    // if more the 2 seconds have passed, restart the current song
    if(_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    }
    // if it's within first 2 second of the song, go to previous song
    else {
      if(_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      }else {
        // if it's the first song, loop back to last song
        currentSongIndex = _playList.length - 1;
      }
    }
  }

  // listen to duration
  void listenToDuration() {
    // listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) { 
      _totalDuration = newDuration;
      update();
     });
    // listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) { 
      _currentDuration = newPosition;
      update();
     });
    // listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      if(_isRepeating) {
        play();
      } else {
        playNextSong();
      }
    });
  }
  // dispose audio player
  @override
  void dispose() {
    // dispose audio player
    _audioPlayer.dispose();
    super.dispose();
  }

  // Getters
  List<Song> get playList => _playList;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  bool get isRepeating => _isRepeating;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // Setters
  set currentSongIndex(int? newIndex) {
    // update current song index
    _currentSongIndex = newIndex;
    if(newIndex != null) {
      play(); // play the song at the new index
    }
    // update UI
    update();
  }
}
