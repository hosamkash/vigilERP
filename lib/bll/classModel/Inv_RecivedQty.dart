

enum enTable_Inv_RecivedQty{ ID, Code, Date, Time, IDRequestStatus, IDBranchFrom, IDStockFrom, IDEmployee, IDBranchTo, IDStockTo, TotalValueFrom, TotalValueTo, Note, UID, IDTransfer }

class Inv_RecivedQty
	{
		static List<String> ColumnsName = enTable_Inv_RecivedQty.values.map((item) => item.name).toList();

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
 int? IDTransfer;

Inv_RecivedQty({
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
 		this.IDTransfer,
});


//**************************** general function ****************************

Inv_RecivedQty.fromJson(Map<String, dynamic> json) {
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
		 IDTransfer = json['IDTransfer'];
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
	 'IDTransfer' : IDTransfer,
		};
}

static List<dynamic> getColumnAsList(List<Inv_RecivedQty> lstInv_RecivedQty, enTable_Inv_RecivedQty enTable)
	{
	if (enTable == enTable_Inv_RecivedQty.ID) {
		return lstInv_RecivedQty.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQty.Code) {
		return lstInv_RecivedQty.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQty.Date) {
		return lstInv_RecivedQty.map((col) => col.Date).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_RecivedQty.Time) {
		return lstInv_RecivedQty.map((col) => col.Time).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_RecivedQty.IDRequestStatus) {
		return lstInv_RecivedQty.map((col) => col.IDRequestStatus).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQty.IDBranchFrom) {
		return lstInv_RecivedQty.map((col) => col.IDBranchFrom).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQty.IDStockFrom) {
		return lstInv_RecivedQty.map((col) => col.IDStockFrom).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQty.IDEmployee) {
		return lstInv_RecivedQty.map((col) => col.IDEmployee).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQty.IDBranchTo) {
		return lstInv_RecivedQty.map((col) => col.IDBranchTo).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQty.IDStockTo) {
		return lstInv_RecivedQty.map((col) => col.IDStockTo).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQty.TotalValueFrom) {
		return lstInv_RecivedQty.map((col) => col.TotalValueFrom).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_RecivedQty.TotalValueTo) {
		return lstInv_RecivedQty.map((col) => col.TotalValueTo).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_RecivedQty.Note) {
		return lstInv_RecivedQty.map((col) => col.Note).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_RecivedQty.UID) {
		return lstInv_RecivedQty.map((col) => col.UID).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_RecivedQty.IDTransfer) {
		return lstInv_RecivedQty.map((col) => col.IDTransfer).toSet().toList() as List<int>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Inv_RecivedQty> lstInv_RecivedQty, enTable_Inv_RecivedQty enTable)
	{
	if (enTable == enTable_Inv_RecivedQty.ID) {
		return lstInv_RecivedQty.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQty.Code) {
		return lstInv_RecivedQty.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQty.Date) {
		return lstInv_RecivedQty.map((col) => col.Date.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQty.Time) {
		return lstInv_RecivedQty.map((col) => col.Time.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQty.IDRequestStatus) {
		return lstInv_RecivedQty.map((col) => col.IDRequestStatus.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQty.IDBranchFrom) {
		return lstInv_RecivedQty.map((col) => col.IDBranchFrom.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQty.IDStockFrom) {
		return lstInv_RecivedQty.map((col) => col.IDStockFrom.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQty.IDEmployee) {
		return lstInv_RecivedQty.map((col) => col.IDEmployee.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQty.IDBranchTo) {
		return lstInv_RecivedQty.map((col) => col.IDBranchTo.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQty.IDStockTo) {
		return lstInv_RecivedQty.map((col) => col.IDStockTo.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQty.TotalValueFrom) {
		return lstInv_RecivedQty.map((col) => col.TotalValueFrom.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQty.TotalValueTo) {
		return lstInv_RecivedQty.map((col) => col.TotalValueTo.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQty.Note) {
		return lstInv_RecivedQty.map((col) => col.Note.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQty.UID) {
		return lstInv_RecivedQty.map((col) => col.UID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQty.IDTransfer) {
		return lstInv_RecivedQty.map((col) => col.IDTransfer.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

