import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:iqttv_play/constants/colors.dart';
import 'package:iqttv_play/widgets/card_publicidad.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen>
    with WidgetsBindingObserver {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  String? _errorMessage;

  final List<String> _playlist = [
    'https://ssh101stream.ssh101.com/akamaissh101/ssh101/c89iqttv/playlist.m3u8',
  ];

  final int _currentVideoIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializePlayer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  void _initializePlayer() {
    try {
      _controller = VideoPlayerController.networkUrl(
          Uri.parse(_playlist[_currentVideoIndex]),
        )
        ..initialize().then((_) {
          if (mounted) {
            setState(() {});
          }
        });

      _chewieController = ChewieController(
        videoPlayerController: _controller,
        autoPlay: false,
        allowedScreenSleep: false,
        isLive: true,
        showControlsOnInitialize: false,
        showOptions: false,
        allowPlaybackSpeedChanging: false,
        customControls: CupertinoControls(
          backgroundColor: const Color.fromARGB(50, 40, 40, 40),
          iconColor: Colors.white,
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = "Error al cargar el video: ${e.toString()}";
      });
      debugPrint(_errorMessage);
    }
  }

  void _refreshPlayer() {
    _controller.dispose();
    _chewieController.dispose();
    _initializePlayer();
    setState(() {
      _errorMessage = null;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _refreshPlayer();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        if (_controller.value.isInitialized) {
          _controller.pause();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              _controller.value.isInitialized
                  ? Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Chewie(controller: _chewieController),
                    ),
                  )
                  : LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation(AppColors.secondary),
                  ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: ElevatedButton(
              onPressed: _refreshPlayer,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(2.0),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white70,
              ),
              child: Text(
                '⚡Recargar reproductor',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          _errorMessage != null
              ? Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: AppColors.secondary.withAlpha(200),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    _errorMessage.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              : SizedBox.shrink(),
          CardPublicidad(
            bgColor: Colors.blue,
            title: '📢¡Destaca tu marca con nosotros!💡',
            body:
                'Obtén publicidad a tu medida y llega a más personas.📺 '
                'Toca el botón para más información.',
            btnText: ' 🚀¡Quiero Publicidad!',
            btnUrl: 'https://iqttv.tv/publicidad/',
          ),
        ],
      ),
    );
  }
}
