import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vigil_erp/shared/enumerators.dart';

enum en_TablesName {
  Def_CompanyStructure,
  Def_Units,
  Def_ProductionCompanies,
  Def_Categories,
  Def_Jobs,
  Def_Sections,
  Def_FinancialCluses,
  Fix_FinacialType,
  Def_Stocks,
  Def_Treasures,
  Fix_PriceType,
  Fix_BalanceType,
  Dealing_Vendors,
  Fix_MaritalStatus,
  Fix_Religions,
  Fix_Gender,
  Fix_MilitaryStatus,
  Dealing_Employees,
  Dealing_Users,
  Fix_Monthes,
  Fix_RequestStatus,
  Inv_PermissionAdd,
  Fix_DocumentsType,
  Inv_PermissionDiscount,
  Inv_Settlement,
  Inv_PermissionAddDetails,
  Inv_PermissionDiscountDetails,
  Inv_SettlementDetails,
  Inv_ProductsQty,
  Def_ProductStructure,
  Dealing_Clients,
  Fix_Address_Government,
  Fix_Address_City,
  Fix_Address_DistrictArea,
  Inv_TransferDetails,
  Inv_Transfer
}

class ManageBLL {
  static Future fire_SetListBy_WriteBatch(
      String TableMaster, String TableDetails, Map<String, dynamic> master, List<Map<String, dynamic>> detais) async {
    CollectionReference coll = FirebaseFirestore.instance.collection(TableMaster);
    DocumentReference tablemasterDocref = coll.doc();
    WriteBatch batch = FirebaseFirestore.instance.batch();
    batch.set(tablemasterDocref, master);
    for (var item in detais) {
      DocumentReference itemRef = tablemasterDocref.collection(TableDetails).doc();
      batch.set(itemRef, item);
    }
    await batch.commit();
  }
}

class BLLCondions {
  String columnName;
  en_CondionsWhere where;
  dynamic value;

  BLLCondions(this.columnName, this.where, this.value);
}
