import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          child: new RandomWords(), // this highlighted text
        ),
      ),
    );
  }
}


class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

// This maintains the state for RandomWords widget.
// This class will save the generated word pairs, which grow infinitely as the use scrolls
// and also favorite word pairs, as the user adds or removes them from the list by toggling the heart icon.

class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new Text(wordPair.asPascalCase);
  }
}