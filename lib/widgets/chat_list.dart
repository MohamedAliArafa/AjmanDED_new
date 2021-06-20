import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/block/chat_block.dart';
import 'package:flutter_app/colors/colors.dart';
import 'package:flutter_app/model/WatsonAssistant/watson_assistant_message_response.dart';
import 'package:flutter_html/flutter_html.dart';

enum MessageDirection { SENDER, RECEIVER }
enum MessageType { OPTION, TEXT }

class Message {
  const Message(
      {this.text,
      required this.direction,
      required this.type,
      this.options,
      this.onClick});

  final String? text;
  final MessageClickedCallback? onClick;
  final MessageDirection direction;
  final MessageType type;
  final List<Options>? options;
}

typedef void MessageAddedCallback(Message message);
typedef void MessageClickedCallback(String? message);

class MessageListItem extends StatelessWidget {
  MessageListItem({
    required this.message,
  }) : super(key: ObjectKey(message));

  final Message message;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return message.direction == MessageDirection.SENDER //
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (message.direction != MessageDirection.SENDER) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    print("MessageListItem");
    switch (message.type) {
      case MessageType.TEXT:
        return listTextRow();
      case MessageType.OPTION:
        return listOptionsRow();
    }
  }

  Widget listOptionsRow() {
    return Row(
      children: [
        // Image.asset(
        //   'assets/images/ic_avatar_cs.png',
        //   width: 50,
        //   height: 50,
        // ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
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
            child: Html(
              data: message.text ?? "",
              style: {
                'html': Style(color: CustomColors.navy,
                    fontSize: FontSize(18),
                    alignment: Alignment.center,
                    fontWeight: FontWeight.bold)
              }
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: message.options!.map((Options option) {
              return GestureDetector(
                onTap: () => {
                  message.onClick!(option.value!.input!.text),
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5.0),
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    color: CustomColors.navy,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 1.0,
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Text(
                    option.label ?? "",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget listTextRow() {
    return Row(
      // mainAxisSize: MainAxisSize.max,
      textDirection: message.direction == MessageDirection.SENDER
          ? TextDirection.rtl
          : TextDirection.ltr,
      children: [
        Image.asset(
          'assets/images/ic_avatar_cs.png',
          width: 50,
          height: 50,
        ),
        Expanded(
          child: GestureDetector(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1.0,
                      blurRadius: 10.0),
                ],
              ),
              child: Html(
                data: message.text ?? "",
                style: {
                  'html': Style(
                      fontSize: FontSize(18),
                      fontWeight: FontWeight.bold,
                      color: CustomColors.navy,
                      textAlign: TextAlign.center),
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final ScrollController _listScrollController = new ScrollController();
  Set<Message> _messages = Set<Message>();

  void _handleMessageAdded(Message message) {
    setState(() {
      _messages.add(message);
      listKey.currentState!.insertItem(_messages.length - 1,
          duration: const Duration(milliseconds: 500));
      Timer(Duration(milliseconds: 220), () {
        _listScrollController.animateTo(
          _listScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      });
    });
  }

  addMessage(Message message) => {_handleMessageAdded(message)};

  List<Widget> _buildRow(text) {
    return [
      Image.asset(
        'assets/images/ic_avatar_cs.png',
        width: 50,
        height: 50,
      ),
      Expanded(
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
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
              text,
              style: TextStyle(
                  color: CustomColors.navy,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ];
  }

  Widget _buildChatPage() {
    print("_buildChatPage");
    return Expanded(
      child: AnimatedList(
        key: listKey,
        controller: _listScrollController,
        initialItemCount: _messages.length,
        padding: EdgeInsets.all(0.0),
        itemBuilder: (context, i, animation) {
          return SlideTransition(
            position: _messages.elementAt(i).direction ==
                    MessageDirection.RECEIVER
                ? Tween<Offset>(begin: const Offset(-1, 0), end: Offset(0, 0))
                    .animate(animation)
                : Tween<Offset>(begin: const Offset(1, 0), end: Offset(0, 0))
                    .animate(animation),
            child: MessageListItem(
              message: _messages.elementAt(i),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children:
            //       _messages.elementAt(i).direction == MessageDirection.RECEIVER
            //           ? [
            //               _buildRow(_messages.elementAt(i).text)[0],
            //               _buildRow(_messages.elementAt(i).text)[1]
            //             ]
            //           : [
            //               _buildRow(_messages.elementAt(i).text)[1],
            //               _buildRow(_messages.elementAt(i).text)[0]
            //             ],
            // ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildChatPage();
  }

  String pathPDF = "";

  @override
  void initState() {
    super.initState();
  }

  void addMessages(List<Message> messages) {
    setState(() {
      this._messages = messages as Set<Message>;
    });
  }
}
