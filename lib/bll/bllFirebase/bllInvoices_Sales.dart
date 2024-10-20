import '../classModel/Invoices_Sales.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../shared/enumerators.dart';
import '../classModel/Invoices_SalesDetails.dart';
import 'ManageBLL.dart';


class bllInvoices_Sales
	{
		static List<String> ColumnsName = enTable_Invoices_Sales.values.map((item) => item.name).toList();
			static late List<Invoices_Sales> lstInvoices_Sales = [];
			static late Invoices_Sales itemInvoices_Sales;
			static String query = '';
	static List<Invoices_SalesDetails> lstInvoices_SalesDetails = [];

//**************************** general function ****************************

static Future<int> getMaxID_firestore() async {
	int maxID = 0;
	await FirebaseFirestore.instance
	.collection(en_TablesName.Invoices_Sales.name)
	.orderBy(enTable_Invoices_Sales.ID.name, descending: true)
	.limit(1).get().then((value) {
	if (value.docs.isEmpty) {maxID = 1;}
	else {
	maxID = value.docs.first.get(enTable_Invoices_Sales.ID.name);
	maxID += 1;}
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return maxID;
}

static Future<int> getMax_firestore(enTable_Invoices_Sales colName, {BLLCondions? condion}) async {
	int maxID = 1;
	QuerySnapshot? snapshot;
	 try {if (condion != null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.Invoices_Sales.name)
	.where(condion.columnName, isEqualTo: condion.value)
	.orderBy(colName.name, descending: true)
	.limit(1).get();} else if (condion == null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.Invoices_Sales.name)
	.orderBy(colName.name, descending: true)
	.limit(1).get();}
	if (snapshot != null && snapshot.docs.isNotEmpty) {
	maxID = snapshot.docs.first.get(colName.name);
	maxID += 1;}} catch (error) {
	print(error.toString());throw error;}return maxID;
}


//**************************** add & set ****************************

/// هو إسم الكلاس والإضافة بتكون بكون عشوائي ولا يمكن للمستخدم تحديده collection وبيكون ال  FirebaseFirestore تستخدم للإضافة فى
static Future<String> fire_AddItem(Invoices_Sales  itemInvoices_Sales) async {
	String docCreatedName = '';
	await FirebaseFirestore.instance.collection(en_TablesName.Invoices_Sales.name).add(itemInvoices_Sales.toMap()).then((val) {
	docCreatedName = val.id;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return docCreatedName;
}

static Future<bool> fire_SetItemMap(String docName, Map<String, dynamic>  itemInvoices_Sales) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Invoices_Sales.name).doc(docName).set(itemInvoices_Sales).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future<bool> fire_SetItem(String docName, Invoices_Sales  itemInvoices_Sales) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Invoices_Sales.name).doc(docName).set(itemInvoices_Sales.toMap()).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future fire_setListMaster_And_Details(
	{required String insertdDocID,
	required Invoices_Sales  itemInvoices_Sales,
	required String collectionDetailsName,
	required String columnNameAsDocumentDetails,
	required List<Map<String, dynamic>> detais,
	required List<Map<String, dynamic>> deletedItemsDetais,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Invoices_Sales.name);
	DocumentReference tablemasterDocref = coll.doc(insertdDocID);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	// save Master
	batch.set(tablemasterDocref,  itemInvoices_Sales.toMap());
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
	required List<Invoices_Sales> lstInvoices_Sales,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Invoices_Sales.name);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	lstInvoices_Sales.forEach((elm){
	DocumentReference docRef = coll.doc(elm.ID.toString());
	batch.set(docRef, elm.toMap());
	});
	await batch.commit();
}


//**************************** get ****************************

static Future<Invoices_Sales> fire_getItem(String docName) async {
	late Invoices_Sales  itemInvoices_Sales;
	try { var retValue = await FirebaseFirestore.instance.collection(en_TablesName.Invoices_Sales.name).doc(docName).get();
	 itemInvoices_Sales = Invoices_Sales();
 itemInvoices_Sales.ID = retValue.data()!['ID']; itemInvoices_Sales.Code = retValue.data()!['Code']; itemInvoices_Sales.Date = retValue.data()!['Date']; itemInvoices_Sales.Time = retValue.data()!['Time']; itemInvoices_Sales.IDBranch = retValue.data()!['IDBranch']; itemInvoices_Sales.IDStock = retValue.data()!['IDStock']; itemInvoices_Sales.IDEmployee = retValue.data()!['IDEmployee']; itemInvoices_Sales.IDClient = retValue.data()!['IDClient']; itemInvoices_Sales.TotalValue = retValue.data()!['TotalValue']; itemInvoices_Sales.DiscountValue = retValue.data()!['DiscountValue']; itemInvoices_Sales.DiscountPercent = retValue.data()!['DiscountPercent']; itemInvoices_Sales.NetValue = retValue.data()!['NetValue']; itemInvoices_Sales.IsClosed = retValue.data()!['IsClosed']; itemInvoices_Sales.Note = retValue.data()!['Note']; itemInvoices_Sales.UID = retValue.data()!['UID']; itemInvoices_Sales.CurrentBalance = retValue.data()!['CurrentBalance'];	return  itemInvoices_Sales;
	} catch (error) {
	print(error.toString()); throw error;
	}
}

static Future<List<Invoices_Sales>> fire_getList() async {
	await FirebaseFirestore.instance
	.collection(en_TablesName.Invoices_Sales.name)
	.get()
	.then((value) {
	lstInvoices_Sales.clear();
	value.docs.forEach((element) {
	lstInvoices_Sales.add(Invoices_Sales.fromJson(element.data()));
	});
	}).catchError((error) {
print(error.toString()); throw error;
});
return lstInvoices_Sales;
}

static Future<List<Invoices_SalesDetails>> fire_getListDetails(String IDMaster, String TableNameDetails) async {
	try {
	//**************** 1 - Master Date
	DocumentSnapshot doc = await FirebaseFirestore.instance.collection(en_TablesName.Invoices_Sales.name).doc(IDMaster).get();

	//**************** 2 - Details Data
	QuerySnapshot<Map<String, dynamic>> collRef = await doc.reference.collection(TableNameDetails).get();
	lstInvoices_SalesDetails.clear();
	collRef.docs.forEach((element) {
	lstInvoices_SalesDetails.add(Invoices_SalesDetails.fromJson(element.data()));
	});
	} catch (error) {
	print(error.toString());
	throw error;
	}
	return lstInvoices_SalesDetails;
}

static Future<List<Invoices_Sales>> fire_getListByBranch(int branchID , String BranchColumnName) async {
	await FirebaseFirestore.instance.collection(en_TablesName.Invoices_Sales.name)
	.where(BranchColumnName, isEqualTo: branchID).get()
	.then((value) {lstInvoices_Sales.clear();value.docs.forEach((element) {
	lstInvoices_Sales.add(Invoices_Sales.fromJson(element.data()));});
	}).catchError((error) {print(error.toString());throw error;});
	return lstInvoices_Sales;
}

static Future<List<Invoices_Sales>> fire_getListWithConditions({List<BLLCondions>? conditions}) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Invoices_Sales.name);
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
	lstInvoices_Sales.clear();
	snap.docs.forEach((element) {
	lstInvoices_Sales.add(Invoices_Sales.fromJson(element.data() as Map<String, dynamic> )); });
	return lstInvoices_Sales;
}


//**************************** delete ****************************

static Future<bool> fire_DeleteItem(String docName) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Invoices_Sales.name).doc(docName).delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); 
	result = false;
	});
	return result;
	}

static Future fire_DeleteListMaster(List<BLLCondions> conditions) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Invoices_Sales.name);
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
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Invoices_Sales.name);
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
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Invoices_Sales.name : pathOnStorage;
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
	await firebase_storage.FirebaseStorage.instance.ref().child('${en_TablesName.Invoices_Sales.name}/${fileName}').getDownloadURL().then((URL) {
	fileDownloadURL = URL;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return fileDownloadURL;
}

static Future<bool> storage_DeleteFile(String fileName ,{String pathOnStorage = ''}) async {
	bool result = false;
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Invoices_Sales.name : pathOnStorage;
	await firebase_storage.FirebaseStorage.instance.ref().child('${pathOnStorage}/${fileName}').delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
	}

	}

