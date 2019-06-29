import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
} 

class MyApp extends StatelessWidget{
  @override
  Widget build(context){
    return MaterialApp(
      title: 'Startup Name Generator',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Some String'),
        ),
        body: RandomWords(),
        // body: Card(
        //   child: Column(
        //     children: <Widget>[
        //     Image.asset('assets/random-word-generator.gif'),
        //     Text('Food Paradise'),
        //     ],
        //   ),
        // ),
      )
    );
  }
}

class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  List<WordPair> _suggestions = new List();
  Set<WordPair> _saved = new Set();
  TextStyle _biggerFont = const TextStyle(fontSize: 18);

  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;

        if (index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index], i);
      },
    );
  }

  Widget _buildRow(WordPair wordPair, counter){
    final bool _alreadySaved = _saved.contains(wordPair);

    return ListTile (
      title: Text(
        wordPair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        _alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: _alreadySaved ? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          if(_alreadySaved) {
            _saved.remove(wordPair);
          } else {
            _saved.add(wordPair);
          }
            });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute (
        builder: (context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair wordPair) {
              return ListTile(
                title: Text(
                  wordPair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          
          final List<Widget> divded = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold (
            appBar: AppBar(
              title: Text("Saved Suggestions"),
            ),
            body: ListView(children: divded),
          );
        },
      )
    );
  }
}