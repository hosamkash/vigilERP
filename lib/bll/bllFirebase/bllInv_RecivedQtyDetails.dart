import '../classModel/Inv_RecivedQtyDetails.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../shared/enumerators.dart';
import 'ManageBLL.dart';


class bllInv_RecivedQtyDetails
	{
		static List<String> ColumnsName = enTable_Inv_RecivedQtyDetails.values.map((item) => item.name).toList();
			static late List<Inv_RecivedQtyDetails> lstInv_RecivedQtyDetails = [];
			static late Inv_RecivedQtyDetails itemInv_RecivedQtyDetails;
			static String query = '';

//**************************** general function ****************************

static Future<int> getMaxID_firestore() async {
	int maxID = 0;
	await FirebaseFirestore.instance
	.collection(en_TablesName.Inv_RecivedQtyDetails.name)
	.orderBy(enTable_Inv_RecivedQtyDetails.ID.name, descending: true)
	.limit(1).get().then((value) {
	if (value.docs.isEmpty) {maxID = 1;}
	else {
	maxID = value.docs.first.get(enTable_Inv_RecivedQtyDetails.ID.name);
	maxID += 1;}
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return maxID;
}

static Future<int> getMax_firestore(enTable_Inv_RecivedQtyDetails colName, {BLLCondions? condion}) async {
	int maxID = 1;
	QuerySnapshot? snapshot;
	 try {if (condion != null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.Inv_RecivedQtyDetails.name)
	.where(condion.columnName, isEqualTo: condion.value)
	.orderBy(colName.name, descending: true)
	.limit(1).get();} else if (condion == null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.Inv_RecivedQtyDetails.name)
	.orderBy(colName.name, descending: true)
	.limit(1).get();}
	if (snapshot != null && snapshot.docs.isNotEmpty) {
	maxID = snapshot.docs.first.get(colName.name);
	maxID += 1;}} catch (error) {
	print(error.toString());throw error;}return maxID;
}


//**************************** add & set ****************************

/// هو إسم الكلاس والإضافة بتكون بكون عشوائي ولا يمكن للمستخدم تحديده collection وبيكون ال  FirebaseFirestore تستخدم للإضافة فى
static Future<String> fire_AddItem(Inv_RecivedQtyDetails  itemInv_RecivedQtyDetails) async {
	String docCreatedName = '';
	await FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQtyDetails.name).add(itemInv_RecivedQtyDetails.toMap()).then((val) {
	docCreatedName = val.id;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return docCreatedName;
}

static Future<bool> fire_SetItemMap(String docName, Map<String, dynamic>  itemInv_RecivedQtyDetails) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQtyDetails.name).doc(docName).set(itemInv_RecivedQtyDetails).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future<bool> fire_SetItem(String docName, Inv_RecivedQtyDetails  itemInv_RecivedQtyDetails) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQtyDetails.name).doc(docName).set(itemInv_RecivedQtyDetails.toMap()).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future fire_setListMaster_And_Details(
	{required String insertdDocID,
	required Inv_RecivedQtyDetails  itemInv_RecivedQtyDetails,
	required String collectionDetailsName,
	required String columnNameAsDocumentDetails,
	required List<Map<String, dynamic>> detais,
	required List<Map<String, dynamic>> deletedItemsDetais,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQtyDetails.name);
	DocumentReference tablemasterDocref = coll.doc(insertdDocID);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	// save Master
	batch.set(tablemasterDocref,  itemInv_RecivedQtyDetails.toMap());
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
	required List<Inv_RecivedQtyDetails> lstInv_RecivedQtyDetails,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQtyDetails.name);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	lstInv_RecivedQtyDetails.forEach((elm){
	DocumentReference docRef = coll.doc(elm.ID.toString());
	batch.set(docRef, elm.toMap());
	});
	await batch.commit();
}


//**************************** get ****************************

static Future<Inv_RecivedQtyDetails> fire_getItem(String docName) async {
	late Inv_RecivedQtyDetails  itemInv_RecivedQtyDetails;
	try { var retValue = await FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQtyDetails.name).doc(docName).get();
	 itemInv_RecivedQtyDetails = Inv_RecivedQtyDetails();
 itemInv_RecivedQtyDetails.ID = retValue.data()!['ID']; itemInv_RecivedQtyDetails.IDRecived = retValue.data()!['IDRecived']; itemInv_RecivedQtyDetails.IDProduct = retValue.data()!['IDProduct']; itemInv_RecivedQtyDetails.Barcode = retValue.data()!['Barcode']; itemInv_RecivedQtyDetails.IDClassefication = retValue.data()!['IDClassefication']; itemInv_RecivedQtyDetails.IDProductionCompanies = retValue.data()!['IDProductionCompanies']; itemInv_RecivedQtyDetails.UnitBig_ID = retValue.data()!['UnitBig_ID']; itemInv_RecivedQtyDetails.UnitBig_Price = retValue.data()!['UnitBig_Price']; itemInv_RecivedQtyDetails.UnitBig_Qty = retValue.data()!['UnitBig_Qty']; itemInv_RecivedQtyDetails.UnitCountOf = retValue.data()!['UnitCountOf']; itemInv_RecivedQtyDetails.UnitSmall_ID = retValue.data()!['UnitSmall_ID']; itemInv_RecivedQtyDetails.UnitSmall_Price = retValue.data()!['UnitSmall_Price']; itemInv_RecivedQtyDetails.UnitSmall_Qty = retValue.data()!['UnitSmall_Qty']; itemInv_RecivedQtyDetails.isBigUnit = retValue.data()!['isBigUnit']; itemInv_RecivedQtyDetails.TotalPrice = retValue.data()!['TotalPrice']; itemInv_RecivedQtyDetails.PriceType = retValue.data()!['PriceType']; itemInv_RecivedQtyDetails.RecivedUnitBig_ID = retValue.data()!['RecivedUnitBig_ID']; itemInv_RecivedQtyDetails.RecivedUnitBig_Price = retValue.data()!['RecivedUnitBig_Price']; itemInv_RecivedQtyDetails.RecivedUnitBig_Qty = retValue.data()!['RecivedUnitBig_Qty']; itemInv_RecivedQtyDetails.RecivedUnitSmall_ID = retValue.data()!['RecivedUnitSmall_ID']; itemInv_RecivedQtyDetails.RecivedUnitSmall_Price = retValue.data()!['RecivedUnitSmall_Price']; itemInv_RecivedQtyDetails.RecivedUnitSmall_Qty = retValue.data()!['RecivedUnitSmall_Qty']; itemInv_RecivedQtyDetails.RecivedisBigUnit = retValue.data()!['RecivedisBigUnit']; itemInv_RecivedQtyDetails.RecivedTotalPrice = retValue.data()!['RecivedTotalPrice'];	return  itemInv_RecivedQtyDetails;
	} catch (error) {
	print(error.toString()); throw error;
	}
}

static Future<List<Inv_RecivedQtyDetails>> fire_getList() async {
	await FirebaseFirestore.instance
	.collection(en_TablesName.Inv_RecivedQtyDetails.name)
	.get()
	.then((value) {
	lstInv_RecivedQtyDetails.clear();
	value.docs.forEach((element) {
	lstInv_RecivedQtyDetails.add(Inv_RecivedQtyDetails.fromJson(element.data()));
	});
	}).catchError((error) {
print(error.toString()); throw error;
});
return lstInv_RecivedQtyDetails;
}

static Future<List<Inv_RecivedQtyDetails>> fire_getListByBranch(int branchID , String BranchColumnName) async {
	await FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQtyDetails.name)
	.where(BranchColumnName, isEqualTo: branchID).get()
	.then((value) {lstInv_RecivedQtyDetails.clear();value.docs.forEach((element) {
	lstInv_RecivedQtyDetails.add(Inv_RecivedQtyDetails.fromJson(element.data()));});
	}).catchError((error) {print(error.toString());throw error;});
	return lstInv_RecivedQtyDetails;
}

static Future<List<Inv_RecivedQtyDetails>> fire_getListWithConditions({List<BLLCondions>? conditions}) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQtyDetails.name);
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
	lstInv_RecivedQtyDetails.clear();
	snap.docs.forEach((element) {
	lstInv_RecivedQtyDetails.add(Inv_RecivedQtyDetails.fromJson(element.data() as Map<String, dynamic> )); });
	return lstInv_RecivedQtyDetails;
}


//**************************** delete ****************************

static Future<bool> fire_DeleteItem(String docName) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQtyDetails.name).doc(docName).delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); 
	result = false;
	});
	return result;
	}

static Future fire_DeleteListMaster(List<BLLCondions> conditions) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQtyDetails.name);
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
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Inv_RecivedQtyDetails.name);
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
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Inv_RecivedQtyDetails.name : pathOnStorage;
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
	await firebase_storage.FirebaseStorage.instance.ref().child('${en_TablesName.Inv_RecivedQtyDetails.name}/${fileName}').getDownloadURL().then((URL) {
	fileDownloadURL = URL;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return fileDownloadURL;
}

static Future<bool> storage_DeleteFile(String fileName ,{String pathOnStorage = ''}) async {
	bool result = false;
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Inv_RecivedQtyDetails.name : pathOnStorage;
	await firebase_storage.FirebaseStorage.instance.ref().child('${pathOnStorage}/${fileName}').delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
	}

	}

