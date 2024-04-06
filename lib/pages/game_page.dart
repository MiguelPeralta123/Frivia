import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frivia/providers/game_page_provider.dart';

class GamePage extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;
  GamePageProvider? _gamePageProvider;
  String difficulty;

  GamePage({super.key, required this.difficulty});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    // Everything below this buildUI widget can access GamePageProvider
    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(context: context, difficulty: difficulty),
      child: buildUI(),
    );
  }

  Widget buildUI() {
    return Builder(
      builder: (context) {
        // Initialize the provider by using it
        _gamePageProvider = context.watch<GamePageProvider>();
        if(_gamePageProvider!.questions != null) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.1),
                child: gameUI(),
              ),
            ),
          );
        }
        else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  Widget gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        questionText(),
        Column(
          children: [
            trueButton(),
            SizedBox(
              height: _deviceHeight * 0.01,
            ),
            falseButton(),
          ],
        )
      ],
    );
  }

  Widget questionText() {
    return Text(
      _gamePageProvider!.getCurrentQuestion(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget trueButton() {
    return MaterialButton(
      onPressed: () {
        _gamePageProvider!.answerQuestion('True');
      },
      height: _deviceHeight * 0.05,
      minWidth: _deviceWidth,
      color: Colors.green,
      child: const Text(
        "True",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget falseButton() {
    return MaterialButton(
      onPressed: () {
        _gamePageProvider!.answerQuestion('False');
      },
      height: _deviceHeight * 0.05,
      minWidth: _deviceWidth,
      color: Colors.red,
      child: const Text(
        "False",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}