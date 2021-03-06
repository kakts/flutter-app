import 'package:flutter/material.dart';

import 'package:english_words/english_words.dart';
import 'dart:async';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  void _openCart() {
    debugPrint("Hello");
  }

  void _test(String str) {
    debugPrint("Helo");
    debugPrint(str);
  }

  void _submit(String str) {
    debugPrint("Submitted");
    debugPrint(str);

  }
  // this build method is typically only called in three situations.
  // The first time the widget is inserted in the tree
  // Widget's parent changes its configuration.
  // an InheritedWidget it depends on changes.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      theme: new ThemeData(
        primaryColor: Colors.brown,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text('Welcome to Flutter'),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.shopping_cart),
              tooltip: 'Open shopping cart',
              onPressed: _openCart,
            ),
          ]
        ),
        body: new Center(
          child: new TextField(
            autocorrect: false,
            autofocus: false,
            decoration: new InputDecoration(
              hintText: 'Type something'
            ),
            onChanged: _test,
            onSubmitted: _submit,
          ), // this highlighted text
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
  // For saving suggested word pairings.
  final _suggestions = <WordPair>[];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  // This set stores the owrd pairings that user favorited.
  // Set is preferred to List because a properly implemented Set does not
  // allow duplicate entries.
  final _saved = new Set<WordPair>();

  // When the user taps the list icon in the app, build a route and push it to the Navigator's stack.
  // This action changes the screen to display the new route
  void _pushSaved() {
    // Add the MaterialPageRoute and its builder.
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile
            .divideTiles(
              context: context,
              tiles: tiles,
            )
            .toList();

          // builder property returns a Scaffold, containing the app bar for the new route
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ]
      ),
      body: _buildSuggestions()
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // The itemBuilder callback is called once per suggested word pairing,
      // and places each suggestion into a ListTile row.
      // For even rows, the function adds a ListTile row for the word pairing.
      // For odd rows, the function adds a Divider widget to visually
      // separate the entries. Note that the divider may be difficult
      // to see on smaller devices.
      itemBuilder: (context, i) {
        // add a one-pixel-high divider widget before each row in the ListView.
        if (i.isOdd) {
          return new Divider();
        }

        // The syntax "i ~/ 2" divides i by 2 and returns an integer result.
        // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
        // This calculates the actual number of word pairings in the ListView,
        // minus the divider widgets.
        final index = i ~/ 2;

        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      }
    );
  }
}