
import '../classModel/Inv_PermissionAdd.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../shared/enumerators.dart';
import '../classModel/Inv_PermissionAddDetails.dart';
import 'ManageBLL.dart';


class bllInv_PermissionAdd
	{
		static List<String> ColumnsName = enTable_Inv_PermissionAdd.values.map((item) => item.name).toList();
			static late List<Inv_PermissionAdd> lstInv_PermissionAdd = [];
			static late Inv_PermissionAdd itemInv_PermissionAdd;
			static String query = '';
	static List<Inv_PermissionAddDetails> lstInv_PermissionAddDetails = [];

//**************************** general function ****************************

static Future<int> getMaxID_firestore() async {
	int maxID = 0;
	await FirebaseFirestore.instance
	.collection(en_TablesName.Inv_PermissionAdd.name)
	.orderBy(enTable_Inv_PermissionAdd.ID.name, descending: true)
	.limit(1).get().then((value) {
	if (value.docs.isEmpty) {maxID = 1;}
	else {
	maxID = value.docs.first.get(enTable_Inv_PermissionAdd.ID.name);
	maxID += 1;}
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return maxID;
}

static Future<int> getMax_firestore(enTable_Inv_PermissionAdd colName, {BLLCondions? condion}) async {
	int maxID = 1;
	QuerySnapshot? snapshot;
	 try {if (condion != null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.Inv_PermissionAdd.name)
	.where(condion.columnName, isEqualTo: condion.value)
	.orderBy(colName.name, descending: true)
	.limit(1).get();} else if (condion == null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.Inv_PermissionAdd.name)
	.orderBy(colName.name, descending: true)
	.limit(1).get();}
	if (snapshot != null && snapshot.docs.isNotEmpty) {
	maxID = snapshot.docs.first.get(colName.name);
	maxID += 1;}} catch (error) {
	print(error.toString());throw error;}return maxID;
}


//**************************** add & set ****************************

/// هو إسم الكلاس والإضافة بتكون بكون عشوائي ولا يمكن للمستخدم تحديده collection وبيكون ال  FirebaseFirestore تستخدم للإضافة فى
static Future<String> fire_AddItem(Inv_PermissionAdd  itemInv_PermissionAdd) async {
	String docCreatedName = '';
	await FirebaseFirestore.instance.collection(en_TablesName.Inv_PermissionAdd.name).add(itemInv_PermissionAdd.toMap()).then((val) {
	docCreatedName = val.id;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return docCreatedName;
}

static Future<bool> fire_SetItemMap(String docName, Map<String, dynamic>  itemInv_PermissionAdd) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Inv_PermissionAdd.name).doc(docName).set(itemInv_PermissionAdd).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future<bool> fire_SetItem(String docName, Inv_PermissionAdd  itemInv_PermissionAdd) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Inv_PermissionAdd.name).doc(docName).set(itemInv_PermissionAdd.toMap()).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future fire_setListMaster_And_Details(
	{required String insertdDocID,
	required Inv_PermissionAdd  itemInv_PermissionAdd,
	required String collectionDetailsName,
	required String columnNameAsDocumentDetails,
	required List<Map<String, dynamic>> detais,
	required List<Map<String, dynamic>> deletedItemsDetais,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Inv_PermissionAdd.name);
	DocumentReference tablemasterDocref = coll.doc(insertdDocID);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	// save Master
	batch.set(tablemasterDocref,  itemInv_PermissionAdd.toMap());
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
	required List<Inv_PermissionAdd> lstInv_PermissionAdd,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Inv_PermissionAdd.name);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	lstInv_PermissionAdd.forEach((elm){
	DocumentReference docRef = coll.doc(elm.ID.toString());
	batch.set(docRef, elm.toMap());
	});
	await batch.commit();
}


//**************************** get ****************************

static Future<Inv_PermissionAdd> fire_getItem(String docName) async {
	late Inv_PermissionAdd  itemInv_PermissionAdd;
	try { var retValue = await FirebaseFirestore.instance.collection(en_TablesName.Inv_PermissionAdd.name).doc(docName).get();
	 itemInv_PermissionAdd = Inv_PermissionAdd();
 itemInv_PermissionAdd.ID = retValue.data()!['ID']; itemInv_PermissionAdd.IDBranch = retValue.data()!['IDBranch']; itemInv_PermissionAdd.Code = retValue.data()!['Code']; itemInv_PermissionAdd.Date = retValue.data()!['Date']; itemInv_PermissionAdd.Time = retValue.data()!['Time']; itemInv_PermissionAdd.IDStock = retValue.data()!['IDStock']; itemInv_PermissionAdd.IDEmployee = retValue.data()!['IDEmployee']; itemInv_PermissionAdd.IDRequestStatus = retValue.data()!['IDRequestStatus']; itemInv_PermissionAdd.Note = retValue.data()!['Note']; itemInv_PermissionAdd.Value = retValue.data()!['Value']; itemInv_PermissionAdd.UID = retValue.data()!['UID'];	return  itemInv_PermissionAdd;
	} catch (error) {
	print(error.toString()); throw error;
	}
}

static Future<List<Inv_PermissionAdd>> fire_getList() async {
	await FirebaseFirestore.instance
	.collection(en_TablesName.Inv_PermissionAdd.name)
	.get()
	.then((value) {
	lstInv_PermissionAdd.clear();
	value.docs.forEach((element) {
	lstInv_PermissionAdd.add(Inv_PermissionAdd.fromJson(element.data()));
	});
	}).catchError((error) {
print(error.toString()); throw error;
});
return lstInv_PermissionAdd;
}

static Future<List<Inv_PermissionAddDetails>> fire_getListDetails(String IDMaster, String TableNameDetails) async {
	try {
	//**************** 1 - Master Date
	DocumentSnapshot doc = await FirebaseFirestore.instance.collection(en_TablesName.Inv_PermissionAdd.name).doc(IDMaster).get();

	//**************** 2 - Details Data
	QuerySnapshot<Map<String, dynamic>> collRef = await doc.reference.collection(TableNameDetails).get();
	lstInv_PermissionAddDetails.clear();
	collRef.docs.forEach((element) {
	lstInv_PermissionAddDetails.add(Inv_PermissionAddDetails.fromJson(element.data()));
	});
	} catch (error) {
	print(error.toString());
	throw error;
	}
	return lstInv_PermissionAddDetails;
}

static Future<List<Inv_PermissionAdd>> fire_getListByBranch(int branchID , String BranchColumnName) async {
	await FirebaseFirestore.instance.collection(en_TablesName.Inv_PermissionAdd.name)
	.where(BranchColumnName, isEqualTo: branchID).get()
	.then((value) {lstInv_PermissionAdd.clear();value.docs.forEach((element) {
	lstInv_PermissionAdd.add(Inv_PermissionAdd.fromJson(element.data()));});
	}).catchError((error) {print(error.toString());throw error;});
	return lstInv_PermissionAdd;
}

static Future<List<Inv_PermissionAdd>> fire_getListWithConditions({List<BLLCondions>? conditions}) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Inv_PermissionAdd.name);
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
	lstInv_PermissionAdd.clear();
	snap.docs.forEach((element) {
	lstInv_PermissionAdd.add(Inv_PermissionAdd.fromJson(element.data() as Map<String, dynamic> )); });
	return lstInv_PermissionAdd;
}


//**************************** delete ****************************

static Future<bool> fire_DeleteItem(String docName) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Inv_PermissionAdd.name).doc(docName).delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); 
	result = false;
	});
	return result;
	}

static Future fire_DeleteListMaster(List<BLLCondions> conditions) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Inv_PermissionAdd.name);
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
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Inv_PermissionAdd.name);
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
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Inv_PermissionAdd.name : pathOnStorage;
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
	await firebase_storage.FirebaseStorage.instance.ref().child('${en_TablesName.Inv_PermissionAdd.name}/${fileName}').getDownloadURL().then((URL) {
	fileDownloadURL = URL;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return fileDownloadURL;
}

static Future<bool> storage_DeleteFile(String fileName ,{String pathOnStorage = ''}) async {
	bool result = false;
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Inv_PermissionAdd.name : pathOnStorage;
	await firebase_storage.FirebaseStorage.instance.ref().child('${pathOnStorage}/${fileName}').delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
	}

	}

