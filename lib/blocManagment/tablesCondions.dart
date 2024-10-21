import 'package:flutter/material.dart';
import 'package:vigil_erp/bll/classModel/HR_Bonus.dart';
import 'package:vigil_erp/bll/classModel/HR_Discount.dart';
import 'package:vigil_erp/bll/classModel/HR_Withdrwals.dart';
import 'package:vigil_erp/bll/classModel/Inv_RecivedQty.dart';
import 'package:vigil_erp/bll/classModel/Inv_Transfer.dart';
import 'package:vigil_erp/bll/classModel/Invoices_Purchase.dart';
import 'package:vigil_erp/bll/classModel/Invoices_PurchaseReturned.dart';
import 'package:vigil_erp/bll/classModel/Invoices_Sales.dart';
import 'package:vigil_erp/bll/classModel/Invoices_SalesReturned.dart';
import '../bll/bllFirebase/ManageBLL.dart';
import '../bll/classModel/Inv_PermissionAdd.dart';
import '../bll/classModel/Inv_PermissionDiscount.dart';
import '../bll/classModel/Inv_Settlement.dart';
import '../shared/enumerators.dart';

class tablesCondions {
  static Future<List<BLLCondions>> createCondionsByDates(
      en_TablesName tableName, int? branchID, TextEditingController contDateFrom, TextEditingController contDateTo,
      bool isGetAllDates) async {
    List<BLLCondions> cond = [];

    //****************************** inventory
    List<BLLCondions> getCondions_PermissionAdd() {
      cond.clear();
      if (branchID != null) {
        cond.add(BLLCondions(enTable_Inv_PermissionAdd.IDBranch.name, en_CondionsWhere.isEqualTo, branchID));
      }
      if (!isGetAllDates) {
        cond.add(BLLCondions(enTable_Inv_PermissionAdd.Date.name, en_CondionsWhere.isGreaterThanOrEqualTo, contDateFrom.text));
        cond.add(BLLCondions(enTable_Inv_PermissionAdd.Date.name, en_CondionsWhere.isLessThanOrEqualTo, contDateTo.text));
      }
      return cond;
    }

    List<BLLCondions> getCondions_PermissionDiscount() {
      cond.clear();
      if (branchID != null) cond.add(BLLCondions(enTable_Inv_PermissionDiscount.IDBranch.name, en_CondionsWhere.isEqualTo, branchID));
      if (!isGetAllDates) {
        cond.add(BLLCondions(enTable_Inv_PermissionDiscount.Date.name, en_CondionsWhere.isGreaterThanOrEqualTo, contDateFrom.text));
        cond.add(BLLCondions(enTable_Inv_PermissionDiscount.Date.name, en_CondionsWhere.isLessThanOrEqualTo, contDateTo.text));
      }
      return cond;
    }

    List<BLLCondions> getCondions_Settlement() {
      cond.clear();
      if (branchID != null) cond.add(BLLCondions(enTable_Inv_Settlement.IDBranch.name, en_CondionsWhere.isEqualTo, branchID));
      if (!isGetAllDates) {
        cond.add(BLLCondions(enTable_Inv_Settlement.Date.name, en_CondionsWhere.isGreaterThanOrEqualTo, contDateFrom.text));
        cond.add(BLLCondions(enTable_Inv_Settlement.Date.name, en_CondionsWhere.isLessThanOrEqualTo, contDateTo.text));
      }
      return cond;
    }

    List<BLLCondions> getCondions_Transfer() {
      cond.clear();
      if (branchID != null) cond.add(BLLCondions(enTable_Inv_Transfer.IDBranchFrom.name, en_CondionsWhere.isEqualTo, branchID));
      if (!isGetAllDates) {
        cond.add(BLLCondions(enTable_Inv_Settlement.Date.name, en_CondionsWhere.isGreaterThanOrEqualTo, contDateFrom.text));
        cond.add(BLLCondions(enTable_Inv_Settlement.Date.name, en_CondionsWhere.isLessThanOrEqualTo, contDateTo.text));
      }
      return cond;
    }

    List<BLLCondions> getCondions_RecivedQty() {
      cond.clear();
      if (branchID != null) cond.add(BLLCondions(enTable_Inv_RecivedQty.IDBranchTo.name, en_CondionsWhere.isEqualTo, branchID));
      if (!isGetAllDates) {
        cond.add(BLLCondions(enTable_Inv_Settlement.Date.name, en_CondionsWhere.isGreaterThanOrEqualTo, contDateFrom.text));
        cond.add(BLLCondions(enTable_Inv_Settlement.Date.name, en_CondionsWhere.isLessThanOrEqualTo, contDateTo.text));
      }
      return cond;
    }


    //****************************** invoices
    List<BLLCondions> getCondions_Purchase() {
      cond.clear();
      if (branchID != null) {
        cond.add(BLLCondions(enTable_Invoices_Purchase.IDBranch.name, en_CondionsWhere.isEqualTo, branchID));
      }
      if (!isGetAllDates) {
        cond.add(BLLCondions(enTable_Invoices_Purchase.Date.name, en_CondionsWhere.isGreaterThanOrEqualTo, contDateFrom.text));
        cond.add(BLLCondions(enTable_Invoices_Purchase.Date.name, en_CondionsWhere.isLessThanOrEqualTo, contDateTo.text));
      }
      return cond;
    }

    List<BLLCondions> getCondions_PurchaseReturned() {
      cond.clear();
      if (branchID != null) {
        cond.add(BLLCondions(enTable_Invoices_PurchaseReturned.IDBranch.name, en_CondionsWhere.isEqualTo, branchID));
      }
      if (!isGetAllDates) {
        cond.add(BLLCondions(enTable_Invoices_PurchaseReturned.Date.name, en_CondionsWhere.isGreaterThanOrEqualTo, contDateFrom.text));
        cond.add(BLLCondions(enTable_Invoices_PurchaseReturned.Date.name, en_CondionsWhere.isLessThanOrEqualTo, contDateTo.text));
      }
      return cond;
    }

    List<BLLCondions> getCondions_Sales() {
      cond.clear();
      if (branchID != null) {
        cond.add(BLLCondions(enTable_Invoices_Sales.IDBranch.name, en_CondionsWhere.isEqualTo, branchID));
      }
      if (!isGetAllDates) {
        cond.add(BLLCondions(enTable_Invoices_Sales.Date.name, en_CondionsWhere.isGreaterThanOrEqualTo, contDateFrom.text));
        cond.add(BLLCondions(enTable_Invoices_Sales.Date.name, en_CondionsWhere.isLessThanOrEqualTo, contDateTo.text));
      }
      return cond;
    }

    List<BLLCondions> getCondions_SalesReturned() {
      cond.clear();
      if (branchID != null) {
        cond.add(BLLCondions(enTable_Invoices_SalesReturned.IDBranch.name, en_CondionsWhere.isEqualTo, branchID));
      }
      if (!isGetAllDates) {
        cond.add(BLLCondions(enTable_Invoices_SalesReturned.Date.name, en_CondionsWhere.isGreaterThanOrEqualTo, contDateFrom.text));
        cond.add(BLLCondions(enTable_Invoices_SalesReturned.Date.name, en_CondionsWhere.isLessThanOrEqualTo, contDateTo.text));
      }
      return cond;
    }


    //****************************** HR
    List<BLLCondions> getCondions_HR_Bonus() {
      cond.clear();
      if (branchID != null) {
        cond.add(BLLCondions(enTable_HR_Bonus.IDBranch.name, en_CondionsWhere.isEqualTo, branchID));
      }
      if (!isGetAllDates) {
        cond.add(BLLCondions(enTable_HR_Bonus.Date.name, en_CondionsWhere.isGreaterThanOrEqualTo, contDateFrom.text));
        cond.add(BLLCondions(enTable_HR_Bonus.Date.name, en_CondionsWhere.isLessThanOrEqualTo, contDateTo.text));
      }
      return cond;
    }

    List<BLLCondions> getCondions_HR_Discount() {
      cond.clear();
      if (branchID != null) {
        cond.add(BLLCondions(enTable_HR_Discount.IDBranch.name, en_CondionsWhere.isEqualTo, branchID));
      }
      if (!isGetAllDates) {
        cond.add(BLLCondions(enTable_HR_Discount.Date.name, en_CondionsWhere.isGreaterThanOrEqualTo, contDateFrom.text));
        cond.add(BLLCondions(enTable_HR_Discount.Date.name, en_CondionsWhere.isLessThanOrEqualTo, contDateTo.text));
      }
      return cond;
    }

    List<BLLCondions> getCondions_HR_Withdrwals() {
      cond.clear();
      if (branchID != null) {
        cond.add(BLLCondions(enTable_HR_Withdrwals.IDBranch.name, en_CondionsWhere.isEqualTo, branchID));
      }
      if (!isGetAllDates) {
        cond.add(BLLCondions(enTable_HR_Withdrwals.Date.name, en_CondionsWhere.isGreaterThanOrEqualTo, contDateFrom.text));
        cond.add(BLLCondions(enTable_HR_Withdrwals.Date.name, en_CondionsWhere.isLessThanOrEqualTo, contDateTo.text));
      }
      return cond;
    }



    //****************************** inventory
    if (tableName == en_TablesName.Inv_PermissionAdd) {
      getCondions_PermissionAdd();
    } else if (tableName == en_TablesName.Inv_PermissionDiscount) {
      getCondions_PermissionDiscount();
    } else if (tableName == en_TablesName.Inv_Settlement) {
      getCondions_Settlement();
    }
    else if (tableName == en_TablesName.Inv_Transfer) {
      getCondions_Transfer();
    }
    else if (tableName == en_TablesName.Inv_RecivedQty) {
      getCondions_RecivedQty();
    }

    //****************************** invoices
    else if (tableName == en_TablesName.Invoices_Purchase) {
      getCondions_Purchase();
    }
    else if (tableName == en_TablesName.Invoices_PurchaseReturned) {
      getCondions_PurchaseReturned();
    }
    else if (tableName == en_TablesName.Invoices_Sales) {
      getCondions_Sales();
    }
    else if (tableName == en_TablesName.Invoices_SalesReturned) {
      getCondions_SalesReturned();
    }

    //****************************** HR
    else if (tableName == en_TablesName.HR_Bonus) {
      getCondions_HR_Bonus();
    }
    else if (tableName == en_TablesName.HR_Discount) {
      getCondions_HR_Discount();
    }
    else if (tableName == en_TablesName.HR_Withdrwals) {
      getCondions_HR_Withdrwals();
    }





    return cond;
  }

  static List<BLLCondions> createCondionOnly(String columnName , en_CondionsWhere operatorWhere , dynamic value)  {
    List<BLLCondions> cond = [];
    cond.add(BLLCondions(columnName, operatorWhere, value));
   return cond;
  }


}
