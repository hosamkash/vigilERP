import '../classModel/HR_Discount.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../shared/enumerators.dart';
import 'ManageBLL.dart';


class bllHR_Discount
	{
		static List<String> ColumnsName = enTable_HR_Discount.values.map((item) => item.name).toList();
			static late List<HR_Discount> lstHR_Discount = [];
			static late HR_Discount itemHR_Discount;
			static String query = '';

//**************************** general function ****************************

static Future<int> getMaxID_firestore() async {
	int maxID = 0;
	await FirebaseFirestore.instance
	.collection(en_TablesName.HR_Discount.name)
	.orderBy(enTable_HR_Discount.ID.name, descending: true)
	.limit(1).get().then((value) {
	if (value.docs.isEmpty) {maxID = 1;}
	else {
	maxID = value.docs.first.get(enTable_HR_Discount.ID.name);
	maxID += 1;}
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return maxID;
}

static Future<int> getMax_firestore(enTable_HR_Discount colName, {BLLCondions? condion}) async {
	int maxID = 1;
	QuerySnapshot? snapshot;
	 try {if (condion != null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.HR_Discount.name)
	.where(condion.columnName, isEqualTo: condion.value)
	.orderBy(colName.name, descending: true)
	.limit(1).get();} else if (condion == null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.HR_Discount.name)
	.orderBy(colName.name, descending: true)
	.limit(1).get();}
	if (snapshot != null && snapshot.docs.isNotEmpty) {
	maxID = snapshot.docs.first.get(colName.name);
	maxID += 1;}} catch (error) {
	print(error.toString());throw error;}return maxID;
}


//**************************** add & set ****************************

/// هو إسم الكلاس والإضافة بتكون بكون عشوائي ولا يمكن للمستخدم تحديده collection وبيكون ال  FirebaseFirestore تستخدم للإضافة فى
static Future<String> fire_AddItem(HR_Discount  itemHR_Discount) async {
	String docCreatedName = '';
	await FirebaseFirestore.instance.collection(en_TablesName.HR_Discount.name).add(itemHR_Discount.toMap()).then((val) {
	docCreatedName = val.id;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return docCreatedName;
}

static Future<bool> fire_SetItemMap(String docName, Map<String, dynamic>  itemHR_Discount) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.HR_Discount.name).doc(docName).set(itemHR_Discount).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future<bool> fire_SetItem(String docName, HR_Discount  itemHR_Discount) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.HR_Discount.name).doc(docName).set(itemHR_Discount.toMap()).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future fire_setListMaster_And_Details(
	{required String insertdDocID,
	required HR_Discount  itemHR_Discount,
	required String collectionDetailsName,
	required String columnNameAsDocumentDetails,
	required List<Map<String, dynamic>> detais,
	required List<Map<String, dynamic>> deletedItemsDetais,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.HR_Discount.name);
	DocumentReference tablemasterDocref = coll.doc(insertdDocID);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	// save Master
	batch.set(tablemasterDocref,  itemHR_Discount.toMap());
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
	required List<HR_Discount> lstHR_Discount,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.HR_Discount.name);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	lstHR_Discount.forEach((elm){
	DocumentReference docRef = coll.doc(elm.ID.toString());
	batch.set(docRef, elm.toMap());
	});
	await batch.commit();
}


//**************************** get ****************************

static Future<HR_Discount> fire_getItem(String docName) async {
	late HR_Discount  itemHR_Discount;
	try { var retValue = await FirebaseFirestore.instance.collection(en_TablesName.HR_Discount.name).doc(docName).get();
	 itemHR_Discount = HR_Discount();
 itemHR_Discount.ID = retValue.data()!['ID']; itemHR_Discount.IDBranch = retValue.data()!['IDBranch']; itemHR_Discount.Code = retValue.data()!['Code']; itemHR_Discount.Date = retValue.data()!['Date']; itemHR_Discount.Time = retValue.data()!['Time']; itemHR_Discount.IDEmployee = retValue.data()!['IDEmployee']; itemHR_Discount.IDJob = retValue.data()!['IDJob']; itemHR_Discount.IDDepartment = retValue.data()!['IDDepartment']; itemHR_Discount.EmployeeSalaryMonth = retValue.data()!['EmployeeSalaryMonth']; itemHR_Discount.EmployeeSalaryWeek = retValue.data()!['EmployeeSalaryWeek']; itemHR_Discount.EmployeeSalaryDay = retValue.data()!['EmployeeSalaryDay']; itemHR_Discount.EmployeeSalaryHour = retValue.data()!['EmployeeSalaryHour']; itemHR_Discount.DiscountType = retValue.data()!['DiscountType']; itemHR_Discount.DiscountDays = retValue.data()!['DiscountDays']; itemHR_Discount.DiscountValue = retValue.data()!['DiscountValue']; itemHR_Discount.DiscountReson = retValue.data()!['DiscountReson']; itemHR_Discount.IDCalcSalary = retValue.data()!['IDCalcSalary']; itemHR_Discount.UID = retValue.data()!['UID']; itemHR_Discount.IsClosed = retValue.data()!['IsClosed'];	return  itemHR_Discount;
	} catch (error) {
	print(error.toString()); throw error;
	}
}

static Future<List<HR_Discount>> fire_getList() async {
	await FirebaseFirestore.instance
	.collection(en_TablesName.HR_Discount.name)
	.get()
	.then((value) {
	lstHR_Discount.clear();
	value.docs.forEach((element) {
	lstHR_Discount.add(HR_Discount.fromJson(element.data()));
	});
	}).catchError((error) {
print(error.toString()); throw error;
});
return lstHR_Discount;
}

static Future<List<HR_Discount>> fire_getListByBranch(int branchID , String BranchColumnName) async {
	await FirebaseFirestore.instance.collection(en_TablesName.HR_Discount.name)
	.where(BranchColumnName, isEqualTo: branchID).get()
	.then((value) {lstHR_Discount.clear();value.docs.forEach((element) {
	lstHR_Discount.add(HR_Discount.fromJson(element.data()));});
	}).catchError((error) {print(error.toString());throw error;});
	return lstHR_Discount;
}

static Future<List<HR_Discount>> fire_getListWithConditions({List<BLLCondions>? conditions}) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.HR_Discount.name);
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
	lstHR_Discount.clear();
	snap.docs.forEach((element) {
	lstHR_Discount.add(HR_Discount.fromJson(element.data() as Map<String, dynamic> )); });
	return lstHR_Discount;
}


//**************************** delete ****************************

static Future<bool> fire_DeleteItem(String docName) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.HR_Discount.name).doc(docName).delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); 
	result = false;
	});
	return result;
	}

static Future fire_DeleteListMaster(List<BLLCondions> conditions) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.HR_Discount.name);
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
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.HR_Discount.name);
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
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.HR_Discount.name : pathOnStorage;
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
	await firebase_storage.FirebaseStorage.instance.ref().child('${en_TablesName.HR_Discount.name}/${fileName}').getDownloadURL().then((URL) {
	fileDownloadURL = URL;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return fileDownloadURL;
}

static Future<bool> storage_DeleteFile(String fileName ,{String pathOnStorage = ''}) async {
	bool result = false;
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.HR_Discount.name : pathOnStorage;
	await firebase_storage.FirebaseStorage.instance.ref().child('${pathOnStorage}/${fileName}').delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
	}

	}

