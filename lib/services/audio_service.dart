import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

class SimpleAudioHandler extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _player = AudioPlayer();

  late final StreamSubscription<PlaybackEvent> _eventSub;
  late final StreamSubscription<Duration?> _durationSub;
  late final StreamSubscription<int?> _indexSub;

  SimpleAudioHandler() {
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    session.becomingNoisyEventStream.listen((_) => pause());
    session.interruptionEventStream.listen((event) {
      if (event.begin && event.type == AudioInterruptionType.pause) {
        pause();
      } else if (!event.begin &&
          event.type == AudioInterruptionType.pause &&
          !playbackState.value.playing) {
        play();
      }
    });

    _eventSub = _player.playbackEventStream.listen(
          (event) => playbackState.add(_transformEvent(event)),
      onError: (err, _) => playbackState.add(
        playbackState.value.copyWith(
          playing: false,
          processingState: AudioProcessingState.idle,
          errorMessage: err.toString(),
        ),
      ),
    );

    _durationSub = _player.durationStream.listen((duration) {
      final current = mediaItem.value;
      if (current != null && duration != null && current.duration != duration) {
        mediaItem.add(current.copyWith(duration: duration));
      }
    });

    _indexSub = _player.currentIndexStream.listen((index) {
      final items = queue.value;
      if (index != null && index < items.length) {
        mediaItem.add(items[index]);
      }
    });
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
        MediaAction.setShuffleMode,
        MediaAction.setRepeatMode,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: _mapProcessingState(_player.processingState),
      playing: _player.playing,
      updatePosition: event.updatePosition,
      bufferedPosition: event.bufferedPosition,
      speed: _player.speed,
      updateTime: DateTime.now(),
      queueIndex: event.currentIndex,
    );
  }

  AudioProcessingState _mapProcessingState(ProcessingState state) {
    switch (state) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
        return AudioProcessingState.loading;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
    }
  }

  /// Play a single [MediaItem] or a list as a playlist.
  Future<void> playPlaylist(List<MediaItem> items) async {
    queue.add(items);
    final sources = items.map((item) {
      final source = item.id.startsWith('asset://')
          ? AudioSource.asset(item.id.replaceFirst('asset://', ''), tag: item)
          : AudioSource.uri(Uri.parse(item.id), tag: item);
      return source;
    }).toList();

    final playlist = ConcatenatingAudioSource(children: sources);
    try {
      await _player.setAudioSource(playlist, initialIndex: 0, initialPosition: Duration.zero);
      mediaItem.add(items.first);
      await _player.play();
    } catch (e) {
      playbackState.add(
        playbackState.value.copyWith(
          playing: false,
          processingState: AudioProcessingState.idle,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> playMediaItem(MediaItem item) => playPlaylist([item]);

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    await _player.stop();
    return super.stop();
  }

  Future<void> disposeHandler() async {
    await _eventSub.cancel();
    await _durationSub.cancel();
    await _player.dispose();
    await super.stop();
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode mode) =>
      _player.setShuffleModeEnabled(mode == AudioServiceShuffleMode.all);

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode mode) =>
      _player.setLoopMode(mode == AudioServiceRepeatMode.one
          ? LoopMode.one
          : mode == AudioServiceRepeatMode.all
          ? LoopMode.all
          : LoopMode.off);
}
