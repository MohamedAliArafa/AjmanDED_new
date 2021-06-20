class WatsonAssistantRequest {
  Input? _input;

  Input? get input => _input;

  WatsonAssistantRequest({Input? input}) {
    _input = input;
  }

  WatsonAssistantRequest.empty() {
    _input = Input.empty();
  }

  WatsonAssistantRequest.fromJson(dynamic json) {
    _input = json["input"] != null ? Input.fromJson(json["input"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_input != null) {
      map["input"] = _input?.toJson();
    }
    return map;
  }
}

class Input {
  String? _text;

  String? get text => _text;

  Input({String? text}) {
    _text = text;
  }

  Input.fromJson(dynamic json) {
    _text = json["text"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["text"] = _text;
    return map;
  }

  Input.empty() {
    _text = "";
  }
}
