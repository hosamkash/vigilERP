import '../classModel/Fina_ClosedTreasure.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../shared/enumerators.dart';
import 'ManageBLL.dart';


class bllFina_ClosedTreasure
	{
		static List<String> ColumnsName = enTable_Fina_ClosedTreasure.values.map((item) => item.name).toList();
			static late List<Fina_ClosedTreasure> lstFina_ClosedTreasure = [];
			static late Fina_ClosedTreasure itemFina_ClosedTreasure;
			static String query = '';

//**************************** general function ****************************

static Future<int> getMaxID_firestore() async {
	int maxID = 0;
	await FirebaseFirestore.instance
	.collection(en_TablesName.Fina_ClosedTreasure.name)
	.orderBy(enTable_Fina_ClosedTreasure.ID.name, descending: true)
	.limit(1).get().then((value) {
	if (value.docs.isEmpty) {maxID = 1;}
	else {
	maxID = value.docs.first.get(enTable_Fina_ClosedTreasure.ID.name);
	maxID += 1;}
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return maxID;
}

static Future<int> getMax_firestore(enTable_Fina_ClosedTreasure colName, {BLLCondions? condion}) async {
	int maxID = 1;
	QuerySnapshot? snapshot;
	 try {if (condion != null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.Fina_ClosedTreasure.name)
	.where(condion.columnName, isEqualTo: condion.value)
	.orderBy(colName.name, descending: true)
	.limit(1).get();} else if (condion == null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.Fina_ClosedTreasure.name)
	.orderBy(colName.name, descending: true)
	.limit(1).get();}
	if (snapshot != null && snapshot.docs.isNotEmpty) {
	maxID = snapshot.docs.first.get(colName.name);
	maxID += 1;}} catch (error) {
	print(error.toString());throw error;}return maxID;
}


//**************************** add & set ****************************

/// هو إسم الكلاس والإضافة بتكون بكون عشوائي ولا يمكن للمستخدم تحديده collection وبيكون ال  FirebaseFirestore تستخدم للإضافة فى
static Future<String> fire_AddItem(Fina_ClosedTreasure  itemFina_ClosedTreasure) async {
	String docCreatedName = '';
	await FirebaseFirestore.instance.collection(en_TablesName.Fina_ClosedTreasure.name).add(itemFina_ClosedTreasure.toMap()).then((val) {
	docCreatedName = val.id;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return docCreatedName;
}

static Future<bool> fire_SetItemMap(String docName, Map<String, dynamic>  itemFina_ClosedTreasure) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Fina_ClosedTreasure.name).doc(docName).set(itemFina_ClosedTreasure).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future<bool> fire_SetItem(String docName, Fina_ClosedTreasure  itemFina_ClosedTreasure) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Fina_ClosedTreasure.name).doc(docName).set(itemFina_ClosedTreasure.toMap()).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future fire_setListMaster_And_Details(
	{required String insertdDocID,
	required Fina_ClosedTreasure  itemFina_ClosedTreasure,
	required String collectionDetailsName,
	required String columnNameAsDocumentDetails,
	required List<Map<String, dynamic>> detais,
	required List<Map<String, dynamic>> deletedItemsDetais,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Fina_ClosedTreasure.name);
	DocumentReference tablemasterDocref = coll.doc(insertdDocID);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	// save Master
	batch.set(tablemasterDocref,  itemFina_ClosedTreasure.toMap());
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
	required List<Fina_ClosedTreasure> lstFina_ClosedTreasure,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Fina_ClosedTreasure.name);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	lstFina_ClosedTreasure.forEach((elm){
	DocumentReference docRef = coll.doc(elm.ID.toString());
	batch.set(docRef, elm.toMap());
	});
	await batch.commit();
}


//**************************** get ****************************

static Future<Fina_ClosedTreasure> fire_getItem(String docName) async {
	late Fina_ClosedTreasure  itemFina_ClosedTreasure;
	try { var retValue = await FirebaseFirestore.instance.collection(en_TablesName.Fina_ClosedTreasure.name).doc(docName).get();
	 itemFina_ClosedTreasure = Fina_ClosedTreasure();
 itemFina_ClosedTreasure.ID = retValue.data()!['ID']; itemFina_ClosedTreasure.Code = retValue.data()!['Code']; itemFina_ClosedTreasure.Date = retValue.data()!['Date']; itemFina_ClosedTreasure.Time = retValue.data()!['Time']; itemFina_ClosedTreasure.IDEmployee = retValue.data()!['IDEmployee']; itemFina_ClosedTreasure.IDBranchFrom = retValue.data()!['IDBranchFrom']; itemFina_ClosedTreasure.IDTreasurFrom = retValue.data()!['IDTreasurFrom']; itemFina_ClosedTreasure.BalanceTreasurFrom = retValue.data()!['BalanceTreasurFrom']; itemFina_ClosedTreasure.IDBranchTo = retValue.data()!['IDBranchTo']; itemFina_ClosedTreasure.IDTreasurTo = retValue.data()!['IDTreasurTo']; itemFina_ClosedTreasure.BalanceTreasurTo = retValue.data()!['BalanceTreasurTo']; itemFina_ClosedTreasure.Value = retValue.data()!['Value']; itemFina_ClosedTreasure.Note = retValue.data()!['Note']; itemFina_ClosedTreasure.UID = retValue.data()!['UID']; itemFina_ClosedTreasure.IsClosed = retValue.data()!['IsClosed'];	return  itemFina_ClosedTreasure;
	} catch (error) {
	print(error.toString()); throw error;
	}
}

static Future<List<Fina_ClosedTreasure>> fire_getList() async {
	await FirebaseFirestore.instance
	.collection(en_TablesName.Fina_ClosedTreasure.name)
	.get()
	.then((value) {
	lstFina_ClosedTreasure.clear();
	value.docs.forEach((element) {
	lstFina_ClosedTreasure.add(Fina_ClosedTreasure.fromJson(element.data()));
	});
	}).catchError((error) {
print(error.toString()); throw error;
});
return lstFina_ClosedTreasure;
}

static Future<List<Fina_ClosedTreasure>> fire_getListByBranch(int branchID , String BranchColumnName) async {
	await FirebaseFirestore.instance.collection(en_TablesName.Fina_ClosedTreasure.name)
	.where(BranchColumnName, isEqualTo: branchID).get()
	.then((value) {lstFina_ClosedTreasure.clear();value.docs.forEach((element) {
	lstFina_ClosedTreasure.add(Fina_ClosedTreasure.fromJson(element.data()));});
	}).catchError((error) {print(error.toString());throw error;});
	return lstFina_ClosedTreasure;
}

static Future<List<Fina_ClosedTreasure>> fire_getListWithConditions({List<BLLCondions>? conditions}) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Fina_ClosedTreasure.name);
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
	else if (cond.where == en_CondionsWhere.arrayContainsAny)
	query = query.where(cond.columnName, arrayContainsAny: cond.value);
	}
}
	QuerySnapshot snap = await query.get();
	lstFina_ClosedTreasure.clear();
	snap.docs.forEach((element) {
	lstFina_ClosedTreasure.add(Fina_ClosedTreasure.fromJson(element.data() as Map<String, dynamic> )); });
	return lstFina_ClosedTreasure;
}


//**************************** delete ****************************

static Future<bool> fire_DeleteItem(String docName) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Fina_ClosedTreasure.name).doc(docName).delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); 
	result = false;
	});
	return result;
	}

static Future fire_DeleteListMaster(List<BLLCondions> conditions) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Fina_ClosedTreasure.name);
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
	else if (cond.where == en_CondionsWhere.arrayContainsAny)
	query = query.where(cond.columnName, arrayContainsAny: cond.value);
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
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Fina_ClosedTreasure.name);
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
	batch.delete(doc.reference); }
	// final delete from batch ==> commit : to submit all changes
	await batch.commit();
	coll.doc(docName).delete();
	return true;
}


//**************************** Upload Files ****************************

static Future<String> storage_UploadFile(String fileName, File file ,{String pathOnStorage = ''}) async {
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Fina_ClosedTreasure.name : pathOnStorage;
	String fileDownloadURL = '';
	await firebase_storage.FirebaseStorage.instance.ref().child('${pathOnStorage}/${fileName}').putFile(file).then((fileUpload) async {
	await fileUpload.ref.getDownloadURL().then((URL) {
	fileDownloadURL = URL;
	});
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return fileDownloadURL;
}

static Future<String> storage_GetFileDowenloadURL(String fileName) async {
	String fileDownloadURL = '';
	await firebase_storage.FirebaseStorage.instance.ref().child('${en_TablesName.Fina_ClosedTreasure.name}/${fileName}').getDownloadURL().then((URL) {
	fileDownloadURL = URL;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return fileDownloadURL;
}

static Future<bool> storage_DeleteFile(String fileName ,{String pathOnStorage = ''}) async {
	bool result = false;
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Fina_ClosedTreasure.name : pathOnStorage;
	await firebase_storage.FirebaseStorage.instance.ref().child('${pathOnStorage}/${fileName}').delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
	}

	}

