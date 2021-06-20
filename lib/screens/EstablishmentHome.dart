import 'package:flutter/material.dart';
import 'package:flutter_app/colors/colors.dart';
import 'package:flutter_app/component/buttons/MainButtonContainer.dart';
import 'package:flutter_app/screens/QRTest.dart';

class EstablishmentHomePage extends StatefulWidget {
  EstablishmentHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyEstablishmentHomePageState createState() =>
      _MyEstablishmentHomePageState();
}

class _MyEstablishmentHomePageState extends State<EstablishmentHomePage> {
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
                    Row(
                      children: [
                        BackButton(
                          color: CustomColors.navy,
                        ),
                        Expanded(
                          child: Image.asset(
                            'assets/images/govtded.png',
                          ),
                        )
                      ],
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
                                "مرحبا عزيزي المتعامل",
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
                        "مطعم المدينة لخدمات التموين بالمواد الغذائية",
                        style: TextStyle(
                            color: CustomColors.navy,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(_buttonPadding + 10),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/ic_golden_star.png",
                                    width: 10,
                                    height: 10,
                                  ),
                                  Image.asset(
                                    "assets/images/ic_golden_star.png",
                                    width: 10,
                                    height: 10,
                                  ),
                                  Image.asset(
                                    "assets/images/ic_golden_star.png",
                                    width: 10,
                                    height: 10,
                                  ),
                                  Image.asset(
                                    "assets/images/ic_golden_star.png",
                                    width: 10,
                                    height: 10,
                                  ),
                                  Image.asset(
                                    "assets/images/ic_golden_star.png",
                                    width: 10,
                                    height: 10,
                                  ),
                                ],
                              ),
                              Text(
                                "رقم الرخصة: 50917",
                                style: TextStyle(
                                    color: CustomColors.navy,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "تقييم المنشأة",
                                style: TextStyle(
                                    color: CustomColors.navy,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "المنطقة: الجرف لصناعية 1",
                                style: TextStyle(
                                    color: CustomColors.navy,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "الحالة: مصدرة",
                                style: TextStyle(
                                    color: CustomColors.navy,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(_buttonPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text("التواصل مع المنشأة"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset("assets/images/ic_call.png", width: 30, height: 30,),
                                  Text("51355453")
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text("مؤشر المنشأة"),
                              Image.asset("assets/images/ic_green.png", width: 100, height: 100,),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("منشأة ملتزمة"),
                                  Image.asset("assets/images/ic_green.png", width: 10, height: 10,),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("منشأة متوسطة"),
                                  Image.asset("assets/images/ic_green.png", width: 10, height: 10,),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("منشأة غير ملتزمة"),
                                  Image.asset("assets/images/ic_pink.png", width: 10, height: 10,),
                                ],
                              ),
                            ],
                          ),
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
