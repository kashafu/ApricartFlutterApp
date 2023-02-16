class Address {
  int? id;
  int? userId;
  String? name;
  String? phoneNumber;
  String? email;
  String? mapLat;
  String? mapLong;
  String? address;
  String? googleAddress;
  int? areaId;
  String? area;
  int? cityId;
  String? city;

  Address(
      {this.id,
      this.userId,
      this.name,
      this.phoneNumber,
      this.email,
      this.mapLat,
      this.mapLong,
      this.address,
      this.googleAddress,
      this.areaId,
      this.area,
      this.cityId,
      this.city});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    mapLat = json['mapLat'];
    mapLong = json['mapLong'];
    address = json['address'];
    googleAddress = json['googleAddress'];
    areaId = json['areaId'];
    area = json['area'];
    cityId = json['cityId'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['mapLat'] = this.mapLat;
    data['mapLong'] = this.mapLong;
    data['address'] = this.address;
    data['googleAddress'] = this.googleAddress;
    data['areaId'] = this.areaId;
    data['area'] = this.area;
    data['cityId'] = this.cityId;
    data['city'] = this.city;
    return data;
  }
}
