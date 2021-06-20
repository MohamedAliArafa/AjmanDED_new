import 'package:flutter_app/model/WatsonAssistant/watson_assistant_message_response.dart';
import 'package:flutter_app/model/WatsonAssistant/watson_assistant_session_response.dart';
import 'package:flutter_app/resources/watson_repository/watson_repository.dart';
import 'package:rxdart/rxdart.dart';

class WatsonAssistantBlock {
  final _repository = WatsonAssistantRepository();
  final _messageFetcher = PublishSubject<WatsonAssistantResponse>();
  final _sessionFetcher = PublishSubject<WatsonAssistantSessionResponse>();

  Observable<WatsonAssistantResponse> get message => _messageFetcher.stream;

  Observable<WatsonAssistantSessionResponse> get session =>
      _sessionFetcher.stream;

  sendMessage(textInput, sessionId) async {
    WatsonAssistantResponse response =
        await _repository.sendMessage(textInput, sessionId);
    _messageFetcher.sink.add(response);
  }

  createSession() async {
    WatsonAssistantSessionResponse response = await _repository.createSession();
    _sessionFetcher.sink.add(response);
  }

  dispose() {
    _messageFetcher.close();
    _sessionFetcher.close();
  }
}

final block = WatsonAssistantBlock();
