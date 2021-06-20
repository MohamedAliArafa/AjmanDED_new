import 'package:flutter/material.dart';
import 'package:flutter_app/colors/colors.dart';

import 'AssistantChat.dart';
import 'LoginPage.dart';
import 'UserHome.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
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
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset('assets/images/logo_ded_large.png',
                      width: MediaQuery.of(context).size.width * 0.90),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: Image.asset('assets/images/logo_ajman_gov_trans.png'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(0, 5)),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) {
                          return LoginPage(title: "User Home Page");
                        })),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/agreement.png',
                                  width: 50,
                                  height: 50,
                                ),
                                Text(
                                  "مستثمر",
                                  style: TextStyle(
                                      color: CustomColors.navy,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(0, 5)),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) {
                          return AssistantChatPage(title: "User Home Page");
                        })),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/agreement.png',
                                  width: 50,
                                  height: 50,
                                ),
                                Text(
                                  "مستجيب ألي",
                                  style: TextStyle(
                                      color: CustomColors.navy,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.fastOutSlowIn,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(0, 5))
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) {
                          return UserHomePage(title: "User Home Page");
                        })),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/exam.png',
                                  width: 50,
                                  height: 50,
                                ),
                                Text(
                                  "مستهلك",
                                  style: TextStyle(
                                      color: CustomColors.navy,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset('assets/images/upper_logo.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
