

enum enTable_Inv_Transfer{ ID, Code, Date, Time, IDRequestStatus, IDBranchFrom, IDStockFrom, IDEmployee, IDBranchTo, IDStockTo, TotalValueFrom, TotalValueTo, Note, UID }

class Inv_Transfer
	{
		static List<String> ColumnsName = enTable_Inv_Transfer.values.map((item) => item.name).toList();

 int? ID;
 int? Code;
 String? Date;
 String? Time;
 int? IDRequestStatus;
 int? IDBranchFrom;
 int? IDStockFrom;
 int? IDEmployee;
 int? IDBranchTo;
 int? IDStockTo;
 double? TotalValueFrom;
 double? TotalValueTo;
 String? Note;
 String? UID;

Inv_Transfer({
 		this.ID,
 		this.Code,
 		this.Date,
 		this.Time,
 		this.IDRequestStatus,
 		this.IDBranchFrom,
 		this.IDStockFrom,
 		this.IDEmployee,
 		this.IDBranchTo,
 		this.IDStockTo,
 		this.TotalValueFrom,
 		this.TotalValueTo,
 		this.Note,
 		this.UID,
});


//**************************** general function ****************************

Inv_Transfer.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Code = json['Code'];
		 Date = json['Date'].toString();
		 Time = json['Time'].toString();
		 IDRequestStatus = json['IDRequestStatus'];
		 IDBranchFrom = json['IDBranchFrom'];
		 IDStockFrom = json['IDStockFrom'];
		 IDEmployee = json['IDEmployee'];
		 IDBranchTo = json['IDBranchTo'];
		 IDStockTo = json['IDStockTo'];
		 TotalValueFrom = json['TotalValueFrom'];
		 TotalValueTo = json['TotalValueTo'];
		 Note = json['Note'].toString();
		 UID = json['UID'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Code' : Code,
	 'Date' : Date,
	 'Time' : Time,
	 'IDRequestStatus' : IDRequestStatus,
	 'IDBranchFrom' : IDBranchFrom,
	 'IDStockFrom' : IDStockFrom,
	 'IDEmployee' : IDEmployee,
	 'IDBranchTo' : IDBranchTo,
	 'IDStockTo' : IDStockTo,
	 'TotalValueFrom' : TotalValueFrom,
	 'TotalValueTo' : TotalValueTo,
	 'Note' : Note,
	 'UID' : UID,
		};
}

static List<dynamic> getColumnAsList(List<Inv_Transfer> lstInv_Transfer, enTable_Inv_Transfer enTable)
	{
	if (enTable == enTable_Inv_Transfer.ID) {
		return lstInv_Transfer.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_Transfer.Code) {
		return lstInv_Transfer.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_Transfer.Date) {
		return lstInv_Transfer.map((col) => col.Date).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_Transfer.Time) {
		return lstInv_Transfer.map((col) => col.Time).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_Transfer.IDRequestStatus) {
		return lstInv_Transfer.map((col) => col.IDRequestStatus).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_Transfer.IDBranchFrom) {
		return lstInv_Transfer.map((col) => col.IDBranchFrom).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_Transfer.IDStockFrom) {
		return lstInv_Transfer.map((col) => col.IDStockFrom).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_Transfer.IDEmployee) {
		return lstInv_Transfer.map((col) => col.IDEmployee).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_Transfer.IDBranchTo) {
		return lstInv_Transfer.map((col) => col.IDBranchTo).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_Transfer.IDStockTo) {
		return lstInv_Transfer.map((col) => col.IDStockTo).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_Transfer.TotalValueFrom) {
		return lstInv_Transfer.map((col) => col.TotalValueFrom).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_Transfer.TotalValueTo) {
		return lstInv_Transfer.map((col) => col.TotalValueTo).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_Transfer.Note) {
		return lstInv_Transfer.map((col) => col.Note).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_Transfer.UID) {
		return lstInv_Transfer.map((col) => col.UID).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Inv_Transfer> lstInv_Transfer, enTable_Inv_Transfer enTable)
	{
	if (enTable == enTable_Inv_Transfer.ID) {
		return lstInv_Transfer.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Transfer.Code) {
		return lstInv_Transfer.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Transfer.Date) {
		return lstInv_Transfer.map((col) => col.Date.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Transfer.Time) {
		return lstInv_Transfer.map((col) => col.Time.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Transfer.IDRequestStatus) {
		return lstInv_Transfer.map((col) => col.IDRequestStatus.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Transfer.IDBranchFrom) {
		return lstInv_Transfer.map((col) => col.IDBranchFrom.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Transfer.IDStockFrom) {
		return lstInv_Transfer.map((col) => col.IDStockFrom.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Transfer.IDEmployee) {
		return lstInv_Transfer.map((col) => col.IDEmployee.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Transfer.IDBranchTo) {
		return lstInv_Transfer.map((col) => col.IDBranchTo.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Transfer.IDStockTo) {
		return lstInv_Transfer.map((col) => col.IDStockTo.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Transfer.TotalValueFrom) {
		return lstInv_Transfer.map((col) => col.TotalValueFrom.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Transfer.TotalValueTo) {
		return lstInv_Transfer.map((col) => col.TotalValueTo.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Transfer.Note) {
		return lstInv_Transfer.map((col) => col.Note.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Transfer.UID) {
		return lstInv_Transfer.map((col) => col.UID.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

