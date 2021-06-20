/// session_id : "dfed4a2d-5968-42ec-b6ff-1acf7a2c43c2"

class WatsonAssistantSessionResponse {
  String? _sessionId;

  String? get sessionId => _sessionId;

  WatsonAssistantSessionResponse({
      String? sessionId}){
    _sessionId = sessionId;
}

  WatsonAssistantSessionResponse.fromJson(dynamic json) {
    _sessionId = json["session_id"];
  }

  WatsonAssistantSessionResponse.empty() {
    _sessionId = "";
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["session_id"] = _sessionId;
    return map;
  }

}