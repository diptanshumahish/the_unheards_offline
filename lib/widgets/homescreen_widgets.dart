import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

// ignore: must_be_immutable
class HomeScreenWIdget extends StatefulWidget {
  late var songName = "";
  late int totalSongs = 0;
  late int recentlyAddedSongs = 0;
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
    "Currently Playing",
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
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(
          color: AppColors.secondary, borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(widgetDetails[widget.index]),
          Text(subDetails[widget.index]["value"]),
        ],
      ),
    );
  }
}

//bottom audio playing widget

class BottomAudioPlayer extends StatefulWidget {
  late var imageUrl =
      "https://a10.gaanacdn.com/gn_img/song/JD2KJyAbOL/2KJ4geA1WO/size_m_1516002248.webp";
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
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.mainText.withOpacity(0.4))),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(image: NetworkImage(widget.imageUrl))),
            ),
            SizedBox(width: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.songName,
                        style: TextStyle(color: AppColors.themeColors)),
                    Text(
                      widget.artistName,
                      style: TextStyle(color: AppColors.secondary),
                    )
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 2),
                Container(
                    child: Icon(
                  CupertinoIcons.play_arrow_solid,
                  color: AppColors.themeColors,
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
