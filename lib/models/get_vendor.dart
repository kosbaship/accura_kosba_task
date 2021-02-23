class VendorData {
  int status;
  String subMessage;
  Return result;
  String message;

  VendorData({this.status, this.subMessage, this.result, this.message});

  VendorData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subMessage = json['sub_message'];
    result =
        json['return'] != null ? new Return.fromJson(json['return']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['sub_message'] = this.subMessage;
    if (this.result != null) {
      data['return'] = this.result.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Return {
  String vendorId;
  String vendorType;
  String receiveOrders;
  String workdaysType;
  String discount;
  List<AvailabilityList> availabilityList;
  UnavailabilityList unavailabilityList;

  Return(
      {this.vendorId,
      this.vendorType,
      this.receiveOrders,
      this.workdaysType,
      this.discount,
      this.availabilityList,
      this.unavailabilityList});

  Return.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendorId'];
    vendorType = json['vendorType'];
    receiveOrders = json['receiveOrders'];
    workdaysType = json['workdaysType'];
    discount = json['discount'];
    if (json['availabilityList'] != null) {
      availabilityList = new List<AvailabilityList>();
      json['availabilityList'].forEach((v) {
        availabilityList.add(new AvailabilityList.fromJson(v));
      });
    }
    unavailabilityList = json['unavailabilityList'] != null
        ? new UnavailabilityList.fromJson(json['unavailabilityList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendorId'] = this.vendorId;
    data['vendorType'] = this.vendorType;
    data['receiveOrders'] = this.receiveOrders;
    data['workdaysType'] = this.workdaysType;
    data['discount'] = this.discount;
    if (this.availabilityList != null) {
      data['availabilityList'] =
          this.availabilityList.map((v) => v.toJson()).toList();
    }
    if (this.unavailabilityList != null) {
      data['unavailabilityList'] = this.unavailabilityList.toJson();
    }
    return data;
  }
}

class AvailabilityList {
  String wdayId;
  String wdayAdvId;
  String wdayDayName;
  String wdayFrom;
  String wdayTo;
  String wdayFrom2;
  String wdayTo2;

  AvailabilityList(
      {this.wdayId,
      this.wdayAdvId,
      this.wdayDayName,
      this.wdayFrom,
      this.wdayTo,
      this.wdayFrom2,
      this.wdayTo2});

  AvailabilityList.fromJson(Map<String, dynamic> json) {
    wdayId = json['wday_id'];
    wdayAdvId = json['wday_adv_id'];
    wdayDayName = json['wday_day_name'];
    wdayFrom = json['wday_from'];
    wdayTo = json['wday_to'];
    wdayFrom2 = json['wday_from_2'];
    wdayTo2 = json['wday_to_2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wday_id'] = this.wdayId;
    data['wday_adv_id'] = this.wdayAdvId;
    data['wday_day_name'] = this.wdayDayName;
    data['wday_from'] = this.wdayFrom;
    data['wday_to'] = this.wdayTo;
    data['wday_from_2'] = this.wdayFrom2;
    data['wday_to_2'] = this.wdayTo2;
    return data;
  }
}

class UnavailabilityList {
  String from;
  String to;

  UnavailabilityList({this.from, this.to});

  UnavailabilityList.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}
