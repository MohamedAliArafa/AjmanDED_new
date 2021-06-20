import 'package:flutter_app/widgets/chat_list.dart';
import 'package:rxdart/rxdart.dart';

class ChatBlock {
  final _messageFetcher = PublishSubject<Message>();

  Observable<Message> get message => _messageFetcher.stream;

  sendMessage(Message message) async {
    _messageFetcher.sink.add(message);
  }

  dispose() {
    _messageFetcher.close();
  }
}

final chatBlock = ChatBlock();
