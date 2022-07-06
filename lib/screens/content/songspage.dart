import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_unheards_offline/screens/screens.dart';
import 'package:the_unheards_offline/widgets/songtile.dart';

import '../../utils/utils.dart';
import '../../widgets/homescreen_widgets.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({Key? key}) : super(key: key);

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  //define the audio player
  final OnAudioQuery _audioQuery = OnAudioQuery();
//player
  final AudioPlayer _player = AudioPlayer();

  //variables
  List<SongModel> songs = [];
  String currentSongTitle = "";
  int currentIndex = 0;

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

  //displaying content

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: const Key("dismissible"),
        onDismissed: (_) => Navigator.of(context).pop(),
        direction: DismissDirection.endToStart,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Scaffold(
              appBar: AppBar(
                  elevation: 0,
                  leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(CupertinoIcons.back)),
                  centerTitle: true,
                  backgroundColor: AppColors.transparent,
                  title: const Text("Songs")),
              backgroundColor: AppColors.lightback.withOpacity(0.8),
              bottomNavigationBar: BottomAppBar(
                color: AppColors.transparent,
                child: SizedBox(
                  height: 80,
                  child: Column(
                    children: [
                      BottomAudioPlayer(
                        imageUrl:
                            "https://m.media-amazon.com/images/I/71zf0DtXOtL._SL1200_.jpg",
                        artistName: "The Guy",
                        songName: "New Song",
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              body: FutureBuilder<List<SongModel>>(
                  //default values
                  future: _audioQuery.querySongs(
                    sortType: null,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                    ignoreCase: true,
                  ),
                  builder: (context, item) {
                    //leading content indication
                    if (item.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    //no songs
                    if (item.data!.isEmpty) {
                      return const Center(
                        child: Text("no songs"),
                      );
                    }
                    songs.clear();
                    songs = item.data!;
                    return ListView.builder(
                        itemCount: item.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              setState(() {});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullScreenPlayer(
                                    index: index,
                                    artist: item.data![index].artist,
                                    artwork: item.data![index].id,
                                    title: item.data![index].title,
                                  ),
                                ),
                              );
                              await _player.setAudioSource(
                                  createPlaylist(item.data),
                                  initialIndex: index);
                              await _player.play();
                            },
                            child: SongTile(
                                index: index,
                                artwork: item.data![index].id,
                                title: item.data![index].title,
                                artist: item.data![index].artist),
                          );
                        });
                  })),
        ));
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
