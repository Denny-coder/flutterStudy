// 装修
class InfoData {
  int id;
  String type;
  String depId;
  String sellPrice;
  String houseType;
  String houseName;
  String floorArea;
  String unitPrice;
  String hangTime;
  String driection;
  Null houseModel;
  String fitUp;
  String floor;
  String allFloor;
  String years;
  String houseUse;
  Null transaction;
  String village;
  dynamic areaInside;
  String allAge;
  String banner;
  Null bannerUrl;
  String imgIds;
  String processStatus;
  String placeName;
  String address;
  String lonLat;
  String debtInfo;
  String nowPrice;

  InfoData(
    this.id,
    this.type,
    this.depId,
    this.sellPrice,
    this.houseType,
    this.houseName,
    this.floorArea,
    this.unitPrice,
    this.hangTime,
    this.driection,
    this.houseModel,
    this.fitUp,
    this.floor,
    this.allFloor,
    this.years,
    this.houseUse,
    this.transaction,
    this.village,
    this.areaInside,
    this.allAge,
    this.banner,
    this.bannerUrl,
    this.imgIds,
    this.processStatus,
    this.placeName,
    this.address,
    this.lonLat,
    this.debtInfo,
    this.nowPrice,
  );
  InfoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    depId = json['depId'];
    houseName = json['houseName'];
    sellPrice = json['sellPrice'];
    houseType = json['houseType'];
    floorArea = json['floorArea'];
    unitPrice = json['unitPrice'];
    hangTime = json['hangTime'];
    driection = json['driection'];
    houseModel = json['houseModel'];
    fitUp = json['fitUp'];
    floor = json['floor'];
    allFloor = json['allFloor'];
    years = json['years'];
    houseUse = json['houseUse'];
    transaction = json['transaction'];
    village = json['village'];
    areaInside = json['areaInside'];
    allAge = json['allAge'];
    banner = json['banner'];
    bannerUrl = json['bannerUrl'];
    imgIds = json['imgIds'];
    processStatus = json['processStatus'];
    placeName = json['placeName'];
    address = json['address'];
    lonLat = json['lonLat'];
    debtInfo = json['debtInfo'];
    nowPrice = json['nowPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['depId'] = this.depId;
    data['houseName'] = this.houseName;
    data['sellPrice'] = this.sellPrice;
    data['houseType'] = this.houseType;
    data['floorArea'] = this.floorArea;
    data['unitPrice'] = this.unitPrice;
    data['hangTime'] = this.hangTime;
    data['driection'] = this.driection;
    data['houseModel'] = this.houseModel;
    data['fitUp'] = this.fitUp;
    data['floor'] = this.floor;
    data['allFloor'] = this.allFloor;
    data['years'] = this.years;
    data['houseUse'] = this.houseUse;
    data['transaction'] = this.transaction;
    data['village'] = this.village;
    data['areaInside'] = this.areaInside;
    data['allAge'] = this.allAge;
    data['banner'] = this.banner;
    data['bannerUrl'] = this.bannerUrl;
    data['imgIds'] = this.imgIds;
    data['processStatus'] = this.processStatus;
    data['placeName'] = this.placeName;
    data['address'] = this.address;
    data['lonLat'] = this.lonLat;
    data['debtInfo'] = this.debtInfo;
    data['nowPrice'] = this.nowPrice;
    return data;
  }
}

// 购置流程
class HouseBuyStatus {
  String id;
  String code;
  String codeName;
  HouseBuyStatus({
    this.id,
    this.code,
    this.codeName,
  });
  HouseBuyStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    codeName = json['codeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['codeName'] = this.codeName;

    return data;
  }
}

// 坐标
class AmapLatLng {
  String status;
  String info;
  String infocode;
  String locations;

  AmapLatLng({this.status, this.info, this.infocode, this.locations});

  AmapLatLng.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    info = json['info'];
    infocode = json['infocode'];
    locations = json['locations'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['info'] = this.info;
    data['infocode'] = this.infocode;
    data['locations'] = this.locations;
    return data;
  }
}
