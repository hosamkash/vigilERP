import '../classModel/Invoices_Purchase.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../shared/enumerators.dart';
import '../classModel/Invoices_PurchaseDetails.dart';
import 'ManageBLL.dart';

class bllInvoices_Purchase {
  static List<String> ColumnsName = enTable_Invoices_Purchase.values.map((item) => item.name).toList();
  static late List<Invoices_Purchase> lstInvoices_Purchase = [];
  static late Invoices_Purchase itemInvoices_Purchase;
  static String query = '';
  static List<Invoices_PurchaseDetails> lstInvoices_PurchaseDetails = [];

//**************************** general function ****************************

  static Future<int> getMaxID_firestore() async {
    int maxID = 0;
    await FirebaseFirestore.instance
        .collection(en_TablesName.Invoices_Purchase.name)
        .orderBy(enTable_Invoices_Purchase.ID.name, descending: true)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        maxID = 1;
      } else {
        maxID = value.docs.first.get(enTable_Invoices_Purchase.ID.name);
        maxID += 1;
      }
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return maxID;
  }

  static Future<int> getMax_firestore(enTable_Invoices_Purchase colName, {BLLCondions? condion}) async {
    int maxID = 1;
    QuerySnapshot? snapshot;
    try {
      if (condion != null) {
        snapshot = await FirebaseFirestore.instance
            .collection(en_TablesName.Invoices_Purchase.name)
            .where(condion.columnName, isEqualTo: condion.value)
            .orderBy(colName.name, descending: true)
            .limit(1)
            .get();
      } else if (condion == null) {
        snapshot =
            await FirebaseFirestore.instance.collection(en_TablesName.Invoices_Purchase.name).orderBy(colName.name, descending: true).limit(1).get();
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
  static Future<String> fire_AddItem(Invoices_Purchase itemInvoices_Purchase) async {
    String docCreatedName = '';
    await FirebaseFirestore.instance.collection(en_TablesName.Invoices_Purchase.name).add(itemInvoices_Purchase.toMap()).then((val) {
      docCreatedName = val.id;
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return docCreatedName;
  }

  static Future<bool> fire_SetItemMap(String docName, Map<String, dynamic> itemInvoices_Purchase) async {
    bool result = false;
    await FirebaseFirestore.instance.collection(en_TablesName.Invoices_Purchase.name).doc(docName).set(itemInvoices_Purchase).then((val) {
      result = true;
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return result;
  }

  static Future<bool> fire_SetItem(String docName, Invoices_Purchase itemInvoices_Purchase) async {
    bool result = false;
    await FirebaseFirestore.instance.collection(en_TablesName.Invoices_Purchase.name).doc(docName).set(itemInvoices_Purchase.toMap()).then((val) {
      result = true;
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return result;
  }

  static Future fire_setListMaster_And_Details({
    required String insertdDocID,
    required Invoices_Purchase itemInvoices_Purchase,
    required String collectionDetailsName,
    required String columnNameAsDocumentDetails,
    required List<Map<String, dynamic>> detais,
    required List<Map<String, dynamic>> deletedItemsDetais,
  }) async {
    CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Invoices_Purchase.name);
    DocumentReference tablemasterDocref = coll.doc(insertdDocID);
    WriteBatch batch = FirebaseFirestore.instance.batch();
    // save Master
    batch.set(tablemasterDocref, itemInvoices_Purchase.toMap());
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
    required List<Invoices_Purchase> lstInvoices_Purchase,
  }) async {
    CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Invoices_Purchase.name);
    WriteBatch batch = FirebaseFirestore.instance.batch();
    lstInvoices_Purchase.forEach((elm) {
      DocumentReference docRef = coll.doc(elm.ID.toString());
      batch.set(docRef, elm.toMap());
    });
    await batch.commit();
  }

//**************************** get ****************************

  static Future<Invoices_Purchase> fire_getItem(String docName) async {
    late Invoices_Purchase itemInvoices_Purchase;
    try {
      var retValue = await FirebaseFirestore.instance.collection(en_TablesName.Invoices_Purchase.name).doc(docName).get();
      itemInvoices_Purchase = Invoices_Purchase();
      itemInvoices_Purchase.ID = retValue.data()!['ID'];
      itemInvoices_Purchase.Code = retValue.data()!['Code'];
      itemInvoices_Purchase.Date = retValue.data()!['Date'];
      itemInvoices_Purchase.Time = retValue.data()!['Time'];
      itemInvoices_Purchase.IDBranch = retValue.data()!['IDBranch'];
      itemInvoices_Purchase.IDStock = retValue.data()!['IDStock'];
      itemInvoices_Purchase.IDEmployee = retValue.data()!['IDEmployee'];
      itemInvoices_Purchase.IDVendor = retValue.data()!['IDVendor'];
      itemInvoices_Purchase.VendorSerial = retValue.data()!['VendorSerial'];
      itemInvoices_Purchase.TotalValue = retValue.data()!['TotalValue'];
      itemInvoices_Purchase.DiscountValue = retValue.data()!['DiscountValue'];
      itemInvoices_Purchase.DiscountPercent = retValue.data()!['DiscountPercent'];
      itemInvoices_Purchase.NetValue = retValue.data()!['NetValue'];
      itemInvoices_Purchase.IsClosed = retValue.data()!['IsClosed'];
      itemInvoices_Purchase.Note = retValue.data()!['Note'];
      itemInvoices_Purchase.UID = retValue.data()!['UID'];
      itemInvoices_Purchase.CurrentBalance = retValue.data()!['CurrentBalance'];
      return itemInvoices_Purchase;
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  static Future<List<Invoices_Purchase>> fire_getList() async {
    await FirebaseFirestore.instance.collection(en_TablesName.Invoices_Purchase.name).get().then((value) {
      lstInvoices_Purchase.clear();
      value.docs.forEach((element) {
        lstInvoices_Purchase.add(Invoices_Purchase.fromJson(element.data()));
      });
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return lstInvoices_Purchase;
  }

  static Future<List<Invoices_PurchaseDetails>> fire_getListDetails(String IDMaster, String TableNameDetails) async {
    try {
      //**************** 1 - Master Date
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection(en_TablesName.Invoices_Purchase.name).doc(IDMaster).get();

      //**************** 2 - Details Data
      QuerySnapshot<Map<String, dynamic>> collRef = await doc.reference.collection(TableNameDetails).get();
      lstInvoices_PurchaseDetails.clear();
      collRef.docs.forEach((element) {
        lstInvoices_PurchaseDetails.add(Invoices_PurchaseDetails.fromJson(element.data()));
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
    return lstInvoices_PurchaseDetails;
  }

  static Future<List<Invoices_Purchase>> fire_getListByBranch(int branchID, String BranchColumnName) async {
    await FirebaseFirestore.instance
        .collection(en_TablesName.Invoices_Purchase.name)
        .where(BranchColumnName, isEqualTo: branchID)
        .get()
        .then((value) {
      lstInvoices_Purchase.clear();
      value.docs.forEach((element) {
        lstInvoices_Purchase.add(Invoices_Purchase.fromJson(element.data()));
      });
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return lstInvoices_Purchase;
  }

  static Future<List<Invoices_Purchase>> fire_getListWithConditions({List<BLLCondions>? conditions}) async {
    CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Invoices_Purchase.name);
    Query query = colRef;
    if (conditions != null) {
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
    lstInvoices_Purchase.clear();
    snap.docs.forEach((element) {
      lstInvoices_Purchase.add(Invoices_Purchase.fromJson(element.data() as Map<String, dynamic>));
    });
    return lstInvoices_Purchase;
  }

//**************************** delete ****************************

  static Future<bool> fire_DeleteItem(String docName) async {
    bool result = false;
    await FirebaseFirestore.instance.collection(en_TablesName.Invoices_Purchase.name).doc(docName).delete().then((val) {
      result = true;
    }).catchError((error) {
      print(error.toString());
      result = false;
    });
    return result;
  }

  static Future fire_DeleteListMaster(List<BLLCondions> conditions) async {
    CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Invoices_Purchase.name);
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
    CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Invoices_Purchase.name);
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
    pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Invoices_Purchase.name : pathOnStorage;
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
    await firebase_storage.FirebaseStorage.instance.ref().child('${en_TablesName.Invoices_Purchase.name}/${fileName}').getDownloadURL().then((URL) {
      fileDownloadURL = URL;
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return fileDownloadURL;
  }

  static Future<bool> storage_DeleteFile(String fileName, {String pathOnStorage = ''}) async {
    bool result = false;
    pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Invoices_Purchase.name : pathOnStorage;
    await firebase_storage.FirebaseStorage.instance.ref().child('${pathOnStorage}/${fileName}').delete().then((val) {
      result = true;
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return result;
  }
}
