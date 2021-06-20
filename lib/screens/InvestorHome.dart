import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/colors/colors.dart';
import 'package:flutter_app/component/buttons/MainButtonContainer.dart';
import 'package:flutter_app/screens/LicensesList.dart';
import 'package:flutter_app/screens/QRTest.dart';
import 'package:path_provider/path_provider.dart';

import 'LicenseDisplay.dart';

class InvestorHomePage extends StatefulWidget {
  InvestorHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyInvestorHomePageState createState() => _MyInvestorHomePageState();
}

class _MyInvestorHomePageState extends State<InvestorHomePage> {
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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    const double _mainMargin = 30.0;
    const double _buttonPadding = 10.0;
    const double _buttonBorderRadius = 20.0;
    const double _buttonShadowBlurRadius = 10.0;
    const double _buttonShadowSpreadRadius = 1.0;
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg_main.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: Column(
          children: [
            SafeArea(
              child: Container(
                margin: const EdgeInsets.only(
                    top: _mainMargin, left: _mainMargin, right: _mainMargin),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset('assets/images/govtded.png'),
                    ),
                    Container(
                      padding: EdgeInsets.all(_buttonPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/ic_avatar_cs.png',
                            width: 80,
                            height: 80,
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(_buttonPadding),
                              margin: const EdgeInsets.all(_buttonPadding),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(_buttonBorderRadius),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: _buttonShadowSpreadRadius,
                                      blurRadius: _buttonShadowBlurRadius),
                                ],
                              ),
                              child: Text(
                                "مرحبا عزيزي المستثمر",
                                style: TextStyle(
                                    color: CustomColors.navy,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(_buttonPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () => {
                                    if (pathPDF.isNotEmpty)
                                      {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LicensesListPage(
                                                      title: pathPDF)),
                                        )
                                      }
                                  },
                              child:
                                  defaultButtonContainer("رخص إقتصادية  (2)")),
                          defaultButtonContainer("التصاريح"),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(_buttonPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          defaultButtonContainer("المعاملات"),
                          defaultButtonContainer("المقترحات"),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(_buttonPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          defaultButtonContainer("التقييم"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset('assets/images/upper_logo.png'),
              ),
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
