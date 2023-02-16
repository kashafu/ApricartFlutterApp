import 'package:apricart/models/home_data_model.dart';

class OrderHistory {
  List<OrderHistoryItem>? pending;
  List<OrderHistoryItem>? completed;
  List<OrderHistoryItem>? cancelled;

  OrderHistory({this.pending, this.completed, this.cancelled});

  OrderHistory.fromJson(Map<String, dynamic> json) {
    if (json['pending'] != null) {
      pending = <OrderHistoryItem>[];
      json['pending'].forEach((v) {
        pending!.add(new OrderHistoryItem.fromJson(v));
      });
    }
    if (json['completed'] != null) {
      completed = <OrderHistoryItem>[];
      json['completed'].forEach((v) {
        completed!.add(new OrderHistoryItem.fromJson(v));
      });
    }
    if (json['cancelled'] != null) {
      cancelled = <OrderHistoryItem>[];
      json['cancelled'].forEach((v) {
        cancelled!.add(new OrderHistoryItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pending != null) {
      data['pending'] = this.pending!.map((v) => v.toJson()).toList();
    }
    if (this.completed != null) {
      data['completed'] = this.completed!.map((v) => v.toJson()).toList();
    }
    if (this.cancelled != null) {
      data['cancelled'] = this.cancelled!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderHistoryItem {
  String? orderId;
  String? displayOrderId;
  String? guestUserId;
  String? bankOrderId;
  String? saleOrderId;
  String? couponsUsed;
  String? orderType;
  String? prodType;
  String? pickupLocation;
  String? pickuStartTime;
  String? pickuEndTime;
  double? subtotal;
  double? tax;
  double? couponDiscountAmount;
  String? pickupDiscountPercent;
  double? otherDiscountAmount;
  String? shippingMethod;
  double? shippingAmount;
  double? grandTotal;
  String? baseCurrencyCode;
  String? addressSubArea;
  String? addressUsed;
  String? mapLat;
  String? mapLong;
  String? city;
  double? distanceFromWarehouse;
  String? notes;
  String? paymentMethod;
  String? paymentStatus;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? productSkus;
  int? productCount;
  List<Products>? products;
  double? totalDiscountAmount;
  String? fromWarehouse;

  OrderHistoryItem(
      {this.orderId,
      this.displayOrderId,
      this.guestUserId,
      this.bankOrderId,
      this.saleOrderId,
      this.couponsUsed,
      this.orderType,
      this.prodType,
      this.pickupLocation,
      this.pickuStartTime,
      this.pickuEndTime,
      this.subtotal,
      this.tax,
      this.couponDiscountAmount,
      this.pickupDiscountPercent,
      this.otherDiscountAmount,
      this.shippingMethod,
      this.shippingAmount,
      this.grandTotal,
      this.baseCurrencyCode,
      this.addressSubArea,
      this.addressUsed,
      this.mapLat,
      this.mapLong,
      this.city,
      this.distanceFromWarehouse,
      this.notes,
      this.paymentMethod,
      this.paymentStatus,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.productSkus,
      this.productCount,
      this.products,
      this.totalDiscountAmount,
      this.fromWarehouse});

  OrderHistoryItem.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    displayOrderId = json['displayOrderId'];
    guestUserId = json['guestUserId'];
    bankOrderId = json['bankOrderId'];
    saleOrderId = json['saleOrderId'];
    couponsUsed = json['couponsUsed'];
    orderType = json['orderType'];
    prodType = json['prodType'];
    pickupLocation = json['pickupLocation'];
    pickuStartTime = json['pickuStartTime'];
    pickuEndTime = json['pickuEndTime'];
    subtotal = json['subtotal'];
    tax = json['tax'];
    couponDiscountAmount = json['couponDiscountAmount'];
    pickupDiscountPercent = json['pickupDiscountPercent'];
    otherDiscountAmount = json['otherDiscountAmount'];
    shippingMethod = json['shippingMethod'];
    shippingAmount = json['shippingAmount'];
    grandTotal = json['grandTotal'];
    baseCurrencyCode = json['baseCurrencyCode'];
    addressSubArea = json['addressSubArea'];
    addressUsed = json['addressUsed'];
    mapLat = json['mapLat'];
    mapLong = json['mapLong'];
    city = json['city'];
    distanceFromWarehouse = json['distanceFromWarehouse'];
    notes = json['notes'];
    paymentMethod = json['paymentMethod'];
    paymentStatus = json['paymentStatus'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productSkus = json['productSkus'];
    productCount = json['productCount'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    totalDiscountAmount = json['totalDiscountAmount'];
    fromWarehouse = json['fromWarehouse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['displayOrderId'] = this.displayOrderId;
    data['guestUserId'] = this.guestUserId;
    data['bankOrderId'] = this.bankOrderId;
    data['saleOrderId'] = this.saleOrderId;
    data['couponsUsed'] = this.couponsUsed;
    data['orderType'] = this.orderType;
    data['prodType'] = this.prodType;
    data['pickupLocation'] = this.pickupLocation;
    data['pickuStartTime'] = this.pickuStartTime;
    data['pickuEndTime'] = this.pickuEndTime;
    data['subtotal'] = this.subtotal;
    data['tax'] = this.tax;
    data['couponDiscountAmount'] = this.couponDiscountAmount;
    data['pickupDiscountPercent'] = this.pickupDiscountPercent;
    data['otherDiscountAmount'] = this.otherDiscountAmount;
    data['shippingMethod'] = this.shippingMethod;
    data['shippingAmount'] = this.shippingAmount;
    data['grandTotal'] = this.grandTotal;
    data['baseCurrencyCode'] = this.baseCurrencyCode;
    data['addressSubArea'] = this.addressSubArea;
    data['addressUsed'] = this.addressUsed;
    data['mapLat'] = this.mapLat;
    data['mapLong'] = this.mapLong;
    data['city'] = this.city;
    data['distanceFromWarehouse'] = this.distanceFromWarehouse;
    data['notes'] = this.notes;
    data['paymentMethod'] = this.paymentMethod;
    data['paymentStatus'] = this.paymentStatus;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['productSkus'] = this.productSkus;
    data['productCount'] = this.productCount;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['totalDiscountAmount'] = this.totalDiscountAmount;
    data['fromWarehouse'] = this.fromWarehouse;
    return data;
  }
}
