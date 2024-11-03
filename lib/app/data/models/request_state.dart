class RequestState {
  String? orderNumber;
  String? orderType;
  String? orderFromDate;
  String? orderToDate;
  String? orderStatus;

  RequestState({this.orderNumber,
    this.orderType,
    this.orderFromDate,
    this.orderToDate,
    this.orderStatus});

  RequestState.fromJson(Map<String, dynamic> json) {
    orderNumber = json['orderNumber'];
    orderType = json['orderType'];
    orderFromDate = json['orderFromDate'];
    orderToDate = json['orderToDate'];
    orderStatus = json['orderStatus'];
  }
}