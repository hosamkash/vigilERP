

enum enTable_Fina_ClosedTreasure{ ID, Code, Date, Time, IDEmployee, IDBranchFrom, IDTreasurFrom, BalanceTreasurFrom, IDBranchTo, IDTreasurTo, BalanceTreasurTo, Value, Note, UID, IsClosed }

class Fina_ClosedTreasure
	{
		static List<String> ColumnsName = enTable_Fina_ClosedTreasure.values.map((item) => item.name).toList();

 int? ID;
 int? Code;
 String? Date;
 String? Time;
 int? IDEmployee;
 int? IDBranchFrom;
 int? IDTreasurFrom;
 double? BalanceTreasurFrom;
 int? IDBranchTo;
 int? IDTreasurTo;
 double? BalanceTreasurTo;
 double? Value;
 String? Note;
 String? UID;
 bool? IsClosed;

Fina_ClosedTreasure({
 		this.ID,
 		this.Code,
 		this.Date,
 		this.Time,
 		this.IDEmployee,
 		this.IDBranchFrom,
 		this.IDTreasurFrom,
 		this.BalanceTreasurFrom,
 		this.IDBranchTo,
 		this.IDTreasurTo,
 		this.BalanceTreasurTo,
 		this.Value,
 		this.Note,
 		this.UID,
 		this.IsClosed,
});


//**************************** general function ****************************

Fina_ClosedTreasure.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Code = json['Code'];
		 Date = json['Date'].toString();
		 Time = json['Time'].toString();
		 IDEmployee = json['IDEmployee'];
		 IDBranchFrom = json['IDBranchFrom'];
		 IDTreasurFrom = json['IDTreasurFrom'];
		 BalanceTreasurFrom = json['BalanceTreasurFrom'];
		 IDBranchTo = json['IDBranchTo'];
		 IDTreasurTo = json['IDTreasurTo'];
		 BalanceTreasurTo = json['BalanceTreasurTo'];
		 Value = json['Value'];
		 Note = json['Note'].toString();
		 UID = json['UID'].toString();
		 IsClosed = json['IsClosed'];
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Code' : Code,
	 'Date' : Date,
	 'Time' : Time,
	 'IDEmployee' : IDEmployee,
	 'IDBranchFrom' : IDBranchFrom,
	 'IDTreasurFrom' : IDTreasurFrom,
	 'BalanceTreasurFrom' : BalanceTreasurFrom,
	 'IDBranchTo' : IDBranchTo,
	 'IDTreasurTo' : IDTreasurTo,
	 'BalanceTreasurTo' : BalanceTreasurTo,
	 'Value' : Value,
	 'Note' : Note,
	 'UID' : UID,
	 'IsClosed' : IsClosed,
		};
}

static List<dynamic> getColumnAsList(List<Fina_ClosedTreasure> lstFina_ClosedTreasure, enTable_Fina_ClosedTreasure enTable)
	{
	if (enTable == enTable_Fina_ClosedTreasure.ID) {
		return lstFina_ClosedTreasure.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_ClosedTreasure.Code) {
		return lstFina_ClosedTreasure.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_ClosedTreasure.Date) {
		return lstFina_ClosedTreasure.map((col) => col.Date).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_ClosedTreasure.Time) {
		return lstFina_ClosedTreasure.map((col) => col.Time).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_ClosedTreasure.IDEmployee) {
		return lstFina_ClosedTreasure.map((col) => col.IDEmployee).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_ClosedTreasure.IDBranchFrom) {
		return lstFina_ClosedTreasure.map((col) => col.IDBranchFrom).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_ClosedTreasure.IDTreasurFrom) {
		return lstFina_ClosedTreasure.map((col) => col.IDTreasurFrom).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_ClosedTreasure.BalanceTreasurFrom) {
		return lstFina_ClosedTreasure.map((col) => col.BalanceTreasurFrom).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Fina_ClosedTreasure.IDBranchTo) {
		return lstFina_ClosedTreasure.map((col) => col.IDBranchTo).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_ClosedTreasure.IDTreasurTo) {
		return lstFina_ClosedTreasure.map((col) => col.IDTreasurTo).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_ClosedTreasure.BalanceTreasurTo) {
		return lstFina_ClosedTreasure.map((col) => col.BalanceTreasurTo).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Fina_ClosedTreasure.Value) {
		return lstFina_ClosedTreasure.map((col) => col.Value).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Fina_ClosedTreasure.Note) {
		return lstFina_ClosedTreasure.map((col) => col.Note).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_ClosedTreasure.UID) {
		return lstFina_ClosedTreasure.map((col) => col.UID).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_ClosedTreasure.IsClosed) {
		return lstFina_ClosedTreasure.map((col) => col.IsClosed).toSet().toList() as List<bool>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fina_ClosedTreasure> lstFina_ClosedTreasure, enTable_Fina_ClosedTreasure enTable)
	{
	if (enTable == enTable_Fina_ClosedTreasure.ID) {
		return lstFina_ClosedTreasure.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_ClosedTreasure.Code) {
		return lstFina_ClosedTreasure.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_ClosedTreasure.Date) {
		return lstFina_ClosedTreasure.map((col) => col.Date.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_ClosedTreasure.Time) {
		return lstFina_ClosedTreasure.map((col) => col.Time.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_ClosedTreasure.IDEmployee) {
		return lstFina_ClosedTreasure.map((col) => col.IDEmployee.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_ClosedTreasure.IDBranchFrom) {
		return lstFina_ClosedTreasure.map((col) => col.IDBranchFrom.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_ClosedTreasure.IDTreasurFrom) {
		return lstFina_ClosedTreasure.map((col) => col.IDTreasurFrom.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_ClosedTreasure.BalanceTreasurFrom) {
		return lstFina_ClosedTreasure.map((col) => col.BalanceTreasurFrom.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_ClosedTreasure.IDBranchTo) {
		return lstFina_ClosedTreasure.map((col) => col.IDBranchTo.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_ClosedTreasure.IDTreasurTo) {
		return lstFina_ClosedTreasure.map((col) => col.IDTreasurTo.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_ClosedTreasure.BalanceTreasurTo) {
		return lstFina_ClosedTreasure.map((col) => col.BalanceTreasurTo.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_ClosedTreasure.Value) {
		return lstFina_ClosedTreasure.map((col) => col.Value.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_ClosedTreasure.Note) {
		return lstFina_ClosedTreasure.map((col) => col.Note.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_ClosedTreasure.UID) {
		return lstFina_ClosedTreasure.map((col) => col.UID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_ClosedTreasure.IsClosed) {
		return lstFina_ClosedTreasure.map((col) => col.IsClosed.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

