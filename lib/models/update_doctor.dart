class UpdateDoc {
  int status;
  String subMessage;
  int result;
  String message;

  UpdateDoc({this.status, this.subMessage, this.result, this.message});

UpdateDoc.fromJson(Map<String, dynamic> json) {
status = json['status'];
subMessage = json['sub_message'];
result = json['return'];
message = json['message'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['status'] = this.status;
  data['sub_message'] = this.subMessage;
  data['return'] = this.result;
  data['message'] = this.message;
  return data;
}
}
