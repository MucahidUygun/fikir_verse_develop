class RegisterUserControl {
  String? idEncrypted;
  bool? status;
  String? id;
  Error? error;
  String? fullName;

  RegisterUserControl({this.status, this.error});

  RegisterUserControl.fromJson(Map<String, dynamic> json) {
    idEncrypted=json['id_encrypted'];
    id = json['id'];
    fullName = json['fullname'];
    status = json['status'];
    error = json['error'] != null ?  Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    if (error != null) {
      data['error'] = error!.toJson();
    }
    return data;
  }
}

class Error {
  String? title;
  String? type;
  String? message;

  Error({this.title, this.type, this.message});

  Error.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['title'] = title;
    data['type'] = type;
    data['message'] = message;
    return data;
  }
}