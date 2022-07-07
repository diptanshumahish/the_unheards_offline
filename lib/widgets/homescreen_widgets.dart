import 'package:flutter/cupertino.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_unheards_offline/screens/player/fullscreenplayer.dart';
import 'package:the_unheards_offline/screens/screens.dart';
import '../utils/utils.dart';

String finalName = "null";
String finalArtist = "unkwown";
String finalAdded = "null";

// ignore: must_be_immutable
class HomeScreenWIdget extends StatefulWidget {
  late var songName = "";
  late String totalSongs = "null";
  late var recentlyAddedSongs = "";

  int index;

  HomeScreenWIdget({
    Key? key,
    required this.songName,
    required this.totalSongs,
    required this.recentlyAddedSongs,
    required this.index,
  }) : super(key: key);

  @override
  State<HomeScreenWIdget> createState() => _HomeScreenWIdgetState();
}

class _HomeScreenWIdgetState extends State<HomeScreenWIdget> {
  final List<String> widgetDetails = [
    "Last played",
    "Recently Added",
    "Favorites",
    "Suggestions"
  ];
  late List<Map> subDetails = [
    {"value": widget.songName},
    {"value": widget.recentlyAddedSongs.toString()},
    {"value": widget.totalSongs.toString()},
    {"value": "Coming Soon"}
  ];
  final List<String> imageUrl = [
    "https://source.unsplash.com/random/1920x1080/?night/1",
    "https://source.unsplash.com/random/1920x1080/?sunset/2",
    "https://source.unsplash.com/random/1920x1080/?music/3",
    "https://source.unsplash.com/random/1920x1080/?music/4"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  AppColors.mainBackgroundColor.withOpacity(0.7),
                  BlendMode.darken),
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl[widget.index])),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widgetDetails[widget.index],
              style: TextStyle(
                  color: AppColors.mainText,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4),
            ),
            Text(
              subDetails[widget.index]["value"],
              style: TextStyle(
                  color: AppColors.themeColors,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.4),
            ),
          ],
        ),
      ),
    );
  }
}

//bottom audio playing widget

// ignore: must_be_immutable
class BottomAudioPlayer extends StatefulWidget {
  var imageUrl = " ";
  late var songName = "Song Name";
  late var artistName = "Artist name";
  BottomAudioPlayer(
      {Key? key,
      required this.imageUrl,
      required this.songName,
      required this.artistName})
      : super(key: key);

  @override
  State<BottomAudioPlayer> createState() => _BottomAudioPlayerState();
}

class _BottomAudioPlayerState extends State<BottomAudioPlayer> {
  @override
  void initState() {
    getData().whenComplete(() => BottomAudioPlayer(
          songName: finalName,
          artistName: finalArtist,
          imageUrl: "https://source.unsplash.com/random/1920x1080/?music/4",
        ));

    super.initState();
  }

  Future getData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var name = sharedPreferences.getString("songName");
    var artist = sharedPreferences.getString("artistName");
    var number = sharedPreferences.getInt("added");
    setState(() {
      if (name == null) {
        finalName = "Not playing";
        finalArtist = "Unavailable";
      } else {
        finalName = name;
        finalArtist = artist.toString();
        finalAdded = number.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        {
          showGeneralDialog(
            barrierLabel: "Label",
            barrierDismissible: false,
            barrierColor: AppColors.mainBackgroundColor.withOpacity(0.5),
            transitionDuration: Duration(milliseconds: 200),
            context: context,
            pageBuilder: (context, anim1, anim2) {
              return FullScreenPlayer(
                index: 1,
                artist: "sd",
                artwork: "hj",
                title: "boom",
              );
            },
            transitionBuilder: (context, anim1, anim2, child) {
              return SlideTransition(
                position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                    .animate(anim1),
                child: child,
              );
            },
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.mainBackgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.mainText.withOpacity(0.4))),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image:
                        DecorationImage(image: NetworkImage(widget.imageUrl))),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(finalName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(color: AppColors.themeColors)),
                          Text(
                            finalArtist,
                            style: TextStyle(color: AppColors.secondary),
                          )
                        ],
                      ),
                    ),
                    Container(
                        child: Icon(
                      CupertinoIcons.play_arrow_solid,
                      color: AppColors.themeColors,
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
