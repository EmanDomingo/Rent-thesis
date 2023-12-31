

import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier{
  Map<String, dynamic> productData = {};

  getFormData({
    String? productName,
    double? productPrice,
    String? category,
    String? description,
    DateTime? scheduleDate,
    List<String>? imageUrlList,
    String? productContnum,
    String? productSubmeter,
    String? productPets,
    String? productAddress,

    }){

    if (productName!=null) {
      productData['productName'] = productName;
    }

    if (productAddress != null) {
      productData['productAddress'] = productAddress;
    }

    if (productPrice != null) {
      productData['productPrice'] = productPrice;
    }

    if (productContnum != null) {
      productData['productContnum'] = productContnum;
    }

    if (productSubmeter != null) {
      productData['productSubmeter'] = productSubmeter;
    }

    if (productPets != null) {
      productData['productPets'] = productPets;
    }

    if (category != null) {
      productData['category'] = category;
    }

    if (description != null) {
      productData['description'] = description;
    }

    if (scheduleDate != null) {
      productData['scheduleDate'] = scheduleDate;
    }

    if (imageUrlList != null) {
      productData['imageUrlList'] = imageUrlList;
    }

    notifyListeners();
  }

  clearData() {
    productData.clear();
    notifyListeners();
  }
}