import 'package:flutter_app/model/WatsonAssistant/watson_assistant_message_response.dart';
import 'package:flutter_app/model/WatsonAssistant/watson_assistant_session_response.dart';
import 'package:flutter_app/resources/watson_repository/watson_api.dart';

class WatsonAssistantRepository {
  final watsonProvider = WatsonAssistantApiV2(
      watsonAssistantCredential: WatsonAssistantV2Credential(
          apikey: "xPUwAeXgLNhD0ALCoHiQ2PwBey8TY6o2u_CJRD",
          assistantID: "19ecc32c-01dd-45d1-9a41-07659fe6b870",
          url:
              "https://api.eu-gb.assistant.watson.cloud.ibm.com/instances/2c0adcd6-7937-4827-a1bd-461b9a083760/v2"));

  Future<WatsonAssistantResponse> sendMessage(textInput, sessionId) =>
      watsonProvider.sendMessage(textInput, sessionId);

  Future<WatsonAssistantSessionResponse> createSession() =>
      watsonProvider.createSession();
}
