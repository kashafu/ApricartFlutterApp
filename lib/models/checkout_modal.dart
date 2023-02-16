import 'package:apricart/models/home_data_model.dart';

class CheckoutModal {
  String? orderId;
  String? saleOrderId;
  bool? coupon;
  String? couponMessage;
  double? subtotal;
  double? tax;
  double? subtotalInclTax;
  double? couponDiscountAmount;
  double? otherDiscountAmount;
  double? totalDiscountAamount;
  double? shippingAmount;
  double? grandTotal;
  String? pickupMessage;
  String? shipmentMessage;
  String? address;
  String? orderType;
  String? pickupLocation;
  String? pickupTime;
  String? pickupMapLat;
  String? pickupMapLong;
  String? pickupDiscountPercent;
  String? baseCurrencyCode;
  String? paymentMessage;
  String? paymentUrl;
  List<Products>? products;
  List<PaymentInfo>? paymentInfo;
  bool? isContinue;
  String? isContinueMessage;
  String? estimatedTime;
  String? nearestWareHouse;
  String? thankyouImage;
  bool? isMinOrder;
  String? isMinOrderMessage;
  String? message;

  CheckoutModal({
    this.orderId,
    this.saleOrderId,
    this.coupon,
    this.couponMessage,
    this.subtotal,
    this.tax,
    this.subtotalInclTax,
    this.couponDiscountAmount,
    this.otherDiscountAmount,
    this.totalDiscountAamount,
    this.shippingAmount,
    this.grandTotal,
    this.pickupMessage,
    this.shipmentMessage,
    this.address,
    this.orderType,
    this.pickupLocation,
    this.pickupTime,
    this.pickupMapLat,
    this.pickupMapLong,
    this.pickupDiscountPercent,
    this.baseCurrencyCode,
    this.paymentMessage,
    this.paymentUrl,
    this.products,
    this.paymentInfo,
    this.isContinue,
    this.isContinueMessage,
    this.estimatedTime,
    this.nearestWareHouse,
    this.thankyouImage,
    this.isMinOrder,
    this.isMinOrderMessage,
    this.message,
  });

  CheckoutModal.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    saleOrderId = json['saleOrderId'];
    coupon = json['coupon'];
    couponMessage = json['couponMessage'];
    subtotal = json['subtotal'];
    tax = json['tax'];
    subtotalInclTax = json['subtotal_incl_tax'];
    couponDiscountAmount = json['couponDiscountAmount'];
    otherDiscountAmount = json['otherDiscountAmount'];
    totalDiscountAamount = json['totalDiscountAamount'];
    shippingAmount = json['shipping_amount'];
    grandTotal = json['grand_total'];
    pickupMessage = json['pickup_message'];
    shipmentMessage = json['shipment_message'];
    address = json['address'];
    orderType = json['orderType'];
    pickupLocation = json['pickup_location'];
    pickupTime = json['pickup_time'];
    pickupMapLat = json['pickup_map_lat'];
    pickupMapLong = json['pickup_map_long'];
    pickupDiscountPercent = json['pickup_discount_percent'];
    baseCurrencyCode = json['base_currency_code'];
    paymentMessage = json['paymentMessage'];
    paymentUrl = json['paymentUrl'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    if (json['paymentInfo'] != null) {
      paymentInfo = <PaymentInfo>[];
      json['paymentInfo'].forEach((v) {
        paymentInfo!.add(new PaymentInfo.fromJson(v));
      });
    }
    isContinue = json['isContinue'];
    isContinueMessage = json['isContinueMessage'];
    estimatedTime = json['estimatedTime'];
    nearestWareHouse = json['nearestWareHouse'];
    thankyouImage = json['thankyou_image'];
    isMinOrder = json["isMinOrder"];
    isMinOrderMessage = json["isMinOrderMessage"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['saleOrderId'] = this.saleOrderId;
    data['coupon'] = this.coupon;
    data['couponMessage'] = this.couponMessage;
    data['subtotal'] = this.subtotal;
    data['tax'] = this.tax;
    data['subtotal_incl_tax'] = this.subtotalInclTax;
    data['couponDiscountAmount'] = this.couponDiscountAmount;
    data['otherDiscountAmount'] = this.otherDiscountAmount;
    data['totalDiscountAamount'] = this.totalDiscountAamount;
    data['shipping_amount'] = this.shippingAmount;
    data['grand_total'] = this.grandTotal;
    data['pickup_message'] = this.pickupMessage;
    data['shipment_message'] = this.shipmentMessage;
    data['address'] = this.address;
    data['orderType'] = this.orderType;
    data['pickup_location'] = this.pickupLocation;
    data['pickup_time'] = this.pickupTime;
    data['pickup_map_lat'] = this.pickupMapLat;
    data['pickup_map_long'] = this.pickupMapLong;
    data['pickup_discount_percent'] = this.pickupDiscountPercent;
    data['base_currency_code'] = this.baseCurrencyCode;
    data['paymentMessage'] = this.paymentMessage;
    data['paymentUrl'] = this.paymentUrl;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.paymentInfo != null) {
      data['paymentInfo'] = this.paymentInfo!.map((v) => v.toJson()).toList();
    }
    data['isContinue'] = this.isContinue;
    data['isContinueMessage'] = this.isContinueMessage;
    data['estimatedTime'] = this.estimatedTime;
    data['nearestWareHouse'] = this.nearestWareHouse;
    data['thankyou_image'] = this.thankyouImage;
    data['isMinOrder'] = this.isMinOrder;
    data['isMinOrderMessage'] = this.isMinOrderMessage;
    return data;
  }
}

class PaymentInfo {
  int? id;
  String? name;
  String? key;
  String? description;

  PaymentInfo({this.id, this.name, this.key, this.description});

  PaymentInfo.fromJson(Map<String, dynamic> json) {
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
