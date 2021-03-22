class DoctorData {
  int status;
  String subMessage;
  Return result;
  String message;

  DoctorData({this.status, this.subMessage, this.result, this.message});

  DoctorData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subMessage = json['sub_message'];
    result = json['return'] != null ? new Return.fromJson(json['return']) : null;
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
  List<AvailabilityList> availabilityList;

  Return({this.vendorId, this.vendorType, this.availabilityList});

  Return.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendorId'];
    vendorType = json['vendorType'];
    if (json['availabilityList'] != null) {
      availabilityList =  <AvailabilityList>[];
      json['availabilityList'].forEach((v) {
        availabilityList.add(new AvailabilityList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendorId'] = this.vendorId;
    data['vendorType'] = this.vendorType;
    if (this.availabilityList != null) {
      data['availabilityList'] =
          this.availabilityList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvailabilityList {
  String vendorAppointType;
  int isActive;
  String priceValue;
  List<AvailabilityTimeList> availabilityTimeList;

  AvailabilityList(
      {this.vendorAppointType,
      this.isActive,
      this.priceValue,
      this.availabilityTimeList});

  AvailabilityList.fromJson(Map<String, dynamic> json) {
    vendorAppointType = json['vendorAppointType'];
    isActive = json['isActive'];
    priceValue = json['priceValue'];
    if (json['availabilityTimeList'] != null) {
      availabilityTimeList = <AvailabilityTimeList>[];
      json['availabilityTimeList'].forEach((v) {
        availabilityTimeList.add(new AvailabilityTimeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendorAppointType'] = this.vendorAppointType;
    data['isActive'] = this.isActive;
    data['priceValue'] = this.priceValue;
    if (this.availabilityTimeList != null) {
      data['availabilityTimeList'] =
          this.availabilityTimeList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvailabilityTimeList {
  String wdayDayName;
  String wdayFrom;
  String wdayTo;
  String wdayFrom2;
  String wdayTo2;

  AvailabilityTimeList(
      {this.wdayDayName,
      this.wdayFrom,
      this.wdayTo,
      this.wdayFrom2,
      this.wdayTo2});

  AvailabilityTimeList.fromJson(Map<String, dynamic> json) {
    wdayDayName = json['wday_day_name'];
    wdayFrom = json['wday_from'];
    wdayTo = json['wday_to'];
    wdayFrom2 = json['wday_from_2'];
    wdayTo2 = json['wday_to_2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wday_day_name'] = this.wdayDayName;
    data['wday_from'] = this.wdayFrom;
    data['wday_to'] = this.wdayTo;
    data['wday_from_2'] = this.wdayFrom2;
    data['wday_to_2'] = this.wdayTo2;
    return data;
  }
}
