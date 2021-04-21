import 'package:death_to_romaji/frontend/custom_widgets/choice_button_widget.dart';
import 'package:death_to_romaji/view_models/game_view_model.dart';
import 'package:flutter/material.dart';

import 'frontend/game_page.dart';
import 'backend/data_sources/letter_data_source.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 300,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GamePage(GameViewModel(GameType.HIRAGANA))));
                },
                child: Text("HIRAGANA"),
              ),
              decoration: BoxDecoration(
                color: Colors.black26
              ),
            ),
            Container(
              height: 50,
              width: 300,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GamePage(GameViewModel(GameType.KATAKANA))));
                },
                child: Text("KATAKANA"),
              ),
              decoration: BoxDecoration(
                color: Colors.black26
              ),
            ),
            Container(
              height: 50,
              width: 300,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GamePage(GameViewModel(GameType.BOTH))));
                },
                child: Text("BOTH"),
              ),
              decoration: BoxDecoration(
                color: Colors.black26
              ),
            ),
          ],
        ),
      )
    );
  }
}
