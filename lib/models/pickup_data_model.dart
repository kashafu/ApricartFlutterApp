class PickupData {
  List<AvailableDates>? availableDates;
  List<PickLocationDtoList>? pickLocationDtoList;

  PickupData({this.availableDates, this.pickLocationDtoList});

  PickupData.fromJson(Map<String, dynamic> json) {
    if (json['availableDates'] != null) {
      availableDates = <AvailableDates>[];
      json['availableDates'].forEach((v) {
        availableDates!.add(new AvailableDates.fromJson(v));
      });
    }
    if (json['pickLocationDtoList'] != null) {
      pickLocationDtoList = <PickLocationDtoList>[];
      json['pickLocationDtoList'].forEach((v) {
        pickLocationDtoList!.add(new PickLocationDtoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.availableDates != null) {
      data['availableDates'] = this.availableDates!.map((v) => v.toJson()).toList();
    }
    if (this.pickLocationDtoList != null) {
      data['pickLocationDtoList'] = this.pickLocationDtoList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvailableDates {
  String? identifier;
  String? displayDate;
  String? dateForServer;

  AvailableDates({this.identifier, this.displayDate, this.dateForServer});

  AvailableDates.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    displayDate = json['displayDate'];
    dateForServer = json['dateForServer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['displayDate'] = this.displayDate;
    data['dateForServer'] = this.dateForServer;
    return data;
  }
}

class PickLocationDtoList {
  int? id;
  String? name;
  String? address;
  int? areaId;
  String? mapLat;
  String? mapLong;
  String? description;
  List<DayTimings>? timingsFirstDay;
  List<DayTimings>? timingsSecondDay;

  PickLocationDtoList(
      {this.id,
      this.name,
      this.address,
      this.areaId,
      this.mapLat,
      this.mapLong,
      this.description,
      this.timingsFirstDay,
      this.timingsSecondDay});

  PickLocationDtoList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    areaId = json['areaId'];
    mapLat = json['mapLat'];
    mapLong = json['mapLong'];
    description = json['description'];
    if (json['timingsFirstDay'] != null) {
      timingsFirstDay = <DayTimings>[];
      json['timingsFirstDay'].forEach((v) {
        timingsFirstDay!.add(new DayTimings.fromJson(v));
      });
    }
    if (json['timingsSecondDay'] != null) {
      timingsSecondDay = <DayTimings>[];
      json['timingsSecondDay'].forEach((v) {
        timingsSecondDay!.add(new DayTimings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['areaId'] = this.areaId;
    data['mapLat'] = this.mapLat;
    data['mapLong'] = this.mapLong;
    data['description'] = this.description;
    if (this.timingsFirstDay != null) {
      data['timingsFirstDay'] = this.timingsFirstDay!.map((v) => v.toJson()).toList();
    }
    if (this.timingsSecondDay != null) {
      data['timingsSecondDay'] = this.timingsSecondDay!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DayTimings {
  String? displayTime;
  String? startTime;
  String? endTime;

  DayTimings({this.displayTime, this.startTime, this.endTime});

  DayTimings.fromJson(Map<String, dynamic> json) {
    displayTime = json['displayTime'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayTime'] = this.displayTime;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    return data;
  }
}
