class PaymentMethod {
  int? id;
  String? name;
  String? key;
  String? description;

  PaymentMethod({this.id, this.name, this.key, this.description});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    key = json['key'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['key'] = this.key;
    data['description'] = this.description;
    return data;
  }
}
