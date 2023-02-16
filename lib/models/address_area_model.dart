class AddressArea {
  int? id;
  int? cityId;
  int? state;
  String? town;
  Null? uc;

  AddressArea({this.id, this.cityId, this.state, this.town, this.uc});

  AddressArea.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['cityId'];
    state = json['state'];
    town = json['town'];
    uc = json['uc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cityId'] = this.cityId;
    data['state'] = this.state;
    data['town'] = this.town;
    data['uc'] = this.uc;
    return data;
  }
}
