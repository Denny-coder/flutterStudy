import 'dart:convert';

class RowData {
  String fullname;
  RowData();

  factory RowData.fromJson(Map<String, dynamic> response) {
    RowData rowData = RowData();
    rowData.fullname = response['fullname'];
    return rowData;
  }
}
