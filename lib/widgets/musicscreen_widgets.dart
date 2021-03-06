import 'package:flutter/material.dart';

import '../screens/content/content.dart';
import '../utils/utils.dart';

class MusicScreenTop extends StatelessWidget {
  int index;
  MusicScreenTop({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map> contentType = [
      {
        "imageurl": "https://source.unsplash.com/random/1920x1080/?night/1",
        "type": "Songs",
        "subtitle": "All your songs here",
      },
      {
        "imageurl": "https://source.unsplash.com/random/1920x1080/?night/2",
        "type": "Albums",
        "subtitle": "All your albums!",
      },
      {
        "imageurl": "https://source.unsplash.com/random/1920x1080/?sunset",
        "type": "Artists",
        "subtitle": "All your favorite artists are here",
      },
      {
        "imageurl": "https://source.unsplash.com/random/1920x1080/?night/4",
        "type": "Playlists",
        "subtitle": "Your playlists",
      }
    ];
    List<Widget> pageNames = [
      SongsPage(),
      AlbumPage(),
      ArtistPage(),
      PlaylistPage(),
    ];

    return GestureDetector(
      // },
      onTap: () {
        {
          showGeneralDialog(
            barrierLabel: "Label",
            barrierDismissible: false,
            barrierColor: AppColors.mainBackgroundColor.withOpacity(0.5),
            transitionDuration: Duration(milliseconds: 200),
            context: context,
            pageBuilder: (context, anim1, anim2) {
              return pageNames[index];
            },
            transitionBuilder: (context, anim1, anim2, child) {
              return SlideTransition(
                position: Tween(begin: Offset(-1, 0), end: Offset(0, 0))
                    .animate(anim1),
                child: child,
              );
            },
          );
        }
      },

      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    AppColors.mainBackgroundColor.withOpacity(0.5),
                    BlendMode.darken),
                image: NetworkImage(
                  contentType[index]["imageurl"],
                ),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(contentType[index]["type"],
                  style: TextStyle(
                      color: AppColors.mainText,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.7)),
              Text(contentType[index]["subtitle"],
                  style: TextStyle(
                      color: AppColors.themeColors,
                      fontSize: 12,
                      letterSpacing: 0.7)),
            ],
          ),
        ),
      ),
    );
  }
}
