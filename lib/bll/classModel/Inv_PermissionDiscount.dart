

enum enTable_Inv_PermissionDiscount{ ID, IDBranch, Code, Date, Time, IDStock, IDEmployee, IDRequestStatus, Note, Value, UID }

class Inv_PermissionDiscount
	{
		static List<String> ColumnsName = enTable_Inv_PermissionDiscount.values.map((item) => item.name).toList();

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

Inv_PermissionDiscount({
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

Inv_PermissionDiscount.fromJson(Map<String, dynamic> json) {
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

static List<dynamic> getColumnAsList(List<Inv_PermissionDiscount> lstInv_PermissionDiscount, enTable_Inv_PermissionDiscount enTable)
	{
	if (enTable == enTable_Inv_PermissionDiscount.ID) {
		return lstInv_PermissionDiscount.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionDiscount.IDBranch) {
		return lstInv_PermissionDiscount.map((col) => col.IDBranch).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionDiscount.Code) {
		return lstInv_PermissionDiscount.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionDiscount.Date) {
		return lstInv_PermissionDiscount.map((col) => col.Date).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_PermissionDiscount.Time) {
		return lstInv_PermissionDiscount.map((col) => col.Time).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_PermissionDiscount.IDStock) {
		return lstInv_PermissionDiscount.map((col) => col.IDStock).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionDiscount.IDEmployee) {
		return lstInv_PermissionDiscount.map((col) => col.IDEmployee).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionDiscount.IDRequestStatus) {
		return lstInv_PermissionDiscount.map((col) => col.IDRequestStatus).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionDiscount.Note) {
		return lstInv_PermissionDiscount.map((col) => col.Note).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_PermissionDiscount.Value) {
		return lstInv_PermissionDiscount.map((col) => col.Value).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_PermissionDiscount.UID) {
		return lstInv_PermissionDiscount.map((col) => col.UID).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Inv_PermissionDiscount> lstInv_PermissionDiscount, enTable_Inv_PermissionDiscount enTable)
	{
	if (enTable == enTable_Inv_PermissionDiscount.ID) {
		return lstInv_PermissionDiscount.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscount.IDBranch) {
		return lstInv_PermissionDiscount.map((col) => col.IDBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscount.Code) {
		return lstInv_PermissionDiscount.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscount.Date) {
		return lstInv_PermissionDiscount.map((col) => col.Date.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscount.Time) {
		return lstInv_PermissionDiscount.map((col) => col.Time.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscount.IDStock) {
		return lstInv_PermissionDiscount.map((col) => col.IDStock.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscount.IDEmployee) {
		return lstInv_PermissionDiscount.map((col) => col.IDEmployee.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscount.IDRequestStatus) {
		return lstInv_PermissionDiscount.map((col) => col.IDRequestStatus.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscount.Note) {
		return lstInv_PermissionDiscount.map((col) => col.Note.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscount.Value) {
		return lstInv_PermissionDiscount.map((col) => col.Value.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscount.UID) {
		return lstInv_PermissionDiscount.map((col) => col.UID.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

