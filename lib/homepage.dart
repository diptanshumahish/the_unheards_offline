import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_unheards_offline/screens/screens.dart';
import 'package:the_unheards_offline/utils/utils.dart';
import 'package:the_unheards_offline/widgets/homescreen_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //navigation
  int _selectedIndex = 0;
  int colorr = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //different pages to navigate to
  final List<Widget> _children = [
    const HomeScreen(),
    const MusicScreen(),
    const SettingsSCreen(),
  ];

  // navigation above

  //define the audio player
  final OnAudioQuery _audioQuery = OnAudioQuery();
//player
  final AudioPlayer _player = AudioPlayer();

  //request storage permisiion
  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainBackgroundColor,
        extendBodyBehindAppBar: true,
        body: _children[_selectedIndex],
        bottomNavigationBar: BottomAppBar(
          color: AppColors.transparent,
          elevation: 0,
          child: Container(
              height: 110,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  BottomAudioPlayer(
                    imageUrl:
                        "https://a10.gaanacdn.com/gn_img/song/JD2KJyAbOL/2KJ4geA1WO/size_m_1516002248.webp",
                    artistName: "The Guy",
                    songName: "New Song",
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          FeatherIcons.home,
                          color: (_selectedIndex == 0)
                              ? AppColors.themeColors
                              : AppColors.mainText,
                        ),
                        onPressed: () {
                          _navigateBottomBar(0);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          FeatherIcons.music,
                          color: (_selectedIndex == 1)
                              ? AppColors.themeColors
                              : AppColors.mainText,
                        ),
                        onPressed: () {
                          _navigateBottomBar(1);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          FeatherIcons.settings,
                          color: (_selectedIndex == 2)
                              ? AppColors.themeColors
                              : AppColors.mainText,
                        ),
                        onPressed: () {
                          _navigateBottomBar(2);
                        },
                      ),
                    ],
                  ),
                ],
              )),
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
}
