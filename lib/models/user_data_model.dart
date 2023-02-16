class UserData {
  String? token;
  int? userId;
  String? name;
  String? phoneNumber;
  String? email;
  int? cartCount;
  bool? portal;
  bool? agent;

  UserData({this.token, this.userId, this.name, this.phoneNumber, this.email, this.cartCount, this.portal, this.agent});

  UserData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['userId'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    cartCount = json['cartCount'];
    portal = json['portal'];
    agent = json['agent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['cartCount'] = this.cartCount;
    data['portal'] = this.portal;
    data['agent'] = this.agent;
    return data;
  }
}
