import '../classModel/Dealing_Employees.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../shared/enumerators.dart';
import 'ManageBLL.dart';


class bllDealing_Employees
	{
		static List<String> ColumnsName = enTable_Dealing_Employees.values.map((item) => item.name).toList();
			static late List<Dealing_Employees> lstDealing_Employees = [];
			static late Dealing_Employees itemDealing_Employees;
			static String query = '';

//**************************** general function ****************************

static Future<int> getMaxID_firestore() async {
	int maxID = 0;
	await FirebaseFirestore.instance
	.collection(en_TablesName.Dealing_Employees.name)
	.orderBy(enTable_Dealing_Employees.ID.name, descending: true)
	.limit(1).get().then((value) {
	if (value.docs.isEmpty) {maxID = 1;}
	else {
	maxID = value.docs.first.get(enTable_Dealing_Employees.ID.name);
	maxID += 1;}
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return maxID;
}

static Future<int> getMax_firestore(enTable_Dealing_Employees colName, {BLLCondions? condion}) async {
	int maxID = 1;
	QuerySnapshot? snapshot;
	 try {if (condion != null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.Dealing_Employees.name)
	.where(condion.columnName, isEqualTo: condion.value)
	.orderBy(colName.name, descending: true)
	.limit(1).get();} else if (condion == null) {
	snapshot = await FirebaseFirestore.instance
	.collection(en_TablesName.Dealing_Employees.name)
	.orderBy(colName.name, descending: true)
	.limit(1).get();}
	if (snapshot != null && snapshot.docs.isNotEmpty) {
	maxID = snapshot.docs.first.get(colName.name);
	maxID += 1;}} catch (error) {
	print(error.toString());throw error;}return maxID;
}


//**************************** add & set ****************************

/// هو إسم الكلاس والإضافة بتكون بكون عشوائي ولا يمكن للمستخدم تحديده collection وبيكون ال  FirebaseFirestore تستخدم للإضافة فى
static Future<String> fire_AddItem(Dealing_Employees  itemDealing_Employees) async {
	String docCreatedName = '';
	await FirebaseFirestore.instance.collection(en_TablesName.Dealing_Employees.name).add(itemDealing_Employees.toMap()).then((val) {
	docCreatedName = val.id;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return docCreatedName;
}

static Future<bool> fire_SetItemMap(String docName, Map<String, dynamic>  itemDealing_Employees) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Dealing_Employees.name).doc(docName).set(itemDealing_Employees).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future<bool> fire_SetItem(String docName, Dealing_Employees  itemDealing_Employees) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Dealing_Employees.name).doc(docName).set(itemDealing_Employees.toMap()).then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
}

static Future fire_setListMaster_And_Details(
	{required String insertdDocID,
	required Dealing_Employees  itemDealing_Employees,
	required String collectionDetailsName,
	required String columnNameAsDocumentDetails,
	required List<Map<String, dynamic>> detais,
	required List<Map<String, dynamic>> deletedItemsDetais,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Dealing_Employees.name);
	DocumentReference tablemasterDocref = coll.doc(insertdDocID);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	// save Master
	batch.set(tablemasterDocref,  itemDealing_Employees.toMap());
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
	required List<Dealing_Employees> lstDealing_Employees,
	}) async {
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Dealing_Employees.name);
	WriteBatch batch = FirebaseFirestore.instance.batch();
	lstDealing_Employees.forEach((elm){
	DocumentReference docRef = coll.doc(elm.ID.toString());
	batch.set(docRef, elm.toMap());
	});
	await batch.commit();
}


//**************************** get ****************************

static Future<Dealing_Employees> fire_getItem(String docName) async {
	late Dealing_Employees  itemDealing_Employees;
	try { var retValue = await FirebaseFirestore.instance.collection(en_TablesName.Dealing_Employees.name).doc(docName).get();
	 itemDealing_Employees = Dealing_Employees();
 itemDealing_Employees.ID = retValue.data()!['ID']; itemDealing_Employees.IDBranch = retValue.data()!['IDBranch']; itemDealing_Employees.Code = retValue.data()!['Code']; itemDealing_Employees.Name = retValue.data()!['Name']; itemDealing_Employees.IsActive = retValue.data()!['IsActive']; itemDealing_Employees.Phone = retValue.data()!['Phone']; itemDealing_Employees.Mobile = retValue.data()!['Mobile']; itemDealing_Employees.Address = retValue.data()!['Address']; itemDealing_Employees.NationalID = retValue.data()!['NationalID']; itemDealing_Employees.BirthDate = retValue.data()!['BirthDate']; itemDealing_Employees.Age = retValue.data()!['Age']; itemDealing_Employees.IDMaritalStatus = retValue.data()!['IDMaritalStatus']; itemDealing_Employees.ChildrenCount = retValue.data()!['ChildrenCount']; itemDealing_Employees.IDReligions = retValue.data()!['IDReligions']; itemDealing_Employees.IDGender = retValue.data()!['IDGender']; itemDealing_Employees.IDMilitaryStatus = retValue.data()!['IDMilitaryStatus']; itemDealing_Employees.Qualification = retValue.data()!['Qualification']; itemDealing_Employees.IDJob = retValue.data()!['IDJob']; itemDealing_Employees.IDDepartment = retValue.data()!['IDDepartment']; itemDealing_Employees.DateHiring = retValue.data()!['DateHiring']; itemDealing_Employees.TimeWorkFrom = retValue.data()!['TimeWorkFrom']; itemDealing_Employees.TimeWorkTo = retValue.data()!['TimeWorkTo']; itemDealing_Employees.TimeTotalWorkHour = retValue.data()!['TimeTotalWorkHour']; itemDealing_Employees.MonthlyVacationDays = retValue.data()!['MonthlyVacationDays']; itemDealing_Employees.ExpiryDateJob = retValue.data()!['ExpiryDateJob']; itemDealing_Employees.LeavingReson = retValue.data()!['LeavingReson']; itemDealing_Employees.SalaryMonthValue = retValue.data()!['SalaryMonthValue']; itemDealing_Employees.SalaryWeekValue = retValue.data()!['SalaryWeekValue']; itemDealing_Employees.SalaryDayValue = retValue.data()!['SalaryDayValue']; itemDealing_Employees.SalaryHourValue = retValue.data()!['SalaryHourValue']; itemDealing_Employees.MonthlyTarget = retValue.data()!['MonthlyTarget']; itemDealing_Employees.MonthlyCommissionExecute = retValue.data()!['MonthlyCommissionExecute']; itemDealing_Employees.MonthlyCommissionNotExecute = retValue.data()!['MonthlyCommissionNotExecute']; itemDealing_Employees.DailyTarget = retValue.data()!['DailyTarget']; itemDealing_Employees.DailyCommissionExecute = retValue.data()!['DailyCommissionExecute']; itemDealing_Employees.DailyCommissionNotExecute = retValue.data()!['DailyCommissionNotExecute']; itemDealing_Employees.CommissionSales1 = retValue.data()!['CommissionSales1']; itemDealing_Employees.CommissionSalesReturned1 = retValue.data()!['CommissionSalesReturned1']; itemDealing_Employees.CommissionSales2 = retValue.data()!['CommissionSales2']; itemDealing_Employees.CommissionSalesReturned2 = retValue.data()!['CommissionSalesReturned2']; itemDealing_Employees.CommissionSales3 = retValue.data()!['CommissionSales3']; itemDealing_Employees.CommissionSalesReturned3 = retValue.data()!['CommissionSalesReturned3']; itemDealing_Employees.CommissionSales4 = retValue.data()!['CommissionSales4']; itemDealing_Employees.CommissionSalesReturned4 = retValue.data()!['CommissionSalesReturned4']; itemDealing_Employees.CommissionSales5 = retValue.data()!['CommissionSales5']; itemDealing_Employees.CommissionSalesReturned5 = retValue.data()!['CommissionSalesReturned5']; itemDealing_Employees.RelativeName1 = retValue.data()!['RelativeName1']; itemDealing_Employees.RelativeMobile1 = retValue.data()!['RelativeMobile1']; itemDealing_Employees.RelativeType1 = retValue.data()!['RelativeType1']; itemDealing_Employees.RelativeName2 = retValue.data()!['RelativeName2']; itemDealing_Employees.RelativeMobile2 = retValue.data()!['RelativeMobile2']; itemDealing_Employees.RelativeType2 = retValue.data()!['RelativeType2']; itemDealing_Employees.RelativeName3 = retValue.data()!['RelativeName3']; itemDealing_Employees.RelativeMobile3 = retValue.data()!['RelativeMobile3']; itemDealing_Employees.RelativeType3 = retValue.data()!['RelativeType3']; itemDealing_Employees.RelativeName4 = retValue.data()!['RelativeName4']; itemDealing_Employees.RelativeMobile4 = retValue.data()!['RelativeMobile4']; itemDealing_Employees.RelativeType4 = retValue.data()!['RelativeType4']; itemDealing_Employees.ImageName = retValue.data()!['ImageName']; itemDealing_Employees.ImageURL = retValue.data()!['ImageURL'];	return  itemDealing_Employees;
	} catch (error) {
	print(error.toString()); throw error;
	}
}

static Future<List<Dealing_Employees>> fire_getList() async {
	await FirebaseFirestore.instance
	.collection(en_TablesName.Dealing_Employees.name)
	.get()
	.then((value) {
	lstDealing_Employees.clear();
	value.docs.forEach((element) {
	lstDealing_Employees.add(Dealing_Employees.fromJson(element.data()));
	});
	}).catchError((error) {
print(error.toString()); throw error;
});
return lstDealing_Employees;
}

static Future<List<Dealing_Employees>> fire_getListByBranch(int branchID , String BranchColumnName) async {
	await FirebaseFirestore.instance.collection(en_TablesName.Dealing_Employees.name)
	.where(BranchColumnName, isEqualTo: branchID).get()
	.then((value) {lstDealing_Employees.clear();value.docs.forEach((element) {
	lstDealing_Employees.add(Dealing_Employees.fromJson(element.data()));});
	}).catchError((error) {print(error.toString());throw error;});
	return lstDealing_Employees;
}

static Future<List<Dealing_Employees>> fire_getListWithConditions({List<BLLCondions>? conditions}) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Dealing_Employees.name);
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
	lstDealing_Employees.clear();
	snap.docs.forEach((element) {
	lstDealing_Employees.add(Dealing_Employees.fromJson(element.data() as Map<String, dynamic> )); });
	return lstDealing_Employees;
}


//**************************** delete ****************************

static Future<bool> fire_DeleteItem(String docName) async {
	bool result = false;
	await FirebaseFirestore.instance.collection(en_TablesName.Dealing_Employees.name).doc(docName).delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); 
	result = false;
	});
	return result;
	}

static Future fire_DeleteListMaster(List<BLLCondions> conditions) async {
	CollectionReference colRef = FirebaseFirestore.instance.collection(en_TablesName.Dealing_Employees.name);
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
	CollectionReference coll = FirebaseFirestore.instance.collection(en_TablesName.Dealing_Employees.name);
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
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Dealing_Employees.name : pathOnStorage;
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
	await firebase_storage.FirebaseStorage.instance.ref().child('${en_TablesName.Dealing_Employees.name}/${fileName}').getDownloadURL().then((URL) {
	fileDownloadURL = URL;
	}).catchError((error) {
	print(error.toString());  throw error;
	});
	return fileDownloadURL;
}

static Future<bool> storage_DeleteFile(String fileName ,{String pathOnStorage = ''}) async {
	bool result = false;
	pathOnStorage = pathOnStorage.isEmpty ? en_TablesName.Dealing_Employees.name : pathOnStorage;
	await firebase_storage.FirebaseStorage.instance.ref().child('${pathOnStorage}/${fileName}').delete().then((val) {
	result = true;
	}).catchError((error) {
	print(error.toString()); throw error;
	});
	return result;
	}

	}

