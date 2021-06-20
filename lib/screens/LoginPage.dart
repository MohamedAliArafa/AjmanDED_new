import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/colors/colors.dart';
import 'package:flutter_app/component/buttons/MainButtonContainer.dart';
import 'package:flutter_app/screens/QRTest.dart';

import 'InvestorHome.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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

    bool _obscureText = true;
    String _password = "";
    String _email = "";
    final _formKey = GlobalKey<FormState>();
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
                        margin:
                            const EdgeInsets.only(top: 80, left: 10, right: 10),
                        child: Text(
                          "تسجيل دخول",
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.navy),
                        )),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: _emailController,
                              validator: (val) => val!.length < 6
                                  ? 'Email too short.'
                                  : EmailValidator.validate(val)
                                      ? null
                                      : "Please enter a valid email",
                              onSaved: (val) => _email = val!,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                labelText: "البريد الإلكتروني",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: _passwordController,
                              validator: (val) => val!.length < 6
                                  ? 'Password too short.'
                                  : null,
                              onFieldSubmitted: (val) => _password = val,
                              onSaved: (val) => _password = val!,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                labelText: "كلمة السر",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Container(
                            child: ElevatedButton(
                              child: Text("دخول"),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (_) {
                                    return InvestorHomePage(title: "User Home Page");
                                  }));
                                }
                              },
                            ),
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
