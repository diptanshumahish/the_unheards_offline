import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_unheards_offline/screens/screens.dart';
import 'package:the_unheards_offline/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //navigation
  int _selectedIndex = 0;

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
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0.0,
        backgroundColor: AppColors.mainBackgroundColor,
        selectedItemColor: AppColors.themeColors,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        unselectedItemColor: AppColors.mainText,
        onTap: _navigateBottomBar,
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.home),
            label: ('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.music),
            label: ('Music'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.settings),
            label: ('settings'),
          ),
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
}
