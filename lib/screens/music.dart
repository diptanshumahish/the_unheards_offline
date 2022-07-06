import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_unheards_offline/utils/utils.dart';
import 'package:the_unheards_offline/widgets/musicscreen_widgets.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  //define the audio player
  final OnAudioQuery _audioQuery = OnAudioQuery();
//player
  final AudioPlayer _player = AudioPlayer();
  //more varivbales
  List<SongModel> songs = [];
  String currentSongTitle = "";
  int currentIndex = 0;
  bool isPlayerViewVisible = false;

  //method to change player view visibility
  void _changePlayerViewVisiblilty() {
    setState(() {
      isPlayerViewVisible = !isPlayerViewVisible;
    });
  }

  //duration state stream
  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          _player.positionStream,
          _player.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));

  //request storage permisiion
  @override
  void initState() {
    super.initState();
    requestStoragePermission();

    _player.currentIndexStream.listen((index) {
      if (index != null) {
        _updateCurrentPlayingSongDetails(index);
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () => Navigator.pushNamed(context, "/"),
              icon: const Icon(CupertinoIcons.back)),
          centerTitle: true,
          backgroundColor: AppColors.transparent,
          title: const Text("Explore")),
      backgroundColor: AppColors.mainBackgroundColor,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return MusicScreenTop(
                    index: index,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Coming Soon",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: AppColors.secondary),
                      ),
                      Text(
                        "The Unheards Streaming App",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: AppColors.mainText),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Stay tuned ;)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.themeColors),
                      )
                    ],
                  ),
                ),
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height / 1.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.themeColors.withOpacity(0.3)),
              ),
            ),
          )
        ],
      ),
    );
  }

  void requestStoragePermission() async {
    if (!kIsWeb) {
      //web has no permssions
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      //ensure build method is called
    }
  }

  ConcatenatingAudioSource createPlaylist(List<SongModel>? songs) {
    List<AudioSource> sources = [];
    for (var song in songs!) {
      sources.add(AudioSource.uri(Uri.parse(song.uri!)));
    }
    return ConcatenatingAudioSource(children: sources);
  }

  void _updateCurrentPlayingSongDetails(int index) {
    setState(() {
      if (songs.isNotEmpty) {
        currentSongTitle = songs[index].title;
        currentIndex = index;
      }
    });
  }
}

//durayion class
class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
