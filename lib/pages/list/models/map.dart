class HouseDirection {
  String code;
  String codeName;
  HouseDirection({
    String code,
    String codeName,
  }) {
    this.code = code;
    this.codeName = codeName;
  }

  HouseDirection.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    codeName = json['codeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['codeName'] = this.codeName;
    return data;
  }
}

class HouseType {
  String code;
  String codeName;
  HouseType({
    String code,
    String codeName,
  }) {
    this.code = code;
    this.codeName = codeName;
  }

  HouseType.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    codeName = json['codeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['codeName'] = this.codeName;
    return data;
  }
}

class HouseTags {
  String code;
  String codeName;
  HouseTags({
    String code,
    String codeName,
  }) {
    this.code = code;
    this.codeName = codeName;
  }

  HouseTags.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    codeName = json['codeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['codeName'] = this.codeName;
    return data;
  }
}
