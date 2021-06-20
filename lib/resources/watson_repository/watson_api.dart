library watson_assistant_v2;

import 'package:flutter_app/model/WatsonAssistant/watson_assistant_message_response.dart';
import 'package:flutter_app/model/WatsonAssistant/watson_assistant_request.dart'
    as WatsonRequest;
import 'package:flutter_app/model/WatsonAssistant/watson_assistant_session_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WatsonAssistantContext {
  Map<String, dynamic> context;

  WatsonAssistantContext({
    required this.context,
  });

  void resetContext() {
    this.context = {};
  }
}

class WatsonAssistantV2Credential {
  String username;
  String apikey;
  String version;
  String url;
  String assistantID;

  WatsonAssistantV2Credential({
    this.username = 'apikey',
    required this.apikey,
    this.version = "2020-04-01",
    /*
    Service endpoint
     The service endpoint is based on the location of the service instance.
     For example, when Watson Assistant is hosted in Frankfurt, the base URL is https://gateway-fra.watsonplatform.net/assistant/api/v2.
     The URL might also be different when you use IBM Cloud Dedicated.
     */
    required this.url,
    // example this.url = 'https://gateway-lon.watsonplatform.net/assistant/api/v2',
    required this.assistantID,
  });
}

class WatsonAssistantApiV2 {
  WatsonAssistantV2Credential watsonAssistantCredential;

  WatsonAssistantApiV2({
    required this.watsonAssistantCredential,
  });

  Future<WatsonAssistantSessionResponse> createSession() async {
    try {
      String urlWatsonAssistant =
          "${watsonAssistantCredential.url}/assistants/${watsonAssistantCredential.assistantID}/sessions?version=${watsonAssistantCredential.version}";

      //Authentication
      //IBM Cloud is migrating to token-based Identity and Access Management (IAM) authentication.
      var authn =
          'Basic YXBpa2V5OnhQVXdBZVhnTE5oRDBBTENvSGlRMlB3QmV5OFRZNm8ydV9DSlJELWFVTTQ5';
      // var authn = 'Basic ' + base64Encode(utf8.encode(
      //     '${watsonAssistantCredential.username}:${watsonAssistantCredential.apikey}'));

      //Create a new session.
      // A session is used to send user input to a skill and receive responses.
      // It also maintains the state of the conversation.

      var newSess = await http.post(Uri.parse(urlWatsonAssistant), headers: {
        'Content-Type': 'application/json',
        'Authorization': authn
      });
      try {
        if (newSess.statusCode != 201) {
          //throw Exception('Failed to load post');
          throw Exception('post error: statusCode= ${newSess.statusCode}');
        }
      } on Exception {
        print('Failed to load post');
        print(newSess.statusCode);
      }
      //Create a new session. A session is used to send user input to a skill and receive responses. It also maintains the state of the conversation.
      print(newSess.request?.url);
      print(newSess.body);
      var parsedJsonSession = json.decode(newSess.body);
      String sessionId = parsedJsonSession['session_id'];
      print('the session $sessionId is created');

      WatsonAssistantSessionResponse watsonAssistantResult =
          WatsonAssistantSessionResponse.fromJson(parsedJsonSession);
      return watsonAssistantResult;
    } catch (error) {
      print(error);
      return WatsonAssistantSessionResponse.empty();
    }
  }

  Future<WatsonAssistantResponse> sendMessage(
      String textInput, String sessionId) async {
    try {
      var authn =
          'Basic YXBpa2V5OnhQVXdBZVhnTE5oRDBBTENvSGlRMlB3QmV5OFRZNm8ydV9DSlJELWFVTTQ5';

      var body = json.encode(
        WatsonRequest.WatsonAssistantRequest(
          input: WatsonRequest.Input(text: textInput),
        ),
      );

      var receivedText = await http.post(
        Uri.parse(
            "${watsonAssistantCredential.url}/assistants/${watsonAssistantCredential.assistantID}/sessions/$sessionId/message?version=${watsonAssistantCredential.version}"),
        headers: {'Content-Type': 'application/json', 'Authorization': authn},
        body: body,
      );

      print(
          'Url: ${receivedText.request!.url} :${receivedText.statusCode}:${receivedText.body}');
      print('Request: $body');

      var parsedJson = json.decode(receivedText.body);

      print('this is result : $parsedJson');

      WatsonAssistantResponse watsonAssistantResult =
          WatsonAssistantResponse.fromJson(parsedJson);
      return watsonAssistantResult;
    } catch (error) {
      print(error);
      return WatsonAssistantResponse.empty();
    }
  }
}
