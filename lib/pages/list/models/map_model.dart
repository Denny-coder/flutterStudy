// 朝向
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

// 户型
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

// 标签
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

// 用途
class HouseUse {
  String code;
  String codeName;
  HouseUse({
    String code,
    String codeName,
  }) {
    this.code = code;
    this.codeName = codeName;
  }

  HouseUse.fromJson(Map<String, dynamic> json) {
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

// 楼层
class HouseFloor {
  String code;
  String codeName;
  HouseFloor({
    String code,
    String codeName,
  }) {
    this.code = code;
    this.codeName = codeName;
  }

  HouseFloor.fromJson(Map<String, dynamic> json) {
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
// 装修
class HouseFitUp {
  String code;
  String codeName;
  HouseFitUp({
    String code,
    String codeName,
  }) {
    this.code = code;
    this.codeName = codeName;
  }

  HouseFitUp.fromJson(Map<String, dynamic> json) {
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
