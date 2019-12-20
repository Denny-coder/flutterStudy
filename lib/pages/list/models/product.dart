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
  int interestCount;
  String processStatus;
  List<String> tags;
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
    rowData.processStatus = response['processStatus']; // 99为已售出
    rowData.interestCount = response['interestCount']; // 浏览人数
    rowData.tags = response['tags'] == null || response['tags'] == ''
        ? List()
        : response['tags'].split(','); // 标签
    return rowData;
  }
}
