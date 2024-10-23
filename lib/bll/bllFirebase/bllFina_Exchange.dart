import '../classModel/Fina_Exchange.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../shared/enumerators.dart';
import 'ManageBLL.dart';


class bllFina_Exchange
	{
		static List<String> ColumnsName = enTable_Fina_Exchange.values.map((item) => item.name).toList();
			static late List<Fina_Exchange> lstFina_Exchange = [];
			static late Fina_Exchange itemFina_Exchange;
			static String query = '';

//**************************** general function ****************************

static Future<int> getMaxID_firestore() async {
	int maxID = 0;
	await FirebaseFirestore.instance
	.collection(en_TablesName.Fina_Exchange.name)
	.orderBy(enTable_Fina_Exchange.ID.name, descending: true)
	.limit(1).get().then((value) {
	if (value.docs.isEmpty) {maxID = 1;}
	else {
	maxID = value.docs.first.get(enTable_Fina_Exchange.ID.name);
	maxID += 1;}
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return maxID;
}

static Future<int> getMax_firestore(enTable_Fina_Exchange colName, {BLLCondions? condion}) async {
	int maxID = 1;
	QuerySnapshot? snapshot;
	 try {if (condion != null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.Fina_Exchange.name)
	.where(condion.columnName, isEqualTo: condion.value)
	.orderBy(colName.name, descending: true)
	.limit(1).get();} else if (condion == null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.Fina_Exchange.name)
	.orderBy(colName.name, descending: true)
	.limit(1).get();}
	if (snapshot != null && snapshot.docs.isNotEmpty) {
	maxID = snapshot.docs.first.get(colName.name);
	maxID += 1;}} catch (error) {
	print(error.toString());throw error;}return maxID;
}


//**************************** add & set ****************************

/// هو إسم الكلاس والإضافة بتكون بكون عشوائي ولا يمكن للمستخدم تحديده collection وبيكون ال  FirebaseFirestore تستخدم للإضافة فى
static Future<String> fire_AddItem(Fina_Exchange  itemFina_Exchange) async {
	String docCreatedName = '';
	await FirebaseFirestore.instance.collection(en_TablesName.Fina_Exchange.name).add(itemFina_Exchange.toMap()).then((val) {
	docCreatedName = val.id;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return docCreatedName;
}

static Future<bool> fire_SetItemMap(String docName, Map<String, dynamic>  itemFina_Exchange) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Fina_Exchange.name).doc(docName).set(itemFina_Exchange).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future<bool> fire_SetItem(String docName, Fina_Exchange  itemFina_Exchange) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Fina_Exchange.name).doc(docName).set(itemFina_Exchange.toMap()).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future fire_setListMaster_And_Details(
	{required String insertdDocID,
	required Fina_Exchange  itemFina_Exchange,
	required String collectionDetailsName,
	required String columnNameAsDocumentDetails,
	required List<Map<String, dynamic>> detais,
	required List<Map<String, dynamic>> deletedItemsDetais,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Fina_Exchange.name);
	DocumentReference tablemasterDocref = coll.doc(insertdDocID);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	// save Master
	batch.set(tablemasterDocref,  itemFina_Exchange.toMap());
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
	required List<Fina_Exchange> lstFina_Exchange,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Fina_Exchange.name);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	lstFina_Exchange.forEach((elm){
	DocumentReference docRef = coll.doc(elm.ID.toString());
	batch.set(docRef, elm.toMap());
	});
	await batch.commit();
}


//**************************** get ****************************

static Future<Fina_Exchange> fire_getItem(String docName) async {
	late Fina_Exchange  itemFina_Exchange;
	try { var retValue = await FirebaseFirestore.instance.collection(en_TablesName.Fina_Exchange.name).doc(docName).get();
	 itemFina_Exchange = Fina_Exchange();
 itemFina_Exchange.ID = retValue.data()!['ID']; itemFina_Exchange.Code = retValue.data()!['Code']; itemFina_Exchange.Serial = retValue.data()!['Serial']; itemFina_Exchange.Date = retValue.data()!['Date']; itemFina_Exchange.Time = retValue.data()!['Time']; itemFina_Exchange.IDTreasur = retValue.data()!['IDTreasur']; itemFina_Exchange.DealingTypeID = retValue.data()!['DealingTypeID']; itemFina_Exchange.DealingID = retValue.data()!['DealingID']; itemFina_Exchange.BalanceBefor = retValue.data()!['BalanceBefor']; itemFina_Exchange.Value = retValue.data()!['Value']; itemFina_Exchange.BalanceAfter = retValue.data()!['BalanceAfter']; itemFina_Exchange.IDFinancialType = retValue.data()!['IDFinancialType']; itemFina_Exchange.IDFinancialCluses = retValue.data()!['IDFinancialCluses']; itemFina_Exchange.Note = retValue.data()!['Note']; itemFina_Exchange.IsBindeDocument = retValue.data()!['IsBindeDocument']; itemFina_Exchange.BindeDocumentTypeID = retValue.data()!['BindeDocumentTypeID']; itemFina_Exchange.BindeDocumentID = retValue.data()!['BindeDocumentID']; itemFina_Exchange.BindeDocumentText = retValue.data()!['BindeDocumentText']; itemFina_Exchange.BindeDocumentCode = retValue.data()!['BindeDocumentCode']; itemFina_Exchange.IsAccountedByRepresent = retValue.data()!['IsAccountedByRepresent']; itemFina_Exchange.IDUser = retValue.data()!['IDUser']; itemFina_Exchange.IDBranch = retValue.data()!['IDBranch']; itemFina_Exchange.IsClosedTreasure = retValue.data()!['IsClosedTreasure']; itemFina_Exchange.IDClosedTreasure = retValue.data()!['IDClosedTreasure']; itemFina_Exchange.IsClosedEdit = retValue.data()!['IsClosedEdit']; itemFina_Exchange.IDCalcSalary = retValue.data()!['IDCalcSalary'];	return  itemFina_Exchange;
	} catch (error) {
	print(error.toString()); throw error;
	}
}

static Future<List<Fina_Exchange>> fire_getList() async {
	await FirebaseFirestore.instance
	.collection(en_TablesName.Fina_Exchange.name)
	.get()
	.then((value) {
	lstFina_Exchange.clear();
	value.docs.forEach((element) {
	lstFina_Exchange.add(Fina_Exchange.fromJson(element.data()));
	});
	}).catchError((error) {
print(error.toString()); throw error;
});
return lstFina_Exchange;
}

static Future<List<Fina_Exchange>> fire_getListByBranch(int branchID , String BranchColumnName) async {
	await FirebaseFirestore.instance.collection(en_TablesName.Fina_Exchange.name)
	.where(BranchColumnName, isEqualTo: branchID).get()
	.then((value) {lstFina_Exchange.clear();value.docs.forEach((element) {
	lstFina_Exchange.add(Fina_Exchange.fromJson(element.data()));});
	}).catchError((error) {print(error.toString());throw error;});
	return lstFina_Exchange;
}

static Future<List<Fina_Exchange>> fire_getListWithConditions({List<BLLCondions>? conditions}) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Fina_Exchange.name);
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
	lstFina_Exchange.clear();
	snap.docs.forEach((element) {
	lstFina_Exchange.add(Fina_Exchange.fromJson(element.data() as Map<String, dynamic> )); });
	return lstFina_Exchange;
}


//**************************** delete ****************************

static Future<bool> fire_DeleteItem(String docName) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Fina_Exchange.name).doc(docName).delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); 
	result = false;
	});
	return result;
	}

static Future fire_DeleteListMaster(List<BLLCondions> conditions) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Fina_Exchange.name);
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
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Fina_Exchange.name);
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
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Fina_Exchange.name : pathOnStorage;
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
	await firebase_storage.FirebaseStorage.instance.ref().child('${en_TablesName.Fina_Exchange.name}/${fileName}').getDownloadURL().then((URL) {
	fileDownloadURL = URL;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return fileDownloadURL;
}

static Future<bool> storage_DeleteFile(String fileName ,{String pathOnStorage = ''}) async {
	bool result = false;
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Fina_Exchange.name : pathOnStorage;
	await firebase_storage.FirebaseStorage.instance.ref().child('${pathOnStorage}/${fileName}').delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
	}

	}

