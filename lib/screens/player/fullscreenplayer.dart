import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:the_unheards_offline/utils/utils.dart';

class FullScreenPlayer extends StatefulWidget {
  late int index;
  late var artwork;
  late var title;
  late var artist;
  FullScreenPlayer(
      {Key? key,
      required this.index,
      required this.artwork,
      required this.title,
      required this.artist})
      : super(key: key);

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  final AudioPlayer _player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key("dismissible"),
      onDismissed: (_) => Navigator.of(context).pop(),
      direction: DismissDirection.down,
      resizeDuration: Duration(milliseconds: 200),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Scaffold(
          backgroundColor: AppColors.mainBackgroundColor.withOpacity(0.8),
          appBar: AppBar(
            backgroundColor: AppColors.transparent,
            centerTitle: true,
            elevation: 0,
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: const Icon(CupertinoIcons.chevron_down),
              onPressed: () => Navigator.pop(context, false),
            ),
            title: Text("Now Playing"),
          ),
          body: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 300,
                          width: 300,
                          child: QueryArtworkWidget(
                            id: widget.artwork,
                            type: ArtworkType.AUDIO,
                            artworkBorder: BorderRadius.circular(8),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),
                    //icons on the right side
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(CupertinoIcons.shuffle),
                          color: AppColors.secondary,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(CupertinoIcons.graph_square),
                          color: AppColors.secondary,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(CupertinoIcons.repeat),
                          color: AppColors.secondary,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(CupertinoIcons.search),
                          color: AppColors.secondary,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.mainText,
                          fontSize: 30),
                    ),
                    Text(
                      widget.artist,
                      style:
                          TextStyle(color: AppColors.themeColors, fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.backward_end_fill,
                      color: AppColors.secondary,
                      size: 45,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(CupertinoIcons.play_circle_fill,
                        color: AppColors.themeColors, size: 45),
                    onPressed: () {
                      _player.pause();
                    },
                  ),
                  IconButton(
                    icon: Icon(CupertinoIcons.forward_end_fill,
                        color: AppColors.secondary, size: 45),
                    onPressed: () {
                      _player.play();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
