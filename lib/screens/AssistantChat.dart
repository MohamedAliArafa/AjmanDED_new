import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/block/watson_block.dart';
import 'package:flutter_app/colors/colors.dart';
import 'package:flutter_app/model/WatsonAssistant/watson_assistant_message_response.dart';
import 'package:flutter_app/widgets/chat_list.dart';
import 'package:flutter_app/block/chat_block.dart';

class AssistantChatPage extends StatefulWidget {
  AssistantChatPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyAssistantChatPageState createState() => _MyAssistantChatPageState();
}

class _MyAssistantChatPageState extends State<AssistantChatPage> {
  final GlobalKey<ChatPageState> _key = GlobalKey();
  final _messagesController = TextEditingController();

  String? sessionId;
  StreamSubscription<WatsonAssistantResponse>? _subscriber;

  @override
  void initState() {
    super.initState();
    block.createSession();
    block.session.listen((event) {
      sessionId = event.sessionId;

      chatBlock.sendMessage(Message(
          direction: MessageDirection.SENDER,
          type: MessageType.TEXT,
          text: "مرحب"));
    });

    block.message.listen((event) {
      var generic = event.output!.generic!;
      for (var element in generic) {
        if (element.responseType == "text") {
          var receivedMessage = Message(
              text: element.text ?? "",
              direction: MessageDirection.RECEIVER,
              type: MessageType.TEXT);
          _key.currentState?.addMessage(receivedMessage);
        } else if (element.responseType == "option") {
          var options = element.options!;
          var receivedMessage = Message(
            direction: MessageDirection.RECEIVER,
            type: MessageType.OPTION,
            text: element.title,
            options: options,
            onClick: (input) => {
              _key.currentState?.addMessage(Message(
                  text: input ?? "",
                  direction: MessageDirection.SENDER,
                  type: MessageType.TEXT)),
              block.sendMessage(input ?? "", sessionId),
            },
          );
          _key.currentState?.addMessage(receivedMessage);
          // }
        }
      }
    });

    chatBlock.message.listen((receivedMessage) {
      print(receivedMessage.text);
      _key.currentState?.addMessage(receivedMessage);
      _handleSendMessage();
      _messagesController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    const double _mainMargin = 30.0;
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
                    Container(
                      child: Row(
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
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ChatPage(key: _key),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messagesController,
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      chatBlock.sendMessage(
                        Message(
                          direction: MessageDirection.SENDER,
                          type: MessageType.TEXT,
                          text: _messagesController.text,
                        ),
                      );
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  void _handleSendMessage() {
    block.sendMessage(_messagesController.text, sessionId);
  }

  @override
  void dispose() {
    chatBlock.dispose();
    super.dispose();
  }
}
