class WatsonAssistantResponse {
  Output? _output;
  String? _userId;

  Output? get output => _output;

  String? get userId => _userId;

  WatsonAssistantResponse({Output? output, String? userId}) {
    _output = output;
    _userId = userId;
  }

  WatsonAssistantResponse.fromJson(dynamic json) {
    _output = json["output"] != null ? Output.fromJson(json["output"]) : null;
    _userId = json["user_id"];
  }

  WatsonAssistantResponse.empty() {
    _userId = "";
    _output = Output.empty();
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_output != null) {
      map["output"] = _output?.toJson();
    }
    map["user_id"] = _userId;
    return map;
  }
}

class Output {
  List<Intents>? _intents;
  List<Entities>? _entities;
  List<Generic>? _generic;

  List<Intents>? get intents => _intents;

  List<Entities>? get entities => _entities;

  List<Generic>? get generic => _generic;

  Output(
      {List<Intents>? intents,
      List<Entities>? entities,
      List<Generic>? generic}) {
    _intents = intents;
    _entities = entities;
    _generic = generic;
  }

  Output.fromJson(dynamic json) {
    if (json["intents"] != null) {
      _intents = [];
      json["intents"].forEach((v) {
        _intents?.add(Intents.fromJson(v));
      });
    }
    if (json["entities"] != null) {
      _entities = [];
      json["entities"].forEach((v) {
        _entities?.add(Entities.fromJson(v));
      });
    }
    if (json["generic"] != null) {
      _generic = [];
      json["generic"].forEach((v) {
        _generic?.add(Generic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_intents != null) {
      map["intents"] = _intents?.map((v) => v.toJson()).toList();
    }
    if (_entities != null) {
      map["entities"] = _entities?.map((v) => v.toJson()).toList();
    }
    if (_generic != null) {
      map["generic"] = _generic?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  Output.empty() {
    _intents = null;
    _entities = null;
    _generic = null;
  }
}

class Generic {
  String? _text;
  String? _title;
  List<Options>? _options;
  String? _responseType;

  String? get title => _title;

  String? get text => _text;

  List<Options>? get options => _options;

  String? get responseType => _responseType;

  Generic({String? text, String? title, List<Options>? options, String? responseType}) {
    _title = title;
    _text = text;
    _options = options;
    _responseType = responseType;
  }

  Generic.fromJson(dynamic json) {
    _title = json["title"];
    _text = json["text"];
    if (json["options"] != null) {
      _options = [];
      json["options"].forEach((v) {
        _options?.add(Options.fromJson(v));
      });
    }
    _responseType = json["response_type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    map["text"] = _text;
    if (_options != null) {
      map["options"] = _options?.map((v) => v.toJson()).toList();
    }
    map["response_type"] = _responseType;
    return map;
  }
}

/// label : "نعم"
/// value : {"input":{"text":"بكل تأكيد"}}

class Options {
  String? _label;
  Value? _value;

  String? get label => _label;

  Value? get value => _value;

  Options({String? label, Value? value}) {
    _label = label;
    _value = value;
  }

  Options.fromJson(dynamic json) {
    _label = json["label"];
    _value = json["value"] != null ? Value.fromJson(json["value"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["label"] = _label;
    if (_value != null) {
      map["value"] = _value?.toJson();
    }
    return map;
  }
}

/// input : {"text":"بكل تأكيد"}

class Value {
  Input? _input;

  Input? get input => _input;

  Value({Input? input}) {
    _input = input;
  }

  Value.fromJson(dynamic json) {
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

/// text : "بكل تأكيد"

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
}

/// entity : "sys-number"
/// location : [3,5]
/// value : "6"
/// confidence : 1
/// metadata : {"numeric_value":6}
/// interpretation : {"numeric_value":6,"subtype":"integer"}

class Entities {
  String? _entity;
  List<int>? _location;
  String? _value;
  int? _confidence;
  Metadata? _metadata;
  Interpretation? _interpretation;

  String? get entity => _entity;

  List<int>? get location => _location;

  String? get value => _value;

  int? get confidence => _confidence;

  Metadata? get metadata => _metadata;

  Interpretation? get interpretation => _interpretation;

  Entities(
      {String? entity,
      List<int>? location,
      String? value,
      int? confidence,
      Metadata? metadata,
      Interpretation? interpretation}) {
    _entity = entity;
    _location = location;
    _value = value;
    _confidence = confidence;
    _metadata = metadata;
    _interpretation = interpretation;
  }

  Entities.fromJson(dynamic json) {
    _entity = json["entity"];
    _location = json["location"] != null ? json["location"].cast<int>() : [];
    _value = json["value"];
    _confidence = json["confidence"];
    _metadata =
        json["metadata"] != null ? Metadata.fromJson(json["metadata"]) : null;
    _interpretation = json["interpretation"] != null
        ? Interpretation.fromJson(json["interpretation"])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["entity"] = _entity;
    map["location"] = _location;
    map["value"] = _value;
    map["confidence"] = _confidence;
    if (_metadata != null) {
      map["metadata"] = _metadata?.toJson();
    }
    if (_interpretation != null) {
      map["interpretation"] = _interpretation?.toJson();
    }
    return map;
  }
}

/// numeric_value : 6
/// subtype : "integer"

class Interpretation {
  int? _numericValue;
  String? _subtype;

  int? get numericValue => _numericValue;

  String? get subtype => _subtype;

  Interpretation({int? numericValue, String? subtype}) {
    _numericValue = numericValue;
    _subtype = subtype;
  }

  Interpretation.fromJson(dynamic json) {
    _numericValue = json["numeric_value"];
    _subtype = json["subtype"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["numeric_value"] = _numericValue;
    map["subtype"] = _subtype;
    return map;
  }
}

/// numeric_value : 6

class Metadata {
  int? _numericValue;

  int? get numericValue => _numericValue;

  Metadata({int? numericValue}) {
    _numericValue = numericValue;
  }

  Metadata.fromJson(dynamic json) {
    _numericValue = json["numeric_value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["numeric_value"] = _numericValue;
    return map;
  }
}

/// intent : "DED_Trade_Name_Inquiry"
/// confidence : 0.8083703994750977

class Intents {
  String? _intent;
  double? _confidence;

  String? get intent => _intent;

  double? get confidence => _confidence;

  Intents({String? intent, double? confidence}) {
    _intent = intent;
    _confidence = confidence;
  }

  Intents.fromJson(dynamic json) {
    _intent = json["intent"];
    _confidence = json["confidence"].toDouble();
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["intent"] = _intent;
    map["confidence"] = _confidence;
    return map;
  }
}
