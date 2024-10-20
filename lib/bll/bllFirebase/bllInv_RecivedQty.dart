import 'package:vigil_erp/bll/classModel/Inv_RecivedQtyDetails.dart';
import '../classModel/Inv_RecivedQty.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../shared/enumerators.dart';
import 'ManageBLL.dart';

class bllInv_RecivedQty {
  static List<String> ColumnsName = enTable_Inv_RecivedQty.values.map((item) => item.name).toList();
  static late List<Inv_RecivedQty> lstInv_RecivedQty = [];
  static late Inv_RecivedQty itemInv_RecivedQty;
  static String query = '';
  static List<Inv_RecivedQtyDetails> lstInv_RecivedQtyDetails = [];

//**************************** general function ****************************

  static Future<int> getMaxID_firestore() async {
    int maxID = 0;
    await FirebaseFirestore.instance
        .collection(en_TablesName.Inv_RecivedQty.name)
        .orderBy(enTable_Inv_RecivedQty.ID.name, descending: true)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        maxID = 1;
      } else {
        maxID = value.docs.first.get(enTable_Inv_RecivedQty.ID.name);
        maxID += 1;
      }
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return maxID;
  }

  static Future<int> getMax_firestore(enTable_Inv_RecivedQty colName, {BLLCondions? condion}) async {
    int maxID = 1;
    QuerySnapshot? snapshot;
    try {
      if (condion != null) {
        snapshot = await FirebaseFirestore.instance
            .collection(en_TablesName.Inv_RecivedQty.name)
            .where(condion.columnName, isEqualTo: condion.value)
            .orderBy(colName.name, descending: true)
            .limit(1)
            .get();
      } else if (condion == null) {
        snapshot =
            await FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQty.name).orderBy(colName.name, descending: true).limit(1).get();
      }
      if (snapshot != null && snapshot.docs.isNotEmpty) {
        maxID = snapshot.docs.first.get(colName.name);
        maxID += 1;
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
    return maxID;
  }

//**************************** add & set ****************************

  /// هو إسم الكلاس والإضافة بتكون بكون عشوائي ولا يمكن للمستخدم تحديده collection وبيكون ال  FirebaseFirestore تستخدم للإضافة فى
  static Future<String> fire_AddItem(Inv_RecivedQty itemInv_RecivedQty) async {
    String docCreatedName = '';
    await FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQty.name).add(itemInv_RecivedQty.toMap()).then((val) {
      docCreatedName = val.id;
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return docCreatedName;
  }

  static Future<bool> fire_SetItemMap(String docName, Map<String, dynamic> itemInv_RecivedQty) async {
    bool result = false;
    await FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQty.name).doc(docName).set(itemInv_RecivedQty).then((val) {
      result = true;
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return result;
  }

  static Future<bool> fire_SetItem(String docName, Inv_RecivedQty itemInv_RecivedQty) async {
    bool result = false;
    await FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQty.name).doc(docName).set(itemInv_RecivedQty.toMap()).then((val) {
      result = true;
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return result;
  }

  static Future fire_setListMaster_And_Details({
    required String insertdDocID,
    required Inv_RecivedQty itemInv_RecivedQty,
    required String collectionDetailsName,
    required String columnNameAsDocumentDetails,
    required List<Map<String, dynamic>> detais,
    required List<Map<String, dynamic>> deletedItemsDetais,
  }) async {
    CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQty.name);
    DocumentReference tablemasterDocref = coll.doc(insertdDocID);
    WriteBatch batch = FirebaseFirestore.instance.batch();
    // save Master
    batch.set(tablemasterDocref, itemInv_RecivedQty.toMap());
    // delete old items it removed from list
    for (var item in deletedItemsDetais) {
      DocumentReference itemRefDelete = tablemasterDocref.collection(collectionDetailsName).doc(item[columnNameAsDocumentDetails].toString());
      batch.delete(itemRefDelete);
    }
    // add Details and save
    for (var item in detais) {
      DocumentReference itemRef = tablemasterDocref.collection(collectionDetailsName).doc(item[columnNameAsDocumentDetails].toString());
      // Save details
      batch.set(itemRef, item);
    }
    await batch.commit();
  }

  static Future fire_setListMaster({
    required List<Inv_RecivedQty> lstInv_RecivedQty,
  }) async {
    CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQty.name);
    WriteBatch batch = FirebaseFirestore.instance.batch();
    lstInv_RecivedQty.forEach((elm) {
      DocumentReference docRef = coll.doc(elm.ID.toString());
      batch.set(docRef, elm.toMap());
    });
    await batch.commit();
  }

//**************************** get ****************************

  static Future<Inv_RecivedQty> fire_getItem(String docName) async {
    late Inv_RecivedQty itemInv_RecivedQty;
    try {
      var retValue = await FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQty.name).doc(docName).get();
      itemInv_RecivedQty = Inv_RecivedQty();
      itemInv_RecivedQty.ID = retValue.data()!['ID'];
      itemInv_RecivedQty.Code = retValue.data()!['Code'];
      itemInv_RecivedQty.Date = retValue.data()!['Date'];
      itemInv_RecivedQty.Time = retValue.data()!['Time'];
      itemInv_RecivedQty.IDRequestStatus = retValue.data()!['IDRequestStatus'];
      itemInv_RecivedQty.IDBranchFrom = retValue.data()!['IDBranchFrom'];
      itemInv_RecivedQty.IDStockFrom = retValue.data()!['IDStockFrom'];
      itemInv_RecivedQty.IDEmployee = retValue.data()!['IDEmployee'];
      itemInv_RecivedQty.IDBranchTo = retValue.data()!['IDBranchTo'];
      itemInv_RecivedQty.IDStockTo = retValue.data()!['IDStockTo'];
      itemInv_RecivedQty.TotalValueFrom = retValue.data()!['TotalValueFrom'];
      itemInv_RecivedQty.TotalValueTo = retValue.data()!['TotalValueTo'];
      itemInv_RecivedQty.Note = retValue.data()!['Note'];
      itemInv_RecivedQty.UID = retValue.data()!['UID'];
      itemInv_RecivedQty.IDTransfer = retValue.data()!['IDTransfer'];
      return itemInv_RecivedQty;
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  static Future<List<Inv_RecivedQty>> fire_getList() async {
    await FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQty.name).get().then((value) {
      lstInv_RecivedQty.clear();
      value.docs.forEach((element) {
        lstInv_RecivedQty.add(Inv_RecivedQty.fromJson(element.data()));
      });
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return lstInv_RecivedQty;
  }

  static Future<List<Inv_RecivedQtyDetails>> fire_getListDetails(String IDMaster, String TableNameDetails) async {
    try {
      //**************** 1 - Master Date
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQty.name).doc(IDMaster).get();

      //**************** 2 - Details Data
      QuerySnapshot<Map<String, dynamic>> collRef = await doc.reference.collection(TableNameDetails).get();
      lstInv_RecivedQtyDetails.clear();
      collRef.docs.forEach((element) {
        lstInv_RecivedQtyDetails.add(Inv_RecivedQtyDetails.fromJson(element.data()));
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
    return lstInv_RecivedQtyDetails;
  }

  static Future<List<Inv_RecivedQty>> fire_getListByBranch(int branchID, String BranchColumnName) async {
    await FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQty.name).where(BranchColumnName, isEqualTo: branchID).get().then((value) {
      lstInv_RecivedQty.clear();
      value.docs.forEach((element) {
        lstInv_RecivedQty.add(Inv_RecivedQty.fromJson(element.data()));
      });
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return lstInv_RecivedQty;
  }

  static Future<List<Inv_RecivedQty>> fire_getListWithConditions({List<BLLCondions>? conditions}) async {
    CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQty.name);
    Query query = colRef;
    if (conditions != null  ) {
      for (var cond in conditions) {
        if (cond.where == en_CondionsWhere.isNull)
          query = query.where(cond.columnName, isNull: cond.value);
        else if (cond.where == en_CondionsWhere.isEqualTo)
          query = query.where(cond.columnName, isEqualTo: cond.value);
        else if (cond.where == en_CondionsWhere.isNotEqualTo)
          query = query.where(cond.columnName, isNotEqualTo: cond.value);
        else if (cond.where == en_CondionsWhere.isLessThan)
          query = query.where(cond.columnName, isLessThan: cond.value);
        else if (cond.where == en_CondionsWhere.isLessThanOrEqualTo)
          query = query.where(cond.columnName, isLessThanOrEqualTo: cond.value);
        else if (cond.where == en_CondionsWhere.isGreaterThan)
          query = query.where(cond.columnName, isGreaterThan: cond.value);
        else if (cond.where == en_CondionsWhere.isGreaterThanOrEqualTo)
          query = query.where(cond.columnName, isGreaterThanOrEqualTo: cond.value);
        else if (cond.where == en_CondionsWhere.whereIn)
          query = query.where(cond.columnName, whereIn: cond.value);
        else if (cond.where == en_CondionsWhere.whereNotIn)
          query = query.where(cond.columnName, whereNotIn: cond.value);
        else if (cond.where == en_CondionsWhere.arrayContains)
          query = query.where(cond.columnName, arrayContains: cond.value);
        else if (cond.where == en_CondionsWhere.arrayContainsAny) query = query.where(cond.columnName, arrayContainsAny: cond.value);
      }
    }
    QuerySnapshot snap = await query.get();
    lstInv_RecivedQty.clear();
    snap.docs.forEach((element) {
      lstInv_RecivedQty.add(Inv_RecivedQty.fromJson(element.data() as Map<String, dynamic>));
    });
    return lstInv_RecivedQty;
  }

//**************************** delete ****************************

  static Future<bool> fire_DeleteItem(String docName) async {
    bool result = false;
    await FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQty.name).doc(docName).delete().then((val) {
      result = true;
    }).catchError((error) {
      print(error.toString());
      result = false;
    });
    return result;
  }

  static Future fire_DeleteListMaster(List<BLLCondions> conditions) async {
    CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQty.name);
    Query query = colRef;
    for (var cond in conditions) {
      if (cond.where == en_CondionsWhere.isNull)
        query = query.where(cond.columnName, isNull: cond.value);
      else if (cond.where == en_CondionsWhere.isEqualTo)
        query = query.where(cond.columnName, isEqualTo: cond.value);
      else if (cond.where == en_CondionsWhere.isNotEqualTo)
        query = query.where(cond.columnName, isNotEqualTo: cond.value);
      else if (cond.where == en_CondionsWhere.isLessThan)
        query = query.where(cond.columnName, isLessThan: cond.value);
      else if (cond.where == en_CondionsWhere.isLessThanOrEqualTo)
        query = query.where(cond.columnName, isLessThanOrEqualTo: cond.value);
      else if (cond.where == en_CondionsWhere.isGreaterThan)
        query = query.where(cond.columnName, isGreaterThan: cond.value);
      else if (cond.where == en_CondionsWhere.isGreaterThanOrEqualTo)
        query = query.where(cond.columnName, isGreaterThanOrEqualTo: cond.value);
      else if (cond.where == en_CondionsWhere.whereIn)
        query = query.where(cond.columnName, whereIn: cond.value);
      else if (cond.where == en_CondionsWhere.whereNotIn)
        query = query.where(cond.columnName, whereNotIn: cond.value);
      else if (cond.where == en_CondionsWhere.arrayContains)
        query = query.where(cond.columnName, arrayContains: cond.value);
      else if (cond.where == en_CondionsWhere.arrayContainsAny) query = query.where(cond.columnName, arrayContainsAny: cond.value);
    }
    QuerySnapshot snap = await query.get();
    WriteBatch batch = FirebaseFirestore.instance.batch();
    snap.docs.forEach((element) {
      batch.delete(colRef.doc(element.id));
    });
    batch.commit();
  }

  static Future<bool> fire_DeleteListMaster_And_Details(String docName, String subCollectionName) async {
    // specify Main Collection
    CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQty.name);
    // Mention to Document
    DocumentReference tablemasterDocref = coll.doc(docName);
    // Mention to subCollection
    CollectionReference subCollection = tablemasterDocref.collection(subCollectionName);
    // get all documents from subCollection
    QuerySnapshot snapshot = await subCollection.get();
    // delete process
    WriteBatch batch = FirebaseFirestore.instance.batch();
    // delete all sub documents & collections & fields
    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    // final delete from batch ==> commit : to submit all changes
    await batch.commit();
    coll.doc(docName).delete();
    return true;
  }

//**************************** Upload Files ****************************

  static Future<String> storage_UploadFile(String fileName, File file, {String pathOnStorage = ''}) async {
    pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Inv_RecivedQty.name : pathOnStorage;
    String fileDownloadURL = '';
    await firebase_storage.FirebaseStorage.instance.ref().child('${pathOnStorage}/${fileName}').putFile(file).then((fileUpload) async {
      await fileUpload.ref.getDownloadURL().then((URL) {
        fileDownloadURL = URL;
      });
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return fileDownloadURL;
  }

  static Future<String> storage_GetFileDowenloadURL(String fileName) async {
    String fileDownloadURL = '';
    await firebase_storage.FirebaseStorage.instance.ref().child('${en_TablesName.Inv_RecivedQty.name}/${fileName}').getDownloadURL().then((URL) {
      fileDownloadURL = URL;
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return fileDownloadURL;
  }

  static Future<bool> storage_DeleteFile(String fileName, {String pathOnStorage = ''}) async {
    bool result = false;
    pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Inv_RecivedQty.name : pathOnStorage;
    await firebase_storage.FirebaseStorage.instance.ref().child('${pathOnStorage}/${fileName}').delete().then((val) {
      result = true;
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return result;
  }
}
