import '../classModel/Def_ProductStructure.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../shared/enumerators.dart';
import 'ManageBLL.dart';


class bllDef_ProductStructure
	{
		static List<String> ColumnsName = enTable_Def_ProductStructure.values.map((item) => item.name).toList();
			static late List<Def_ProductStructure> lstDef_ProductStructure = [];
			static late Def_ProductStructure itemDef_ProductStructure;
			static String query = '';

//**************************** general function ****************************

static Future<int> getMaxID_firestore() async {
	int maxID = 0;
	await FirebaseFirestore.instance
	.collection(en_TablesName.Def_ProductStructure.name)
	.orderBy(enTable_Def_ProductStructure.ID.name, descending: true)
	.limit(1).get().then((value) {
	if (value.docs.isEmpty) {maxID = 1;}
	else {
	maxID = value.docs.first.get(enTable_Def_ProductStructure.ID.name);
	maxID += 1;}
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return maxID;
}

static Future<int> getMax_firestore(enTable_Def_ProductStructure colName, {BLLCondions? condion}) async {
	int maxID = 1;
	QuerySnapshot? snapshot;
	 try {if (condion != null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.Def_ProductStructure.name)
	.where(condion.columnName, isEqualTo: condion.value)
	.orderBy(colName.name, descending: true)
	.limit(1).get();} else if (condion == null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.Def_ProductStructure.name)
	.orderBy(colName.name, descending: true)
	.limit(1).get();}
	if (snapshot != null && snapshot.docs.isNotEmpty) {
	maxID = snapshot.docs.first.get(colName.name);
	maxID += 1;}} catch (error) {
	print(error.toString());throw error;}return maxID;
}


//**************************** add & set ****************************

/// هو إسم الكلاس والإضافة بتكون بكون عشوائي ولا يمكن للمستخدم تحديده collection وبيكون ال  FirebaseFirestore تستخدم للإضافة فى
static Future<String> fire_AddItem(Def_ProductStructure  itemDef_ProductStructure) async {
	String docCreatedName = '';
	await FirebaseFirestore.instance.collection(en_TablesName.Def_ProductStructure.name).add(itemDef_ProductStructure.toMap()).then((val) {
	docCreatedName = val.id;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return docCreatedName;
}

static Future<bool> fire_SetItemMap(String docName, Map<String, dynamic>  itemDef_ProductStructure) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Def_ProductStructure.name).doc(docName).set(itemDef_ProductStructure).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future<bool> fire_SetItem(String docName, Def_ProductStructure  itemDef_ProductStructure) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Def_ProductStructure.name).doc(docName).set(itemDef_ProductStructure.toMap()).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future fire_setListMaster_And_Details(
	{required String insertdDocID,
	required Def_ProductStructure  itemDef_ProductStructure,
	required String collectionDetailsName,
	required String columnNameAsDocumentDetails,
	required List<Map<String, dynamic>> detais,
	required List<Map<String, dynamic>> deletedItemsDetais,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Def_ProductStructure.name);
	DocumentReference tablemasterDocref = coll.doc(insertdDocID);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	// save Master
	batch.set(tablemasterDocref,  itemDef_ProductStructure.toMap());
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
	required List<Def_ProductStructure> lstDef_ProductStructure,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Def_ProductStructure.name);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	lstDef_ProductStructure.forEach((elm){
	DocumentReference docRef = coll.doc(elm.ID.toString());
	batch.set(docRef, elm.toMap());
	});
	await batch.commit();
}


//**************************** get ****************************

static Future<Def_ProductStructure> fire_getItem(String docName) async {
	late Def_ProductStructure  itemDef_ProductStructure;
	try { var retValue = await FirebaseFirestore.instance.collection(en_TablesName.Def_ProductStructure.name).doc(docName).get();
	 itemDef_ProductStructure = Def_ProductStructure();
 itemDef_ProductStructure.ID = retValue.data()!['ID']; itemDef_ProductStructure.BarCode = retValue.data()!['BarCode']; itemDef_ProductStructure.Name = retValue.data()!['Name']; itemDef_ProductStructure.IDCategory = retValue.data()!['IDCategory']; itemDef_ProductStructure.IDProductionCompany = retValue.data()!['IDProductionCompany']; itemDef_ProductStructure.UnitBig_ID = retValue.data()!['UnitBig_ID']; itemDef_ProductStructure.UnitBig_PurchasePrice = retValue.data()!['UnitBig_PurchasePrice']; itemDef_ProductStructure.UnitBig_Sales1 = retValue.data()!['UnitBig_Sales1']; itemDef_ProductStructure.UnitBig_Sales2 = retValue.data()!['UnitBig_Sales2']; itemDef_ProductStructure.UnitBig_Sales3 = retValue.data()!['UnitBig_Sales3']; itemDef_ProductStructure.UnitBig_Sales4 = retValue.data()!['UnitBig_Sales4']; itemDef_ProductStructure.UnitBig_Sales5 = retValue.data()!['UnitBig_Sales5']; itemDef_ProductStructure.UnitCountOf = retValue.data()!['UnitCountOf']; itemDef_ProductStructure.UnitSmall_ID = retValue.data()!['UnitSmall_ID']; itemDef_ProductStructure.UnitSmall_PurchasePrice = retValue.data()!['UnitSmall_PurchasePrice']; itemDef_ProductStructure.UnitSmall_Sales1 = retValue.data()!['UnitSmall_Sales1']; itemDef_ProductStructure.UnitSmall_Sales2 = retValue.data()!['UnitSmall_Sales2']; itemDef_ProductStructure.UnitSmall_Sales3 = retValue.data()!['UnitSmall_Sales3']; itemDef_ProductStructure.UnitSmall_Sales4 = retValue.data()!['UnitSmall_Sales4']; itemDef_ProductStructure.UnitSmall_Sales5 = retValue.data()!['UnitSmall_Sales5']; itemDef_ProductStructure.LimitedQty = retValue.data()!['LimitedQty']; itemDef_ProductStructure.IsActive = retValue.data()!['IsActive']; itemDef_ProductStructure.IsPOS = retValue.data()!['IsPOS']; itemDef_ProductStructure.IsUpdated = retValue.data()!['IsUpdated']; itemDef_ProductStructure.controller = retValue.data()!['controller']; itemDef_ProductStructure.ImageName1 = retValue.data()!['ImageName1']; itemDef_ProductStructure.ImageURL1 = retValue.data()!['ImageURL1']; itemDef_ProductStructure.ImageName2 = retValue.data()!['ImageName2']; itemDef_ProductStructure.ImageURL2 = retValue.data()!['ImageURL2']; itemDef_ProductStructure.ImageName3 = retValue.data()!['ImageName3']; itemDef_ProductStructure.ImageURL3 = retValue.data()!['ImageURL3']; itemDef_ProductStructure.ImageName4 = retValue.data()!['ImageName4']; itemDef_ProductStructure.ImageURL4 = retValue.data()!['ImageURL4']; itemDef_ProductStructure.ImageName5 = retValue.data()!['ImageName5']; itemDef_ProductStructure.ImageURL5 = retValue.data()!['ImageURL5']; itemDef_ProductStructure.Discription = retValue.data()!['Discription'];	return  itemDef_ProductStructure;
	} catch (error) {
	print(error.toString()); throw error;
	}
}

static Future<List<Def_ProductStructure>> fire_getList() async {
	await FirebaseFirestore.instance
	.collection(en_TablesName.Def_ProductStructure.name)
	.get()
	.then((value) {
	lstDef_ProductStructure.clear();
	value.docs.forEach((element) {
	lstDef_ProductStructure.add(Def_ProductStructure.fromJson(element.data()));
	});
	}).catchError((error) {
print(error.toString()); throw error;
});
return lstDef_ProductStructure;
}

static Future<List<Def_ProductStructure>> fire_getListByBranch(int branchID , String BranchColumnName) async {
	await FirebaseFirestore.instance.collection(en_TablesName.Def_ProductStructure.name)
	.where(BranchColumnName, isEqualTo: branchID).get()
	.then((value) {lstDef_ProductStructure.clear();value.docs.forEach((element) {
	lstDef_ProductStructure.add(Def_ProductStructure.fromJson(element.data()));});
	}).catchError((error) {print(error.toString());throw error;});
	return lstDef_ProductStructure;
}

static Future<List<Def_ProductStructure>> fire_getListWithConditions({List<BLLCondions>? conditions}) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Def_ProductStructure.name);
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
	lstDef_ProductStructure.clear();
	snap.docs.forEach((element) {
	lstDef_ProductStructure.add(Def_ProductStructure.fromJson(element.data() as Map<String, dynamic> )); });
	return lstDef_ProductStructure;
}


//**************************** delete ****************************

static Future<bool> fire_DeleteItem(String docName) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Def_ProductStructure.name).doc(docName).delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); 
	result = false;
	});
	return result;
	}

static Future fire_DeleteListMaster(List<BLLCondions> conditions) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Def_ProductStructure.name);
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
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Def_ProductStructure.name);
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
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Def_ProductStructure.name : pathOnStorage;
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
	await firebase_storage.FirebaseStorage.instance.ref().child('${en_TablesName.Def_ProductStructure.name}/${fileName}').getDownloadURL().then((URL) {
	fileDownloadURL = URL;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return fileDownloadURL;
}

static Future<bool> storage_DeleteFile(String fileName ,{String pathOnStorage = ''}) async {
	bool result = false;
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Def_ProductStructure.name : pathOnStorage;
	await firebase_storage.FirebaseStorage.instance.ref().child('${pathOnStorage}/${fileName}').delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
	}

	}

