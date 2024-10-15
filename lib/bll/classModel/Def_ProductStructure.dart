import 'package:flutter/cupertino.dart';

enum enTable_Def_ProductStructure {
  ID,
  BarCode,
  Name,
  IDCategory,
  IDProductionCompany,
  UnitBig_ID,
  UnitBig_PurchasePrice,
  UnitBig_Sales1,
  UnitBig_Sales2,
  UnitBig_Sales3,
  UnitBig_Sales4,
  UnitBig_Sales5,
  UnitCountOf,
  UnitSmall_ID,
  UnitSmall_PurchasePrice,
  UnitSmall_Sales1,
  UnitSmall_Sales2,
  UnitSmall_Sales3,
  UnitSmall_Sales4,
  UnitSmall_Sales5,
  LimitedQty,
  IsActive,
  IsPOS,
  IsUpdated,
  controller,
  ImageName1,
  ImageURL1,
  ImageName2,
  ImageURL2,
  ImageName3,
  ImageURL3,
  ImageName4,
  ImageURL4,
  ImageName5,
  ImageURL5,
  Discription
}

class Def_ProductStructure {
  static List<String> ColumnsName = enTable_Def_ProductStructure.values.map((item) => item.name).toList();

  int? ID;
  int? BarCode;
  String? Name;
  int? IDCategory;
  int? IDProductionCompany;
  int? UnitBig_ID;
  double? UnitBig_PurchasePrice;
  double? UnitBig_Sales1;
  double? UnitBig_Sales2;
  double? UnitBig_Sales3;
  double? UnitBig_Sales4;
  double? UnitBig_Sales5;
  int? UnitCountOf;
  int? UnitSmall_ID;
  double? UnitSmall_PurchasePrice;
  double? UnitSmall_Sales1;
  double? UnitSmall_Sales2;
  double? UnitSmall_Sales3;
  double? UnitSmall_Sales4;
  double? UnitSmall_Sales5;
  int? LimitedQty;
  bool? IsActive;
  bool? IsPOS;
  bool? IsUpdated;
  TextEditingController? controller;
  String? ImageName1;
  String? ImageURL1;
  String? ImageName2;
  String? ImageURL2;
  String? ImageName3;
  String? ImageURL3;
  String? ImageName4;
  String? ImageURL4;
  String? ImageName5;
  String? ImageURL5;
  String? Discription;

  Def_ProductStructure({
    this.ID,
    this.BarCode,
    this.Name,
    this.IDCategory,
    this.IDProductionCompany,
    this.UnitBig_ID,
    this.UnitBig_PurchasePrice,
    this.UnitBig_Sales1,
    this.UnitBig_Sales2,
    this.UnitBig_Sales3,
    this.UnitBig_Sales4,
    this.UnitBig_Sales5,
    this.UnitCountOf,
    this.UnitSmall_ID,
    this.UnitSmall_PurchasePrice,
    this.UnitSmall_Sales1,
    this.UnitSmall_Sales2,
    this.UnitSmall_Sales3,
    this.UnitSmall_Sales4,
    this.UnitSmall_Sales5,
    this.LimitedQty,
    this.IsActive,
    this.IsPOS,
    this.IsUpdated,
    this.controller,
    this.ImageName1,
    this.ImageURL1,
    this.ImageName2,
    this.ImageURL2,
    this.ImageName3,
    this.ImageURL3,
    this.ImageName4,
    this.ImageURL4,
    this.ImageName5,
    this.ImageURL5,
    this.Discription,
  });

//**************************** general function ****************************

  Def_ProductStructure.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    BarCode = json['BarCode'];
    Name = json['Name'].toString();
    IDCategory = json['IDCategory'];
    IDProductionCompany = json['IDProductionCompany'];
    UnitBig_ID = json['UnitBig_ID'];
    UnitBig_PurchasePrice = json['UnitBig_PurchasePrice'];
    UnitBig_Sales1 = json['UnitBig_Sales1'];
    UnitBig_Sales2 = json['UnitBig_Sales2'];
    UnitBig_Sales3 = json['UnitBig_Sales3'];
    UnitBig_Sales4 = json['UnitBig_Sales4'];
    UnitBig_Sales5 = json['UnitBig_Sales5'];
    UnitCountOf = json['UnitCountOf'];
    UnitSmall_ID = json['UnitSmall_ID'];
    UnitSmall_PurchasePrice = json['UnitSmall_PurchasePrice'];
    UnitSmall_Sales1 = json['UnitSmall_Sales1'];
    UnitSmall_Sales2 = json['UnitSmall_Sales2'];
    UnitSmall_Sales3 = json['UnitSmall_Sales3'];
    UnitSmall_Sales4 = json['UnitSmall_Sales4'];
    UnitSmall_Sales5 = json['UnitSmall_Sales5'];
    LimitedQty = json['LimitedQty'];
    IsActive = json['IsActive'];
    IsPOS = json['IsPOS'];
    IsUpdated = json['IsUpdated'];
    controller = json['controller'];
    ImageName1 = json['ImageName1'].toString();
    ImageURL1 = json['ImageURL1'].toString();
    ImageName2 = json['ImageName2'].toString();
    ImageURL2 = json['ImageURL2'].toString();
    ImageName3 = json['ImageName3'].toString();
    ImageURL3 = json['ImageURL3'].toString();
    ImageName4 = json['ImageName4'].toString();
    ImageURL4 = json['ImageURL4'].toString();
    ImageName5 = json['ImageName5'].toString();
    ImageURL5 = json['ImageURL5'].toString();
    Discription = json['Discription'].toString();
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'BarCode': BarCode,
      'Name': Name,
      'IDCategory': IDCategory,
      'IDProductionCompany': IDProductionCompany,
      'UnitBig_ID': UnitBig_ID,
      'UnitBig_PurchasePrice': UnitBig_PurchasePrice,
      'UnitBig_Sales1': UnitBig_Sales1,
      'UnitBig_Sales2': UnitBig_Sales2,
      'UnitBig_Sales3': UnitBig_Sales3,
      'UnitBig_Sales4': UnitBig_Sales4,
      'UnitBig_Sales5': UnitBig_Sales5,
      'UnitCountOf': UnitCountOf,
      'UnitSmall_ID': UnitSmall_ID,
      'UnitSmall_PurchasePrice': UnitSmall_PurchasePrice,
      'UnitSmall_Sales1': UnitSmall_Sales1,
      'UnitSmall_Sales2': UnitSmall_Sales2,
      'UnitSmall_Sales3': UnitSmall_Sales3,
      'UnitSmall_Sales4': UnitSmall_Sales4,
      'UnitSmall_Sales5': UnitSmall_Sales5,
      'LimitedQty': LimitedQty,
      'IsActive': IsActive,
      'IsPOS': IsPOS,
      'IsUpdated': IsUpdated,
      'controller': controller,
      'ImageName1': ImageName1,
      'ImageURL1': ImageURL1,
      'ImageName2': ImageName2,
      'ImageURL2': ImageURL2,
      'ImageName3': ImageName3,
      'ImageURL3': ImageURL3,
      'ImageName4': ImageName4,
      'ImageURL4': ImageURL4,
      'ImageName5': ImageName5,
      'ImageURL5': ImageURL5,
      'Discription': Discription,
    };
  }

  static List<dynamic> getColumnAsList(List<Def_ProductStructure> lstDef_ProductStructure, enTable_Def_ProductStructure enTable) {
    if (enTable == enTable_Def_ProductStructure.ID) {
      return lstDef_ProductStructure.map((col) => col.ID).toSet().toList() as List<int>;
    } else if (enTable == enTable_Def_ProductStructure.BarCode) {
      return lstDef_ProductStructure.map((col) => col.BarCode).toSet().toList() as List<int>;
    } else if (enTable == enTable_Def_ProductStructure.Name) {
      return lstDef_ProductStructure.map((col) => col.Name).toSet().toList() as List<String>;
    } else if (enTable == enTable_Def_ProductStructure.IDCategory) {
      return lstDef_ProductStructure.map((col) => col.IDCategory).toSet().toList() as List<int>;
    } else if (enTable == enTable_Def_ProductStructure.IDProductionCompany) {
      return lstDef_ProductStructure.map((col) => col.IDProductionCompany).toSet().toList() as List<int>;
    } else if (enTable == enTable_Def_ProductStructure.UnitBig_ID) {
      return lstDef_ProductStructure.map((col) => col.UnitBig_ID).toSet().toList() as List<int>;
    } else if (enTable == enTable_Def_ProductStructure.UnitBig_PurchasePrice) {
      return lstDef_ProductStructure.map((col) => col.UnitBig_PurchasePrice).toSet().toList() as List<double>;
    } else if (enTable == enTable_Def_ProductStructure.UnitBig_Sales1) {
      return lstDef_ProductStructure.map((col) => col.UnitBig_Sales1).toSet().toList() as List<double>;
    } else if (enTable == enTable_Def_ProductStructure.UnitBig_Sales2) {
      return lstDef_ProductStructure.map((col) => col.UnitBig_Sales2).toSet().toList() as List<double>;
    } else if (enTable == enTable_Def_ProductStructure.UnitBig_Sales3) {
      return lstDef_ProductStructure.map((col) => col.UnitBig_Sales3).toSet().toList() as List<double>;
    } else if (enTable == enTable_Def_ProductStructure.UnitBig_Sales4) {
      return lstDef_ProductStructure.map((col) => col.UnitBig_Sales4).toSet().toList() as List<double>;
    } else if (enTable == enTable_Def_ProductStructure.UnitBig_Sales5) {
      return lstDef_ProductStructure.map((col) => col.UnitBig_Sales5).toSet().toList() as List<double>;
    } else if (enTable == enTable_Def_ProductStructure.UnitCountOf) {
      return lstDef_ProductStructure.map((col) => col.UnitCountOf).toSet().toList() as List<int>;
    } else if (enTable == enTable_Def_ProductStructure.UnitSmall_ID) {
      return lstDef_ProductStructure.map((col) => col.UnitSmall_ID).toSet().toList() as List<int>;
    } else if (enTable == enTable_Def_ProductStructure.UnitSmall_PurchasePrice) {
      return lstDef_ProductStructure.map((col) => col.UnitSmall_PurchasePrice).toSet().toList() as List<double>;
    } else if (enTable == enTable_Def_ProductStructure.UnitSmall_Sales1) {
      return lstDef_ProductStructure.map((col) => col.UnitSmall_Sales1).toSet().toList() as List<double>;
    } else if (enTable == enTable_Def_ProductStructure.UnitSmall_Sales2) {
      return lstDef_ProductStructure.map((col) => col.UnitSmall_Sales2).toSet().toList() as List<double>;
    } else if (enTable == enTable_Def_ProductStructure.UnitSmall_Sales3) {
      return lstDef_ProductStructure.map((col) => col.UnitSmall_Sales3).toSet().toList() as List<double>;
    } else if (enTable == enTable_Def_ProductStructure.UnitSmall_Sales4) {
      return lstDef_ProductStructure.map((col) => col.UnitSmall_Sales4).toSet().toList() as List<double>;
    } else if (enTable == enTable_Def_ProductStructure.UnitSmall_Sales5) {
      return lstDef_ProductStructure.map((col) => col.UnitSmall_Sales5).toSet().toList() as List<double>;
    } else if (enTable == enTable_Def_ProductStructure.LimitedQty) {
      return lstDef_ProductStructure.map((col) => col.LimitedQty).toSet().toList() as List<int>;
    } else if (enTable == enTable_Def_ProductStructure.IsActive) {
      return lstDef_ProductStructure.map((col) => col.IsActive).toSet().toList() as List<bool>;
    } else if (enTable == enTable_Def_ProductStructure.IsPOS) {
      return lstDef_ProductStructure.map((col) => col.IsPOS).toSet().toList() as List<bool>;
    } else if (enTable == enTable_Def_ProductStructure.IsUpdated) {
      return lstDef_ProductStructure.map((col) => col.IsUpdated).toSet().toList() as List<bool>;
    } else if (enTable == enTable_Def_ProductStructure.controller) {
      return lstDef_ProductStructure.map((col) => col.controller).toSet().toList() as List<String>;
    } else if (enTable == enTable_Def_ProductStructure.ImageName1) {
      return lstDef_ProductStructure.map((col) => col.ImageName1).toSet().toList() as List<String>;
    } else if (enTable == enTable_Def_ProductStructure.ImageURL1) {
      return lstDef_ProductStructure.map((col) => col.ImageURL1).toSet().toList() as List<String>;
    } else if (enTable == enTable_Def_ProductStructure.ImageName2) {
      return lstDef_ProductStructure.map((col) => col.ImageName2).toSet().toList() as List<String>;
    } else if (enTable == enTable_Def_ProductStructure.ImageURL2) {
      return lstDef_ProductStructure.map((col) => col.ImageURL2).toSet().toList() as List<String>;
    } else if (enTable == enTable_Def_ProductStructure.ImageName3) {
      return lstDef_ProductStructure.map((col) => col.ImageName3).toSet().toList() as List<String>;
    } else if (enTable == enTable_Def_ProductStructure.ImageURL3) {
      return lstDef_ProductStructure.map((col) => col.ImageURL3).toSet().toList() as List<String>;
    } else if (enTable == enTable_Def_ProductStructure.ImageName4) {
      return lstDef_ProductStructure.map((col) => col.ImageName4).toSet().toList() as List<String>;
    } else if (enTable == enTable_Def_ProductStructure.ImageURL4) {
      return lstDef_ProductStructure.map((col) => col.ImageURL4).toSet().toList() as List<String>;
    } else if (enTable == enTable_Def_ProductStructure.ImageName5) {
      return lstDef_ProductStructure.map((col) => col.ImageName5).toSet().toList() as List<String>;
    } else if (enTable == enTable_Def_ProductStructure.ImageURL5) {
      return lstDef_ProductStructure.map((col) => col.ImageURL5).toSet().toList() as List<String>;
    } else if (enTable == enTable_Def_ProductStructure.Discription) {
      return lstDef_ProductStructure.map((col) => col.Discription).toSet().toList() as List<String>;
    } else {
      return Null as List<dynamic>;
    }
  }

  static List<String> getColumnAsListString(List<Def_ProductStructure> lstDef_ProductStructure, enTable_Def_ProductStructure enTable) {
    if (enTable == enTable_Def_ProductStructure.ID) {
      return lstDef_ProductStructure.map((col) => col.ID.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.BarCode) {
      return lstDef_ProductStructure.map((col) => col.BarCode.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.Name) {
      return lstDef_ProductStructure.map((col) => col.Name.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.IDCategory) {
      return lstDef_ProductStructure.map((col) => col.IDCategory.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.IDProductionCompany) {
      return lstDef_ProductStructure.map((col) => col.IDProductionCompany.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.UnitBig_ID) {
      return lstDef_ProductStructure.map((col) => col.UnitBig_ID.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.UnitBig_PurchasePrice) {
      return lstDef_ProductStructure.map((col) => col.UnitBig_PurchasePrice.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.UnitBig_Sales1) {
      return lstDef_ProductStructure.map((col) => col.UnitBig_Sales1.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.UnitBig_Sales2) {
      return lstDef_ProductStructure.map((col) => col.UnitBig_Sales2.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.UnitBig_Sales3) {
      return lstDef_ProductStructure.map((col) => col.UnitBig_Sales3.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.UnitBig_Sales4) {
      return lstDef_ProductStructure.map((col) => col.UnitBig_Sales4.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.UnitBig_Sales5) {
      return lstDef_ProductStructure.map((col) => col.UnitBig_Sales5.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.UnitCountOf) {
      return lstDef_ProductStructure.map((col) => col.UnitCountOf.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.UnitSmall_ID) {
      return lstDef_ProductStructure.map((col) => col.UnitSmall_ID.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.UnitSmall_PurchasePrice) {
      return lstDef_ProductStructure.map((col) => col.UnitSmall_PurchasePrice.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.UnitSmall_Sales1) {
      return lstDef_ProductStructure.map((col) => col.UnitSmall_Sales1.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.UnitSmall_Sales2) {
      return lstDef_ProductStructure.map((col) => col.UnitSmall_Sales2.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.UnitSmall_Sales3) {
      return lstDef_ProductStructure.map((col) => col.UnitSmall_Sales3.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.UnitSmall_Sales4) {
      return lstDef_ProductStructure.map((col) => col.UnitSmall_Sales4.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.UnitSmall_Sales5) {
      return lstDef_ProductStructure.map((col) => col.UnitSmall_Sales5.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.LimitedQty) {
      return lstDef_ProductStructure.map((col) => col.LimitedQty.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.IsActive) {
      return lstDef_ProductStructure.map((col) => col.IsActive.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.IsPOS) {
      return lstDef_ProductStructure.map((col) => col.IsPOS.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.IsUpdated) {
      return lstDef_ProductStructure.map((col) => col.IsUpdated.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.controller) {
      return lstDef_ProductStructure.map((col) => col.controller.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.ImageName1) {
      return lstDef_ProductStructure.map((col) => col.ImageName1.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.ImageURL1) {
      return lstDef_ProductStructure.map((col) => col.ImageURL1.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.ImageName2) {
      return lstDef_ProductStructure.map((col) => col.ImageName2.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.ImageURL2) {
      return lstDef_ProductStructure.map((col) => col.ImageURL2.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.ImageName3) {
      return lstDef_ProductStructure.map((col) => col.ImageName3.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.ImageURL3) {
      return lstDef_ProductStructure.map((col) => col.ImageURL3.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.ImageName4) {
      return lstDef_ProductStructure.map((col) => col.ImageName4.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.ImageURL4) {
      return lstDef_ProductStructure.map((col) => col.ImageURL4.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.ImageName5) {
      return lstDef_ProductStructure.map((col) => col.ImageName5.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.ImageURL5) {
      return lstDef_ProductStructure.map((col) => col.ImageURL5.toString()).toSet().toList();
    } else if (enTable == enTable_Def_ProductStructure.Discription) {
      return lstDef_ProductStructure.map((col) => col.Discription.toString()).toSet().toList();
    } else {
      return '' as List<String>;
    }
  }
}
