

enum enTable_Inv_PermissionAdd{ ID, IDBranch, Code, Date, Time, IDStock, IDEmployee, IDRequestStatus, Note, Value, UID }

class Inv_PermissionAdd
	{
		static List<String> ColumnsName = enTable_Inv_PermissionAdd.values.map((item) => item.name).toList();

 int? ID;
 int? IDBranch;
 int? Code;
 String? Date;
 String? Time;
 int? IDStock;
 int? IDEmployee;
 int? IDRequestStatus;
 String? Note;
 double? Value;
 String? UID;

Inv_PermissionAdd({
 		this.ID,
 		this.IDBranch,
 		this.Code,
 		this.Date,
 		this.Time,
 		this.IDStock,
 		this.IDEmployee,
 		this.IDRequestStatus,
 		this.Note,
 		this.Value,
 		this.UID,
});


//**************************** general function ****************************

Inv_PermissionAdd.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 IDBranch = json['IDBranch'];
		 Code = json['Code'];
		 Date = json['Date'].toString();
		 Time = json['Time'].toString();
		 IDStock = json['IDStock'];
		 IDEmployee = json['IDEmployee'];
		 IDRequestStatus = json['IDRequestStatus'];
		 Note = json['Note'].toString();
		 Value = json['Value'];
		 UID = json['UID'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'IDBranch' : IDBranch,
	 'Code' : Code,
	 'Date' : Date,
	 'Time' : Time,
	 'IDStock' : IDStock,
	 'IDEmployee' : IDEmployee,
	 'IDRequestStatus' : IDRequestStatus,
	 'Note' : Note,
	 'Value' : Value,
	 'UID' : UID,
		};
}

static List<dynamic> getColumnAsList(List<Inv_PermissionAdd> lstInv_PermissionAdd, enTable_Inv_PermissionAdd enTable)
	{
	if (enTable == enTable_Inv_PermissionAdd.ID) {
		return lstInv_PermissionAdd.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionAdd.IDBranch) {
		return lstInv_PermissionAdd.map((col) => col.IDBranch).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionAdd.Code) {
		return lstInv_PermissionAdd.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionAdd.Date) {
		return lstInv_PermissionAdd.map((col) => col.Date).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_PermissionAdd.Time) {
		return lstInv_PermissionAdd.map((col) => col.Time).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_PermissionAdd.IDStock) {
		return lstInv_PermissionAdd.map((col) => col.IDStock).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionAdd.IDEmployee) {
		return lstInv_PermissionAdd.map((col) => col.IDEmployee).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionAdd.IDRequestStatus) {
		return lstInv_PermissionAdd.map((col) => col.IDRequestStatus).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionAdd.Note) {
		return lstInv_PermissionAdd.map((col) => col.Note).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_PermissionAdd.Value) {
		return lstInv_PermissionAdd.map((col) => col.Value).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_PermissionAdd.UID) {
		return lstInv_PermissionAdd.map((col) => col.UID).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Inv_PermissionAdd> lstInv_PermissionAdd, enTable_Inv_PermissionAdd enTable)
	{
	if (enTable == enTable_Inv_PermissionAdd.ID) {
		return lstInv_PermissionAdd.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAdd.IDBranch) {
		return lstInv_PermissionAdd.map((col) => col.IDBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAdd.Code) {
		return lstInv_PermissionAdd.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAdd.Date) {
		return lstInv_PermissionAdd.map((col) => col.Date.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAdd.Time) {
		return lstInv_PermissionAdd.map((col) => col.Time.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAdd.IDStock) {
		return lstInv_PermissionAdd.map((col) => col.IDStock.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAdd.IDEmployee) {
		return lstInv_PermissionAdd.map((col) => col.IDEmployee.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAdd.IDRequestStatus) {
		return lstInv_PermissionAdd.map((col) => col.IDRequestStatus.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAdd.Note) {
		return lstInv_PermissionAdd.map((col) => col.Note.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAdd.Value) {
		return lstInv_PermissionAdd.map((col) => col.Value.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAdd.UID) {
		return lstInv_PermissionAdd.map((col) => col.UID.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

