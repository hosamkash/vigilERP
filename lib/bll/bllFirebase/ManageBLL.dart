import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/enumerators.dart';

enum en_TablesName {
  Def_CompanyStructure,
  Def_Units,
  Def_ProductionCompanies,
  Def_Categories,
  Def_Jobs,
  Def_Sections,
  Def_FinancialCluses,
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
  Inv_Transfer,
  Inv_TransferDetails,
  Inv_RecivedQty,
  Inv_RecivedQtyDetails,
  Invoices_Purchase,
  Invoices_PurchaseDetails,
  Invoices_Sales,
  Invoices_SalesDetails,
  Invoices_PurchaseReturned,
  Invoices_PurchaseReturnedDetails,
  Invoices_SalesReturned,
  Invoices_SalesReturnedDetails,
  Fix_BounsType,
  HR_Bonus,
  HR_Discount,
  HR_Withdrwals,
  HR_Advances,
  Fix_DealingType,
  Fix_FinancialType,
  Fina_Exchange,
  Fina_Supplay,
  Fina_Transfere,
	Fina_TreasurMovement,
  Fina_ClosedTreasure ,
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
