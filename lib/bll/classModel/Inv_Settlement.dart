

enum enTable_Inv_Settlement{ ID, IDBranch, Code, Date, Time, IDStock, IDEmployee, IDRequestStatus, Note, SettlementAddValue, SettlementDiscountValue, NetValue, UID }

class Inv_Settlement
	{
		static List<String> ColumnsName = enTable_Inv_Settlement.values.map((item) => item.name).toList();

 int? ID;
 int? IDBranch;
 int? Code;
 String? Date;
 String? Time;
 int? IDStock;
 int? IDEmployee;
 int? IDRequestStatus;
 String? Note;
 double? SettlementAddValue;
 double? SettlementDiscountValue;
 double? NetValue;
 String? UID;

Inv_Settlement({
 		this.ID,
 		this.IDBranch,
 		this.Code,
 		this.Date,
 		this.Time,
 		this.IDStock,
 		this.IDEmployee,
 		this.IDRequestStatus,
 		this.Note,
 		this.SettlementAddValue,
 		this.SettlementDiscountValue,
 		this.NetValue,
 		this.UID,
});


//**************************** general function ****************************

Inv_Settlement.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 IDBranch = json['IDBranch'];
		 Code = json['Code'];
		 Date = json['Date'].toString();
		 Time = json['Time'].toString();
		 IDStock = json['IDStock'];
		 IDEmployee = json['IDEmployee'];
		 IDRequestStatus = json['IDRequestStatus'];
		 Note = json['Note'].toString();
		 SettlementAddValue = json['SettlementAddValue'];
		 SettlementDiscountValue = json['SettlementDiscountValue'];
		 NetValue = json['NetValue'];
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
	 'SettlementAddValue' : SettlementAddValue,
	 'SettlementDiscountValue' : SettlementDiscountValue,
	 'NetValue' : NetValue,
	 'UID' : UID,
		};
}

static List<dynamic> getColumnAsList(List<Inv_Settlement> lstInv_Settlement, enTable_Inv_Settlement enTable)
	{
	if (enTable == enTable_Inv_Settlement.ID) {
		return lstInv_Settlement.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_Settlement.IDBranch) {
		return lstInv_Settlement.map((col) => col.IDBranch).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_Settlement.Code) {
		return lstInv_Settlement.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_Settlement.Date) {
		return lstInv_Settlement.map((col) => col.Date).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_Settlement.Time) {
		return lstInv_Settlement.map((col) => col.Time).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_Settlement.IDStock) {
		return lstInv_Settlement.map((col) => col.IDStock).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_Settlement.IDEmployee) {
		return lstInv_Settlement.map((col) => col.IDEmployee).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_Settlement.IDRequestStatus) {
		return lstInv_Settlement.map((col) => col.IDRequestStatus).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_Settlement.Note) {
		return lstInv_Settlement.map((col) => col.Note).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_Settlement.SettlementAddValue) {
		return lstInv_Settlement.map((col) => col.SettlementAddValue).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_Settlement.SettlementDiscountValue) {
		return lstInv_Settlement.map((col) => col.SettlementDiscountValue).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_Settlement.NetValue) {
		return lstInv_Settlement.map((col) => col.NetValue).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_Settlement.UID) {
		return lstInv_Settlement.map((col) => col.UID).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Inv_Settlement> lstInv_Settlement, enTable_Inv_Settlement enTable)
	{
	if (enTable == enTable_Inv_Settlement.ID) {
		return lstInv_Settlement.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Settlement.IDBranch) {
		return lstInv_Settlement.map((col) => col.IDBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Settlement.Code) {
		return lstInv_Settlement.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Settlement.Date) {
		return lstInv_Settlement.map((col) => col.Date.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Settlement.Time) {
		return lstInv_Settlement.map((col) => col.Time.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Settlement.IDStock) {
		return lstInv_Settlement.map((col) => col.IDStock.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Settlement.IDEmployee) {
		return lstInv_Settlement.map((col) => col.IDEmployee.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Settlement.IDRequestStatus) {
		return lstInv_Settlement.map((col) => col.IDRequestStatus.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Settlement.Note) {
		return lstInv_Settlement.map((col) => col.Note.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Settlement.SettlementAddValue) {
		return lstInv_Settlement.map((col) => col.SettlementAddValue.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Settlement.SettlementDiscountValue) {
		return lstInv_Settlement.map((col) => col.SettlementDiscountValue.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Settlement.NetValue) {
		return lstInv_Settlement.map((col) => col.NetValue.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_Settlement.UID) {
		return lstInv_Settlement.map((col) => col.UID.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

