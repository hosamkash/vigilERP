import '../classModel/Invoices_SalesReturned.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../shared/enumerators.dart';
import '../classModel/Invoices_SalesReturnedDetails.dart';
import 'ManageBLL.dart';


class bllInvoices_SalesReturned
	{
		static List<String> ColumnsName = enTable_Invoices_SalesReturned.values.map((item) => item.name).toList();
			static late List<Invoices_SalesReturned> lstInvoices_SalesReturned = [];
			static late Invoices_SalesReturned itemInvoices_SalesReturned;
			static String query = '';
	static List<Invoices_SalesReturnedDetails> lstInvoices_SalesReturnedDetails = [];

//**************************** general function ****************************

static Future<int> getMaxID_firestore() async {
	int maxID = 0;
	await FirebaseFirestore.instance
	.collection(en_TablesName.Invoices_SalesReturned.name)
	.orderBy(enTable_Invoices_SalesReturned.ID.name, descending: true)
	.limit(1).get().then((value) {
	if (value.docs.isEmpty) {maxID = 1;}
	else {
	maxID = value.docs.first.get(enTable_Invoices_SalesReturned.ID.name);
	maxID += 1;}
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return maxID;
}

static Future<int> getMax_firestore(enTable_Invoices_SalesReturned colName, {BLLCondions? condion}) async {
	int maxID = 1;
	QuerySnapshot? snapshot;
	 try {if (condion != null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.Invoices_SalesReturned.name)
	.where(condion.columnName, isEqualTo: condion.value)
	.orderBy(colName.name, descending: true)
	.limit(1).get();} else if (condion == null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.Invoices_SalesReturned.name)
	.orderBy(colName.name, descending: true)
	.limit(1).get();}
	if (snapshot != null && snapshot.docs.isNotEmpty) {
	maxID = snapshot.docs.first.get(colName.name);
	maxID += 1;}} catch (error) {
	print(error.toString());throw error;}return maxID;
}


//**************************** add & set ****************************

/// هو إسم الكلاس والإضافة بتكون بكون عشوائي ولا يمكن للمستخدم تحديده collection وبيكون ال  FirebaseFirestore تستخدم للإضافة فى
static Future<String> fire_AddItem(Invoices_SalesReturned  itemInvoices_SalesReturned) async {
	String docCreatedName = '';
	await FirebaseFirestore.instance.collection(en_TablesName.Invoices_SalesReturned.name).add(itemInvoices_SalesReturned.toMap()).then((val) {
	docCreatedName = val.id;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return docCreatedName;
}

static Future<bool> fire_SetItemMap(String docName, Map<String, dynamic>  itemInvoices_SalesReturned) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Invoices_SalesReturned.name).doc(docName).set(itemInvoices_SalesReturned).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future<bool> fire_SetItem(String docName, Invoices_SalesReturned  itemInvoices_SalesReturned) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Invoices_SalesReturned.name).doc(docName).set(itemInvoices_SalesReturned.toMap()).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future fire_setListMaster_And_Details(
	{required String insertdDocID,
	required Invoices_SalesReturned  itemInvoices_SalesReturned,
	required String collectionDetailsName,
	required String columnNameAsDocumentDetails,
	required List<Map<String, dynamic>> detais,
	required List<Map<String, dynamic>> deletedItemsDetais,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Invoices_SalesReturned.name);
	DocumentReference tablemasterDocref = coll.doc(insertdDocID);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	// save Master
	batch.set(tablemasterDocref,  itemInvoices_SalesReturned.toMap());
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
	required List<Invoices_SalesReturned> lstInvoices_SalesReturned,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Invoices_SalesReturned.name);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	lstInvoices_SalesReturned.forEach((elm){
	DocumentReference docRef = coll.doc(elm.ID.toString());
	batch.set(docRef, elm.toMap());
	});
	await batch.commit();
}


//**************************** get ****************************

static Future<Invoices_SalesReturned> fire_getItem(String docName) async {
	late Invoices_SalesReturned  itemInvoices_SalesReturned;
	try { var retValue = await FirebaseFirestore.instance.collection(en_TablesName.Invoices_SalesReturned.name).doc(docName).get();
	 itemInvoices_SalesReturned = Invoices_SalesReturned();
 itemInvoices_SalesReturned.ID = retValue.data()!['ID']; itemInvoices_SalesReturned.Code = retValue.data()!['Code']; itemInvoices_SalesReturned.Date = retValue.data()!['Date']; itemInvoices_SalesReturned.Time = retValue.data()!['Time']; itemInvoices_SalesReturned.IDBranch = retValue.data()!['IDBranch']; itemInvoices_SalesReturned.IDStock = retValue.data()!['IDStock']; itemInvoices_SalesReturned.IDEmployee = retValue.data()!['IDEmployee']; itemInvoices_SalesReturned.IDClient = retValue.data()!['IDClient']; itemInvoices_SalesReturned.TotalValue = retValue.data()!['TotalValue']; itemInvoices_SalesReturned.DiscountValue = retValue.data()!['DiscountValue']; itemInvoices_SalesReturned.DiscountPercent = retValue.data()!['DiscountPercent']; itemInvoices_SalesReturned.NetValue = retValue.data()!['NetValue']; itemInvoices_SalesReturned.IsClosed = retValue.data()!['IsClosed']; itemInvoices_SalesReturned.Note = retValue.data()!['Note']; itemInvoices_SalesReturned.UID = retValue.data()!['UID']; itemInvoices_SalesReturned.CurrentBalance = retValue.data()!['CurrentBalance'];	return  itemInvoices_SalesReturned;
	} catch (error) {
	print(error.toString()); throw error;
	}
}

static Future<List<Invoices_SalesReturned>> fire_getList() async {
	await FirebaseFirestore.instance
	.collection(en_TablesName.Invoices_SalesReturned.name)
	.get()
	.then((value) {
	lstInvoices_SalesReturned.clear();
	value.docs.forEach((element) {
	lstInvoices_SalesReturned.add(Invoices_SalesReturned.fromJson(element.data()));
	});
	}).catchError((error) {
print(error.toString()); throw error;
});
return lstInvoices_SalesReturned;
}

static Future<List<Invoices_SalesReturnedDetails>> fire_getListDetails(String IDMaster, String TableNameDetails) async {
	try {
	//**************** 1 - Master Date
	DocumentSnapshot doc = await FirebaseFirestore.instance.collection(en_TablesName.Invoices_SalesReturned.name).doc(IDMaster).get();

	//**************** 2 - Details Data
	QuerySnapshot<Map<String, dynamic>> collRef = await doc.reference.collection(TableNameDetails).get();
	lstInvoices_SalesReturnedDetails.clear();
	collRef.docs.forEach((element) {
	lstInvoices_SalesReturnedDetails.add(Invoices_SalesReturnedDetails.fromJson(element.data()));
	});
	} catch (error) {
	print(error.toString());
	throw error;
	}
	return lstInvoices_SalesReturnedDetails;
}

static Future<List<Invoices_SalesReturned>> fire_getListByBranch(int branchID , String BranchColumnName) async {
	await FirebaseFirestore.instance.collection(en_TablesName.Invoices_SalesReturned.name)
	.where(BranchColumnName, isEqualTo: branchID).get()
	.then((value) {lstInvoices_SalesReturned.clear();value.docs.forEach((element) {
	lstInvoices_SalesReturned.add(Invoices_SalesReturned.fromJson(element.data()));});
	}).catchError((error) {print(error.toString());throw error;});
	return lstInvoices_SalesReturned;
}

static Future<List<Invoices_SalesReturned>> fire_getListWithConditions({List<BLLCondions>? conditions}) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Invoices_SalesReturned.name);
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
	lstInvoices_SalesReturned.clear();
	snap.docs.forEach((element) {
	lstInvoices_SalesReturned.add(Invoices_SalesReturned.fromJson(element.data() as Map<String, dynamic> )); });
	return lstInvoices_SalesReturned;
}


//**************************** delete ****************************

static Future<bool> fire_DeleteItem(String docName) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Invoices_SalesReturned.name).doc(docName).delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); 
	result = false;
	});
	return result;
	}

static Future fire_DeleteListMaster(List<BLLCondions> conditions) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Invoices_SalesReturned.name);
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
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Invoices_SalesReturned.name);
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
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Invoices_SalesReturned.name : pathOnStorage;
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
	await firebase_storage.FirebaseStorage.instance.ref().child('${en_TablesName.Invoices_SalesReturned.name}/${fileName}').getDownloadURL().then((URL) {
	fileDownloadURL = URL;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return fileDownloadURL;
}

static Future<bool> storage_DeleteFile(String fileName ,{String pathOnStorage = ''}) async {
	bool result = false;
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Invoices_SalesReturned.name : pathOnStorage;
	await firebase_storage.FirebaseStorage.instance.ref().child('${pathOnStorage}/${fileName}').delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
	}

	}

