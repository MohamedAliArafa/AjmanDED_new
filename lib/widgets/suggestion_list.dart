import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/colors/colors.dart';
import 'package:flutter_app/screens/LicenseDisplay.dart';
import 'package:path_provider/path_provider.dart';

final _suggestions = <WordPair>[];
final wordPair = WordPair.random();

final _saved = <WordPair>{};
final _biggerFont = TextStyle(
    color: CustomColors.navy, fontSize: 18, fontWeight: FontWeight.bold);

var _context;

class Suggestions extends StatefulWidget {
  @override
  SuggestionsState createState() => SuggestionsState();

  void pushSaved(context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(context: context, tiles: tiles).toList()
              : <Widget>[];

          return ListView(children: divided);
        }, // ...to here.
      ),
    );
  }

  Suggestions() {
    _suggestions.clear();
    _suggestions.add(WordPair("الإسم التجاري ", "شركة سوبر ماركت القدس"));
    _suggestions.add(WordPair("الإسم التجاري ", "النيل لتجارة الاسكراب"));
  }
}

class SuggestionsState extends State<Suggestions> {
  Widget _buildSuggestions() {
    return ListView.builder(
      padding: EdgeInsets.all(0.0),
      itemCount: _suggestions.length,
      itemBuilder: /*1*/ (context, i) {
        // if (i.isOdd) return Divider();
        // /*2*/
        //
        // final index = i ~/ 2; /*3*/
        // if (index >= _suggestions.length) {
        //   _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        // }
        return _buildRow(_suggestions[i]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black26, spreadRadius: 1.0, blurRadius: 10.0),
          ],
        ),
        child: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
      ),
      onTap: () {
        // NEW lines from here...
        setState(() {
          fromAsset('assets/pdf/license_1.pdf', 'license.pdf').then((f) {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LicenseDisplayPage(path: f.path)),
              );
            });
          });
        //   if (pathPDF.isNotEmpty) {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => LicenseDisplayPage(path: pathPDF)),
        //     );
        //   }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildSuggestions();
  }

  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    fromAsset('assets/pdf/license_1.pdf', 'license.pdf').then((f) {
      setState(() {
        pathPDF = f.path;
      });
    });
  }

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}
