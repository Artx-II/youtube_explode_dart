import 'package:test/test.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

void main() {

  var url = 'https://www.youtube.com/watch?v=teHNoT99deQ';
  var id = 'teHNoT99deQ';

  test('Parse valid video id', () {
    var id = 'dpeavGs0uO0';
    expect(YoutubeExplode.parseVideoId(id), equals(id));
  });

  test('Parse id from youtube url', () {
    expect(YoutubeExplode.parseVideoId(url), equals(id));
  });

  test('Get video title', () async {
    var yt = YoutubeExplode();
    var video = await yt.getVideo(id);
    print(video.title);
    yt.close();
  });

  test('Parse invalid id', () {
    var id = 'aaa';
    expect(YoutubeExplode.parseVideoId(id), isNull);
  });

  test('Get video media stream details', () async {
    var yt = YoutubeExplode();
    var mediaStream = await yt.getVideoMediaStream(id);
    print(mediaStream.videoDetails.title);
    print("Video duration: ${mediaStream.videoDetails.duration}");
    print("Audio Size: ${mediaStream.audio.last.size}");
    for (var size in mediaStream.video) {
      print("Resolution: ");
      print("Height: ${size.videoResolution.height}");
      print("Width: ${size.videoResolution.width}");
      print("Size: ${size.size}");
    }
    expect(mediaStream, isNotNull);
    yt.close();
  }, timeout: const Timeout(Duration(minutes: 1)));

  test('Get video media stream with invalid id', () async {
    var yt = YoutubeExplode();
    try {
      await yt.getVideoMediaStream('aaa');
      neverCalled();
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      expect(e, isArgumentError);
    } finally {
      yt.close();
    }
  });

  // TODO: Implement more tests
}
