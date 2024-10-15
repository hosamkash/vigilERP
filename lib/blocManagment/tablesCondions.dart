import 'package:flutter/material.dart';
import '../bll/bllFirebase/ManageBLL.dart';
import '../bll/classModel/Inv_PermissionAdd.dart';
import '../bll/classModel/Inv_PermissionDiscount.dart';
import '../bll/classModel/Inv_Settlement.dart';
import '../shared/enumerators.dart';

class tablesCondions {
  static Future<List<BLLCondions>> createCondionsByDates(
      en_TablesName tableName, int? branchID, TextEditingController contDateFrom, TextEditingController contDateTo, bool isGetAllDates) async {
    List<BLLCondions> cond = [];

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

    //****************************************************************

    if (tableName == en_TablesName.Inv_PermissionAdd)
      getCondions_PermissionAdd();
    else if (tableName == en_TablesName.Inv_PermissionDiscount)
      getCondions_PermissionDiscount();
    else if (tableName == en_TablesName.Inv_Settlement) getCondions_Settlement();

    return cond;
  }

  static List<BLLCondions> createCondionOnly(String columnName , en_CondionsWhere operatorWhere , dynamic value)  {
    List<BLLCondions> cond = [];
    cond.add(BLLCondions(columnName, operatorWhere, value));
   return cond;
  }

  // static createCondions(en_TablesName tableName, List<BLLCondions> columnsConditions) {
  //   List<BLLCondions> cond = [];
  //   columnsConditions.forEach((elm) {
  //     cond.add(BLLCondions(tableName.name, elm.where, elm.value));
  //   });
  // }
}
