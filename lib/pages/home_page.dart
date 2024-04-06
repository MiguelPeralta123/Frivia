import 'package:flutter/material.dart';
import 'package:frivia/pages/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;
  final _difficultyValues = ['Easy', 'Medium', 'Hard'];
  int _difficulty = 0;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _pageTitle(),
              _difficultySlider(),
              _startButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pageTitle() {
    return Column(
      children: [
        const Text(
          "Frivia",
          style: TextStyle(
            color: Colors.white,
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          _difficultyValues[_difficulty],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ],
    );
  }

  Widget _difficultySlider() {
    return Slider(
      min: 0.0,
      max: 2.0,
      value: _difficulty.toDouble(),
      divisions: 2,
      onChanged: (value) {
        setState(() {
          _difficulty = value.toInt();
        });
      },
    );
  }

  Widget _startButton(context) {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return GamePage(difficulty: _difficultyValues[_difficulty].toLowerCase(),);
            }
          ),
        );
      },
      height: _deviceHeight * 0.05,
      minWidth: _deviceWidth,
      color: Colors.blue,
      child: const Text(
        "Start",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}