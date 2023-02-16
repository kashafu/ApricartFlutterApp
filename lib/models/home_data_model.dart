class HomeData {
  String? server;
  int? cartCount;
  String? ticker;
  bool? dialog;
  String? dialogImageUrl;
  String? dialogImageLandscapeUrl;
  dynamic dialogHtml;
  String? dialogType;
  String? dialogValue;
  String? estimatedTime;
  String? nearestWareHouse;
  bool? agent;
  List<Banners>? banners;
  List<Categories>? categories;
  List<Null>? offers;
  List<Null>? webProducts;
  List<HomeProducts>? products;

  HomeData(
      {this.server,
      this.cartCount,
      this.ticker,
      this.dialog,
      this.dialogImageUrl,
      this.dialogImageLandscapeUrl,
      this.dialogHtml,
      this.dialogType,
      this.dialogValue,
      this.estimatedTime,
      this.nearestWareHouse,
      this.agent,
      this.banners,
      this.categories,
      this.offers,
      this.webProducts,
      this.products});

  HomeData.fromJson(Map<String, dynamic> json) {
    server = json['server'];
    cartCount = json['cartCount'];
    ticker = json['ticker'];
    dialog = json['dialog'];
    dialogImageUrl = json['dialogImageUrl'];
    dialogImageLandscapeUrl = json['dialogImageLandscapeUrl'];
    dialogHtml = json['dialogHtml'];
    dialogType = json['dialogType'];
    dialogValue = json['dialogValue'];
    estimatedTime = json['estimatedTime'];
    nearestWareHouse = json['nearestWareHouse'];
    agent = json['agent'];
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['offers'] != null) {
      offers = <Null>[];
      // json['offers'].forEach((v) {
      //   offers!.add(new Null.fromJson(v));
      // });
    }
    if (json['webProducts'] != null) {
      webProducts = <Null>[];
      // json['webProducts'].forEach((v) {
      //   webProducts!.add(new Null.fromJson(v));
      // });
    }
    if (json['products'] != null) {
      products = <HomeProducts>[];
      json['products'].forEach((v) {
        products!.add(new HomeProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['server'] = this.server;
    data['cartCount'] = this.cartCount;
    data['ticker'] = this.ticker;
    data['dialog'] = this.dialog;
    data['dialogImageUrl'] = this.dialogImageUrl;
    data['dialogImageLandscapeUrl'] = this.dialogImageLandscapeUrl;
    data['dialogHtml'] = this.dialogHtml;
    data['dialogType'] = this.dialogType;
    data['dialogValue'] = this.dialogValue;
    data['estimatedTime'] = this.estimatedTime;
    data['nearestWareHouse'] = this.nearestWareHouse;
    data['agent'] = this.agent;
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.offers != null) {
      // data['offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    if (this.webProducts != null) {
      // data['webProducts'] = this.webProducts!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  int? id;
  List<String>? bannerUrlApp;
  List<String>? bannerUrlWeb;
  String? offerType;
  int? offerId;
  Offer? offer;
  String? level;
  int? position;

  Banners(
      {this.id,
      this.bannerUrlApp,
      this.bannerUrlWeb,
      this.offerType,
      this.offerId,
      this.offer,
      this.level,
      this.position});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerUrlApp = json['bannerUrlApp'].cast<String>();
    bannerUrlWeb = json['bannerUrlWeb'].cast<String>();
    offerType = json['offerType'];
    offerId = json['offerId'];
    offer = json['offer'] != null ? new Offer.fromJson(json['offer']) : null;
    level = json['level'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bannerUrlApp'] = this.bannerUrlApp;
    data['bannerUrlWeb'] = this.bannerUrlWeb;
    data['offerType'] = this.offerType;
    data['offerId'] = this.offerId;
    if (this.offer != null) {
      data['offer'] = this.offer!.toJson();
    }
    data['level'] = this.level;
    data['position'] = this.position;
    return data;
  }
}

class Offer {
  int? id;
  String? expiry;
  double? price;
  String? buying;
  List<Null>? products;
  String? productSKUs;
  String? categories;

  Offer({this.id, this.expiry, this.price, this.buying, this.products, this.productSKUs, this.categories});

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expiry = json['expiry'];
    price = json['price'];
    buying = json['buying'];
    if (json['products'] != null) {
      products = <Null>[];
      // json['products'].forEach((v) {
      //   products!.add(new Null.fromJson(v));
      // });
    }
    productSKUs = json['productSKUs'];
    categories = json['categories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expiry'] = this.expiry;
    data['price'] = this.price;
    data['buying'] = this.buying;
    if (this.products != null) {
      // data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['productSKUs'] = this.productSKUs;
    data['categories'] = this.categories;
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? parent;
  String? image;
  String? bannerUrlApp;
  String? bannerUrlWeb;
  bool? isActive;
  int? position;
  int? level;
  int? productCount;
  int? childrenCount;
  List<Categories>? childrenData;

  Categories(
      {this.id,
      this.name,
      this.parent,
      this.image,
      this.bannerUrlApp,
      this.bannerUrlWeb,
      this.isActive,
      this.position,
      this.level,
      this.productCount,
      this.childrenCount,
      this.childrenData});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parent = json['parent'];
    image = json['image'];
    bannerUrlApp = json['bannerUrlApp'];
    bannerUrlWeb = json['bannerUrlWeb'];
    isActive = json['isActive'];
    position = json['position'];
    level = json['level'];
    productCount = json['product_count'];
    childrenCount = json['childrenCount'];
    if (json['childrenData'] != null) {
      childrenData = <Categories>[];
      json['childrenData'].forEach((v) {
        childrenData!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent'] = this.parent;
    data['image'] = this.image;
    data['bannerUrlApp'] = this.bannerUrlApp;
    data['bannerUrlWeb'] = this.bannerUrlWeb;
    data['isActive'] = this.isActive;
    data['position'] = this.position;
    data['level'] = this.level;
    data['product_count'] = this.productCount;
    data['childrenCount'] = this.childrenCount;
    if (this.childrenData != null) {
      data['childrenData'] = this.childrenData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeProducts {
  String? identifier;
  String? name;
  String? bannerImage;
  String? bannerImageWeb;
  int? offerId;
  dynamic viewAllUrl;
  List<Products>? data;

  HomeProducts(
      {this.identifier, this.name, this.bannerImage, this.bannerImageWeb, this.offerId, this.viewAllUrl, this.data});

  HomeProducts.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    name = json['name'];
    bannerImage = json['bannerImage'];
    bannerImageWeb = json['bannerImageWeb'];
    offerId = json['offerId'];
    viewAllUrl = json['viewAllUrl'];
    if (json['data'] != null) {
      data = <Products>[];
      json['data'].forEach((v) {
        data!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['name'] = this.name;
    data['bannerImage'] = this.bannerImage;
    data['bannerImageWeb'] = this.bannerImageWeb;
    data['offerId'] = this.offerId;
    data['viewAllUrl'] = this.viewAllUrl;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? sku;
  String? title;
  String? description;
  String? brand;
  String? barcode;
  bool? inStock;
  int? qty;
  int? minQty;
  int? maxQty;
  String? categoryIds;
  String? categoryleafName;
  double? currentPrice;
  double? specialPrice;
  String? warehouseInfo;
  String? productImageUrl;
  String? productImageUrlThumbnail;
  String? updateDateTimeInventory;
  dynamic updateTime;
  bool? active;
  bool? instant;
  bool? favourite;

  Products(
      {this.id,
      this.sku,
      this.title,
      this.description,
      this.brand,
      this.barcode,
      this.inStock,
      this.qty,
      this.minQty,
      this.maxQty,
      this.categoryIds,
      this.categoryleafName,
      this.currentPrice,
      this.specialPrice,
      this.warehouseInfo,
      this.productImageUrl,
      this.productImageUrlThumbnail,
      this.updateDateTimeInventory,
      this.updateTime,
      this.active,
      this.instant,
      this.favourite});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    title = json['title'];
    description = json['description'];
    brand = json['brand'];
    barcode = json['barcode'];
    inStock = json['inStock'];
    qty = json['qty'];
    minQty = json['minQty'];
    maxQty = json['maxQty'];
    categoryIds = json['categoryIds'];
    categoryleafName = json['categoryleafName'];
    currentPrice = json['currentPrice'];
    specialPrice = json['specialPrice'];
    warehouseInfo = json['warehouseInfo'];
    productImageUrl = json['productImageUrl'];
    productImageUrlThumbnail = json['productImageUrlThumbnail'];
    updateDateTimeInventory = json['updateDateTimeInventory'];
    updateTime = json['updateTime'];
    active = json['active'];
    instant = json['instant'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['title'] = this.title;
    data['description'] = this.description;
    data['brand'] = this.brand;
    data['barcode'] = this.barcode;
    data['inStock'] = this.inStock;
    data['qty'] = this.qty;
    data['minQty'] = this.minQty;
    data['maxQty'] = this.maxQty;
    data['categoryIds'] = this.categoryIds;
    data['categoryleafName'] = this.categoryleafName;
    data['currentPrice'] = this.currentPrice;
    data['specialPrice'] = this.specialPrice;
    data['warehouseInfo'] = this.warehouseInfo;
    data['productImageUrl'] = this.productImageUrl;
    data['productImageUrlThumbnail'] = this.productImageUrlThumbnail;
    data['updateDateTimeInventory'] = this.updateDateTimeInventory;
    data['updateTime'] = this.updateTime;
    data['active'] = this.active;
    data['instant'] = this.instant;
    data['favourite'] = this.favourite;
    return data;
  }
}
