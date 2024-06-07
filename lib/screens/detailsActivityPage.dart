import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';

class DetailsActivityScreen extends StatefulWidget {
  @override
  _DetailsActivityScreenState createState() => _DetailsActivityScreenState();
}

class _DetailsActivityScreenState extends State<DetailsActivityScreen> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/video.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });
  }

  @override
  void dispose() {
    // Ensure disposing of the video controller to free up resources
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 36, 36),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 37, 36, 36),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: false, // Disable auto play
                    enlargeCenterPage: true,
                    //aspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
                    viewportFraction: 2.0, // Occupies full width
                  ),
                  items: [
                    _videoController.value.isInitialized
                        ? GestureDetector(
                            onTap: () {
                              if (_videoController.value.isPlaying) {
                                _videoController.pause();
                              } else {
                                _videoController.play();
                              }
                            },
                            child: AspectRatio(
                              aspectRatio: _videoController.value.aspectRatio,
                              child: VideoPlayer(_videoController),
                            ),
                          )
                        : Container(), // Placeholder for video player
                    Image.asset('assets/image1.jpg'),
                    Image.asset('assets/image2.jpg'),
                    // Add more images as needed
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: ListView(
                  children: [
                    buildSection(
                      'BlazePod Agility T Test',
                      'BlazePod\n226.8k Plays',
                    ),
                    buildSection(
                      'Test Description',
                      'Set-up - Place the pods in a T shape\nDistances - The length of the T should be 10m',
                    ),
                    buildSection(
                      'Test Objective',
                      'This short burst test will measure your ability to accelerate and decelerate in all directions. Analyze...',
                    ),
                    buildTestInfo(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Start On Hit'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 3, 126, 124),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Start Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 3, 126, 124),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTestInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Test Information',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '4 Pods\n5 Hits\nSteps: 5',
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(4, (index) {
              return CircleAvatar(
                backgroundColor: Colors.grey[800],
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(color: Colors.white),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DetailsActivityScreen(),
  ));
}
