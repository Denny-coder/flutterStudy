class ProductList {
  String managerCode;
  String bannerUrl;
  String houseName;
  String nowPrice;
  String sellPrice;
  String houseType;
  String floorArea;
  String driection;
  String village;
  ProductList();

  factory ProductList.fromJson(Map<String, dynamic> response) {
    ProductList rowData = ProductList();
    rowData.managerCode = response['managerCode']; // 工号
    rowData.houseName = response['houseName']; // 房屋名称
    rowData.bannerUrl = response['bannerUrl']; // 封面
    rowData.nowPrice = response['nowPrice']; // 现价
    rowData.sellPrice = response['sellPrice']; // 成交价
    rowData.houseType = response['houseType']; // 房型
    rowData.floorArea = response['floorArea']; // 面积
    rowData.driection = response['driection']; // 朝向
    rowData.village = response['village']; // 小区
    return rowData;
  }
}