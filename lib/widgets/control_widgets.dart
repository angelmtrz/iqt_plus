import 'package:flutter/material.dart';
import 'package:iqttv_play/constants/colors.dart';
import 'package:video_player/video_player.dart';

class ControlWidgets extends StatefulWidget {
  final Orientation orientation;
  final String playerStatus;
  final VideoPlayerController controller;
  final bool isMuted;
  final VoidCallback toggleMute;
  final VoidCallback toggleFullScreen;

  const ControlWidgets({
    super.key,
    required this.orientation,
    required this.playerStatus,
    required this.controller,
    required this.isMuted,
    required this.toggleMute,
    required this.toggleFullScreen,
  });

  @override
  State<ControlWidgets> createState() => _ControlWidgetsState();
}

class _ControlWidgetsState extends State<ControlWidgets> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Mostrar el estado de reproducción ("EN VIVO" o "PAUSADO") si el video se está reproduciendo o está pausado
        if (widget.controller.value.isPlaying ||
            !widget.controller.value.isPlaying)
          Container(
            key: const Key('liveStatus'),
            padding: const EdgeInsets.all(2),
            color:
                widget.controller.value.isPlaying
                    ? AppColors.secondary
                    : Colors.grey, // Cambiar el color si está pausado
            child: Text(
              widget.playerStatus,
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),
          ),
        IconButton(
          key: const Key('playPause'),
          color: Colors.white,
          icon: Icon(
            widget.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          onPressed: () {
            setState(() {
              widget.controller.value.isPlaying
                  ? widget.controller.pause()
                  : widget.controller.play();
            });
          },
        ),
        IconButton(
          key: const Key('mute'),
          color: Colors.white,
          icon: Icon(widget.isMuted ? Icons.volume_off : Icons.volume_up),
          onPressed: widget.toggleMute,
        ),
        IconButton(
          key: const Key('fullscreen'),
          color: Colors.white,
          icon:
              widget.orientation == Orientation.portrait
                  ? const Icon(Icons.fullscreen)
                  : const Icon(Icons.fullscreen_exit),
          onPressed: widget.toggleFullScreen,
        ),
      ],
    );
  }
}
