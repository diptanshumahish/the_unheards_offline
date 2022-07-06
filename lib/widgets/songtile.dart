import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../utils/utils.dart';

class SongTile extends StatefulWidget {
  late int index;
  late var artwork;
  late var title;
  late var artist;
  SongTile(
      {Key? key,
      required this.index,
      required this.artwork,
      required this.title,
      required this.artist})
      : super(key: key);

  @override
  State<SongTile> createState() => _SongTileState();
}

class _SongTileState extends State<SongTile> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Container(
            height: 80,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 0.1, color: AppColors.mainText.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(6),
                color: AppColors.transparent),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  QueryArtworkWidget(
                    id: widget.artwork,
                    type: ArtworkType.AUDIO,
                    artworkQuality: FilterQuality.high,
                    artworkBorder: BorderRadius.circular(5),
                  ),
                  const SizedBox(width: 15),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.title,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 17,
                                overflow: TextOverflow.clip,
                                color: AppColors.mainText)),
                        SizedBox(height: 5),
                        Text(widget.artist,
                            style: TextStyle(color: AppColors.themeColors))
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
