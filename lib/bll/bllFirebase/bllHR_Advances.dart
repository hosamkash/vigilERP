import '../classModel/HR_Advances.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../shared/enumerators.dart';
import 'ManageBLL.dart';


class bllHR_Advances
	{
		static List<String> ColumnsName = enTable_HR_Advances.values.map((item) => item.name).toList();
			static late List<HR_Advances> lstHR_Advances = [];
			static late HR_Advances itemHR_Advances;
			static String query = '';

//**************************** general function ****************************

static Future<int> getMaxID_firestore() async {
	int maxID = 0;
	await FirebaseFirestore.instance
	.collection(en_TablesName.HR_Advances.name)
	.orderBy(enTable_HR_Advances.ID.name, descending: true)
	.limit(1).get().then((value) {
	if (value.docs.isEmpty) {maxID = 1;}
	else {
	maxID = value.docs.first.get(enTable_HR_Advances.ID.name);
	maxID += 1;}
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return maxID;
}

static Future<int> getMax_firestore(enTable_HR_Advances colName, {BLLCondions? condion}) async {
	int maxID = 1;
	QuerySnapshot? snapshot;
	 try {if (condion != null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.HR_Advances.name)
	.where(condion.columnName, isEqualTo: condion.value)
	.orderBy(colName.name, descending: true)
	.limit(1).get();} else if (condion == null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.HR_Advances.name)
	.orderBy(colName.name, descending: true)
	.limit(1).get();}
	if (snapshot != null && snapshot.docs.isNotEmpty) {
	maxID = snapshot.docs.first.get(colName.name);
	maxID += 1;}} catch (error) {
	print(error.toString());throw error;}return maxID;
}


//**************************** add & set ****************************

/// هو إسم الكلاس والإضافة بتكون بكون عشوائي ولا يمكن للمستخدم تحديده collection وبيكون ال  FirebaseFirestore تستخدم للإضافة فى
static Future<String> fire_AddItem(HR_Advances  itemHR_Advances) async {
	String docCreatedName = '';
	await FirebaseFirestore.instance.collection(en_TablesName.HR_Advances.name).add(itemHR_Advances.toMap()).then((val) {
	docCreatedName = val.id;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return docCreatedName;
}

static Future<bool> fire_SetItemMap(String docName, Map<String, dynamic>  itemHR_Advances) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.HR_Advances.name).doc(docName).set(itemHR_Advances).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future<bool> fire_SetItem(String docName, HR_Advances  itemHR_Advances) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.HR_Advances.name).doc(docName).set(itemHR_Advances.toMap()).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future fire_setListMaster_And_Details(
	{required String insertdDocID,
	required HR_Advances  itemHR_Advances,
	required String collectionDetailsName,
	required String columnNameAsDocumentDetails,
	required List<Map<String, dynamic>> detais,
	required List<Map<String, dynamic>> deletedItemsDetais,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.HR_Advances.name);
	DocumentReference tablemasterDocref = coll.doc(insertdDocID);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	// save Master
	batch.set(tablemasterDocref,  itemHR_Advances.toMap());
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
	required List<HR_Advances> lstHR_Advances,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.HR_Advances.name);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	lstHR_Advances.forEach((elm){
	DocumentReference docRef = coll.doc(elm.ID.toString());
	batch.set(docRef, elm.toMap());
	});
	await batch.commit();
}


//**************************** get ****************************

static Future<HR_Advances> fire_getItem(String docName) async {
	late HR_Advances  itemHR_Advances;
	try { var retValue = await FirebaseFirestore.instance.collection(en_TablesName.HR_Advances.name).doc(docName).get();
	 itemHR_Advances = HR_Advances();
 itemHR_Advances.ID = retValue.data()!['ID']; itemHR_Advances.IDBranch = retValue.data()!['IDBranch']; itemHR_Advances.Code = retValue.data()!['Code']; itemHR_Advances.Date = retValue.data()!['Date']; itemHR_Advances.Time = retValue.data()!['Time']; itemHR_Advances.IDEmployee = retValue.data()!['IDEmployee']; itemHR_Advances.IDJob = retValue.data()!['IDJob']; itemHR_Advances.IDDepartment = retValue.data()!['IDDepartment']; itemHR_Advances.EmployeeSalaryMonth = retValue.data()!['EmployeeSalaryMonth']; itemHR_Advances.EmployeeSalaryWeek = retValue.data()!['EmployeeSalaryWeek']; itemHR_Advances.EmployeeSalaryDay = retValue.data()!['EmployeeSalaryDay']; itemHR_Advances.EmployeeSalaryHour = retValue.data()!['EmployeeSalaryHour']; itemHR_Advances.Value = retValue.data()!['Value']; itemHR_Advances.InstallmentValue = retValue.data()!['InstallmentValue']; itemHR_Advances.InstallmentCount = retValue.data()!['InstallmentCount']; itemHR_Advances.InstallmentDateStart = retValue.data()!['InstallmentDateStart']; itemHR_Advances.Reson = retValue.data()!['Reson']; itemHR_Advances.IDCalcSalary = retValue.data()!['IDCalcSalary']; itemHR_Advances.UID = retValue.data()!['UID']; itemHR_Advances.IsClosed = retValue.data()!['IsClosed'];	return  itemHR_Advances;
	} catch (error) {
	print(error.toString()); throw error;
	}
}

static Future<List<HR_Advances>> fire_getList() async {
	await FirebaseFirestore.instance
	.collection(en_TablesName.HR_Advances.name)
	.get()
	.then((value) {
	lstHR_Advances.clear();
	value.docs.forEach((element) {
	lstHR_Advances.add(HR_Advances.fromJson(element.data()));
	});
	}).catchError((error) {
print(error.toString()); throw error;
});
return lstHR_Advances;
}

static Future<List<HR_Advances>> fire_getListByBranch(int branchID , String BranchColumnName) async {
	await FirebaseFirestore.instance.collection(en_TablesName.HR_Advances.name)
	.where(BranchColumnName, isEqualTo: branchID).get()
	.then((value) {lstHR_Advances.clear();value.docs.forEach((element) {
	lstHR_Advances.add(HR_Advances.fromJson(element.data()));});
	}).catchError((error) {print(error.toString());throw error;});
	return lstHR_Advances;
}

static Future<List<HR_Advances>> fire_getListWithConditions({List<BLLCondions>? conditions}) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.HR_Advances.name);
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
	lstHR_Advances.clear();
	snap.docs.forEach((element) {
	lstHR_Advances.add(HR_Advances.fromJson(element.data() as Map<String, dynamic> )); });
	return lstHR_Advances;
}


//**************************** delete ****************************

static Future<bool> fire_DeleteItem(String docName) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.HR_Advances.name).doc(docName).delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); 
	result = false;
	});
	return result;
	}

static Future fire_DeleteListMaster(List<BLLCondions> conditions) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.HR_Advances.name);
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
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.HR_Advances.name);
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
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.HR_Advances.name : pathOnStorage;
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
	await firebase_storage.FirebaseStorage.instance.ref().child('${en_TablesName.HR_Advances.name}/${fileName}').getDownloadURL().then((URL) {
	fileDownloadURL = URL;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return fileDownloadURL;
}

static Future<bool> storage_DeleteFile(String fileName ,{String pathOnStorage = ''}) async {
	bool result = false;
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.HR_Advances.name : pathOnStorage;
	await firebase_storage.FirebaseStorage.instance.ref().child('${pathOnStorage}/${fileName}').delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
	}

	}

