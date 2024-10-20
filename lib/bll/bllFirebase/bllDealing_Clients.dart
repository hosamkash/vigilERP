import '../classModel/Dealing_Clients.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../shared/enumerators.dart';
import 'ManageBLL.dart';

class bllDealing_Clients {
  static List<String> ColumnsName = enTable_Dealing_Clients.values.map((item) => item.name).toList();
  static late List<Dealing_Clients> lstDealing_Clients = [];
  static late Dealing_Clients itemDealing_Clients;
  static String query = '';

//**************************** general function ****************************

  static Future<int> getMaxID_firestore() async {
    int maxID = 0;
    await FirebaseFirestore.instance
        .collection(en_TablesName.Dealing_Clients.name)
        .orderBy(enTable_Dealing_Clients.ID.name, descending: true)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        maxID = 1;
      } else {
        maxID = value.docs.first.get(enTable_Dealing_Clients.ID.name);
        maxID += 1;
      }
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return maxID;
  }

  static Future<int> getMax_firestore(enTable_Dealing_Clients colName, {BLLCondions? condion}) async {
    int maxID = 1;
    QuerySnapshot? snapshot;
    try {
      if (condion != null) {
        snapshot = await FirebaseFirestore.instance
            .collection(en_TablesName.Dealing_Clients.name)
            .where(condion.columnName, isEqualTo: condion.value)
            .orderBy(colName.name, descending: true)
            .limit(1)
            .get();
      } else if (condion == null) {
        snapshot =
            await FirebaseFirestore.instance.collection(en_TablesName.Dealing_Clients.name).orderBy(colName.name, descending: true).limit(1).get();
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
  static Future<String> fire_AddItem(Dealing_Clients itemDealing_Clients) async {
    String docCreatedName = '';
    await FirebaseFirestore.instance.collection(en_TablesName.Dealing_Clients.name).add(itemDealing_Clients.toMap()).then((val) {
      docCreatedName = val.id;
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return docCreatedName;
  }

  static Future<bool> fire_SetItemMap(String docName, Map<String, dynamic> itemDealing_Clients) async {
    bool result = false;
    await FirebaseFirestore.instance.collection(en_TablesName.Dealing_Clients.name).doc(docName).set(itemDealing_Clients).then((val) {
      result = true;
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return result;
  }

  static Future<bool> fire_SetItem(String docName, Dealing_Clients itemDealing_Clients) async {
    bool result = false;
    await FirebaseFirestore.instance.collection(en_TablesName.Dealing_Clients.name).doc(docName).set(itemDealing_Clients.toMap()).then((val) {
      result = true;
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return result;
  }

  static Future fire_setListMaster_And_Details({
    required String insertdDocID,
    required Dealing_Clients itemDealing_Clients,
    required String collectionDetailsName,
    required String columnNameAsDocumentDetails,
    required List<Map<String, dynamic>> detais,
    required List<Map<String, dynamic>> deletedItemsDetais,
  }) async {
    CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Dealing_Clients.name);
    DocumentReference tablemasterDocref = coll.doc(insertdDocID);
    WriteBatch batch = FirebaseFirestore.instance.batch();
    // save Master
    batch.set(tablemasterDocref, itemDealing_Clients.toMap());
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
    required List<Dealing_Clients> lstDealing_Clients,
  }) async {
    CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Dealing_Clients.name);
    WriteBatch batch = FirebaseFirestore.instance.batch();
    lstDealing_Clients.forEach((elm) {
      DocumentReference docRef = coll.doc(elm.ID.toString());
      batch.set(docRef, elm.toMap());
    });
    await batch.commit();
  }

//**************************** get ****************************

  static Future<Dealing_Clients> fire_getItem(String docName) async {
    late Dealing_Clients itemDealing_Clients;
    try {
      var retValue = await FirebaseFirestore.instance.collection(en_TablesName.Dealing_Clients.name).doc(docName).get();
      itemDealing_Clients = Dealing_Clients();
      itemDealing_Clients.ID = retValue.data()!['ID'];
      itemDealing_Clients.IDBranch = retValue.data()!['IDBranch'];
      itemDealing_Clients.Code = retValue.data()!['Code'];
      itemDealing_Clients.Name = retValue.data()!['Name'];
      itemDealing_Clients.IsActive = retValue.data()!['IsActive'];
      itemDealing_Clients.CurrentBalance = retValue.data()!['CurrentBalance'];
      itemDealing_Clients.BalanceType = retValue.data()!['BalanceType'];
      itemDealing_Clients.Mobile = retValue.data()!['Mobile'];
      itemDealing_Clients.Phone = retValue.data()!['Phone'];
      itemDealing_Clients.Address = retValue.data()!['Address'];
      itemDealing_Clients.Note = retValue.data()!['Note'];
      itemDealing_Clients.IDPriceType = retValue.data()!['IDPriceType'];
      itemDealing_Clients.CreditLimit = retValue.data()!['CreditLimit'];
      itemDealing_Clients.LocationLink = retValue.data()!['LocationLink'];
      itemDealing_Clients.LocationLatitude = retValue.data()!['LocationLatitude'];
      itemDealing_Clients.LocationLongitude = retValue.data()!['LocationLongitude'];
      itemDealing_Clients.LocationImage = retValue.data()!['LocationImage'];
      return itemDealing_Clients;
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  static Future<List<Dealing_Clients>> fire_getList() async {
    await FirebaseFirestore.instance.collection(en_TablesName.Dealing_Clients.name).get().then((value) {
      lstDealing_Clients.clear();
      value.docs.forEach((element) {
        lstDealing_Clients.add(Dealing_Clients.fromJson(element.data()));
      });
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return lstDealing_Clients;
  }

  static Future<List<Dealing_Clients>> fire_getListByBranch(int branchID, String BranchColumnName) async {
    await FirebaseFirestore.instance.collection(en_TablesName.Dealing_Clients.name).where(BranchColumnName, isEqualTo: branchID).get().then((value) {
      lstDealing_Clients.clear();
      value.docs.forEach((element) {
        lstDealing_Clients.add(Dealing_Clients.fromJson(element.data()));
      });
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return lstDealing_Clients;
  }

  static Future<List<Dealing_Clients>> fire_getListWithConditions({List<BLLCondions>? conditions}) async {
    CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Dealing_Clients.name);
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
    lstDealing_Clients.clear();
    snap.docs.forEach((element) {
      lstDealing_Clients.add(Dealing_Clients.fromJson(element.data() as Map<String, dynamic>));
    });
    return lstDealing_Clients;
  }

//**************************** delete ****************************

  static Future<bool> fire_DeleteItem(String docName) async {
    bool result = false;
    await FirebaseFirestore.instance.collection(en_TablesName.Dealing_Clients.name).doc(docName).delete().then((val) {
      result = true;
    }).catchError((error) {
      print(error.toString());
      result = false;
    });
    return result;
  }

  static Future fire_DeleteListMaster(List<BLLCondions> conditions) async {
    CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Dealing_Clients.name);
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
    CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Dealing_Clients.name);
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
    pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Dealing_Clients.name : pathOnStorage;
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
    await firebase_storage.FirebaseStorage.instance.ref().child('${en_TablesName.Dealing_Clients.name}/${fileName}').getDownloadURL().then((URL) {
      fileDownloadURL = URL;
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return fileDownloadURL;
  }

  static Future<bool> storage_DeleteFile(String fileName, {String pathOnStorage = ''}) async {
    bool result = false;
    pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Dealing_Clients.name : pathOnStorage;
    await firebase_storage.FirebaseStorage.instance.ref().child('${pathOnStorage}/${fileName}').delete().then((val) {
      result = true;
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
    return result;
  }
}
