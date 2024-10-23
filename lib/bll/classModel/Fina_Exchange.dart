

enum enTable_Fina_Exchange{ ID, Code, Serial, Date, Time, IDTreasur, DealingTypeID, DealingID, BalanceBefor, Value, BalanceAfter, IDFinancialType, IDFinancialCluses, Note, IsBindeDocument, BindeDocumentTypeID, BindeDocumentID, BindeDocumentText, BindeDocumentCode, IsAccountedByRepresent, IDUser, IDBranch, IsClosedTreasure, IDClosedTreasure, IsClosedEdit, IDCalcSalary }

class Fina_Exchange
	{
		static List<String> ColumnsName = enTable_Fina_Exchange.values.map((item) => item.name).toList();

 int? ID;
 int? Code;
 String? Serial;
 String? Date;
 String? Time;
 int? IDTreasur;
 int? DealingTypeID;
 int? DealingID;
 double? BalanceBefor;
 double? Value;
 double? BalanceAfter;
 int? IDFinancialType;
 int? IDFinancialCluses;
 String? Note;
 bool? IsBindeDocument;
 int? BindeDocumentTypeID;
 int? BindeDocumentID;
 String? BindeDocumentText;
 int? BindeDocumentCode;
 bool? IsAccountedByRepresent;
 int? IDUser;
 int? IDBranch;
 bool? IsClosedTreasure;
 int? IDClosedTreasure;
 bool? IsClosedEdit;
 int? IDCalcSalary;

Fina_Exchange({
 		this.ID,
 		this.Code,
 		this.Serial,
 		this.Date,
 		this.Time,
 		this.IDTreasur,
 		this.DealingTypeID,
 		this.DealingID,
 		this.BalanceBefor,
 		this.Value,
 		this.BalanceAfter,
 		this.IDFinancialType,
 		this.IDFinancialCluses,
 		this.Note,
 		this.IsBindeDocument,
 		this.BindeDocumentTypeID,
 		this.BindeDocumentID,
 		this.BindeDocumentText,
 		this.BindeDocumentCode,
 		this.IsAccountedByRepresent,
 		this.IDUser,
 		this.IDBranch,
 		this.IsClosedTreasure,
 		this.IDClosedTreasure,
 		this.IsClosedEdit,
 		this.IDCalcSalary,
});


//**************************** general function ****************************

Fina_Exchange.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Code = json['Code'];
		 Serial = json['Serial'].toString();
		 Date = json['Date'].toString();
		 Time = json['Time'].toString();
		 IDTreasur = json['IDTreasur'];
		 DealingTypeID = json['DealingTypeID'];
		 DealingID = json['DealingID'];
		 BalanceBefor = json['BalanceBefor'];
		 Value = json['Value'];
		 BalanceAfter = json['BalanceAfter'];
		 IDFinancialType = json['IDFinancialType'];
		 IDFinancialCluses = json['IDFinancialCluses'];
		 Note = json['Note'].toString();
		 IsBindeDocument = json['IsBindeDocument'];
		 BindeDocumentTypeID = json['BindeDocumentTypeID'];
		 BindeDocumentID = json['BindeDocumentID'];
		 BindeDocumentText = json['BindeDocumentText'].toString();
		 BindeDocumentCode = json['BindeDocumentCode'];
		 IsAccountedByRepresent = json['IsAccountedByRepresent'];
		 IDUser = json['IDUser'];
		 IDBranch = json['IDBranch'];
		 IsClosedTreasure = json['IsClosedTreasure'];
		 IDClosedTreasure = json['IDClosedTreasure'];
		 IsClosedEdit = json['IsClosedEdit'];
		 IDCalcSalary = json['IDCalcSalary'];
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Code' : Code,
	 'Serial' : Serial,
	 'Date' : Date,
	 'Time' : Time,
	 'IDTreasur' : IDTreasur,
	 'DealingTypeID' : DealingTypeID,
	 'DealingID' : DealingID,
	 'BalanceBefor' : BalanceBefor,
	 'Value' : Value,
	 'BalanceAfter' : BalanceAfter,
	 'IDFinancialType' : IDFinancialType,
	 'IDFinancialCluses' : IDFinancialCluses,
	 'Note' : Note,
	 'IsBindeDocument' : IsBindeDocument,
	 'BindeDocumentTypeID' : BindeDocumentTypeID,
	 'BindeDocumentID' : BindeDocumentID,
	 'BindeDocumentText' : BindeDocumentText,
	 'BindeDocumentCode' : BindeDocumentCode,
	 'IsAccountedByRepresent' : IsAccountedByRepresent,
	 'IDUser' : IDUser,
	 'IDBranch' : IDBranch,
	 'IsClosedTreasure' : IsClosedTreasure,
	 'IDClosedTreasure' : IDClosedTreasure,
	 'IsClosedEdit' : IsClosedEdit,
	 'IDCalcSalary' : IDCalcSalary,
		};
}

static List<dynamic> getColumnAsList(List<Fina_Exchange> lstFina_Exchange, enTable_Fina_Exchange enTable)
	{
	if (enTable == enTable_Fina_Exchange.ID) {
		return lstFina_Exchange.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_Exchange.Code) {
		return lstFina_Exchange.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_Exchange.Serial) {
		return lstFina_Exchange.map((col) => col.Serial).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_Exchange.Date) {
		return lstFina_Exchange.map((col) => col.Date).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_Exchange.Time) {
		return lstFina_Exchange.map((col) => col.Time).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_Exchange.IDTreasur) {
		return lstFina_Exchange.map((col) => col.IDTreasur).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_Exchange.DealingTypeID) {
		return lstFina_Exchange.map((col) => col.DealingTypeID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_Exchange.DealingID) {
		return lstFina_Exchange.map((col) => col.DealingID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_Exchange.BalanceBefor) {
		return lstFina_Exchange.map((col) => col.BalanceBefor).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Fina_Exchange.Value) {
		return lstFina_Exchange.map((col) => col.Value).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Fina_Exchange.BalanceAfter) {
		return lstFina_Exchange.map((col) => col.BalanceAfter).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Fina_Exchange.IDFinancialType) {
		return lstFina_Exchange.map((col) => col.IDFinancialType).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_Exchange.IDFinancialCluses) {
		return lstFina_Exchange.map((col) => col.IDFinancialCluses).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_Exchange.Note) {
		return lstFina_Exchange.map((col) => col.Note).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_Exchange.IsBindeDocument) {
		return lstFina_Exchange.map((col) => col.IsBindeDocument).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Fina_Exchange.BindeDocumentTypeID) {
		return lstFina_Exchange.map((col) => col.BindeDocumentTypeID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_Exchange.BindeDocumentID) {
		return lstFina_Exchange.map((col) => col.BindeDocumentID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_Exchange.BindeDocumentText) {
		return lstFina_Exchange.map((col) => col.BindeDocumentText).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_Exchange.BindeDocumentCode) {
		return lstFina_Exchange.map((col) => col.BindeDocumentCode).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_Exchange.IsAccountedByRepresent) {
		return lstFina_Exchange.map((col) => col.IsAccountedByRepresent).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Fina_Exchange.IDUser) {
		return lstFina_Exchange.map((col) => col.IDUser).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_Exchange.IDBranch) {
		return lstFina_Exchange.map((col) => col.IDBranch).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_Exchange.IsClosedTreasure) {
		return lstFina_Exchange.map((col) => col.IsClosedTreasure).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Fina_Exchange.IDClosedTreasure) {
		return lstFina_Exchange.map((col) => col.IDClosedTreasure).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_Exchange.IsClosedEdit) {
		return lstFina_Exchange.map((col) => col.IsClosedEdit).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Fina_Exchange.IDCalcSalary) {
		return lstFina_Exchange.map((col) => col.IDCalcSalary).toSet().toList() as List<int>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fina_Exchange> lstFina_Exchange, enTable_Fina_Exchange enTable)
	{
	if (enTable == enTable_Fina_Exchange.ID) {
		return lstFina_Exchange.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.Code) {
		return lstFina_Exchange.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.Serial) {
		return lstFina_Exchange.map((col) => col.Serial.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.Date) {
		return lstFina_Exchange.map((col) => col.Date.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.Time) {
		return lstFina_Exchange.map((col) => col.Time.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.IDTreasur) {
		return lstFina_Exchange.map((col) => col.IDTreasur.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.DealingTypeID) {
		return lstFina_Exchange.map((col) => col.DealingTypeID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.DealingID) {
		return lstFina_Exchange.map((col) => col.DealingID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.BalanceBefor) {
		return lstFina_Exchange.map((col) => col.BalanceBefor.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.Value) {
		return lstFina_Exchange.map((col) => col.Value.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.BalanceAfter) {
		return lstFina_Exchange.map((col) => col.BalanceAfter.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.IDFinancialType) {
		return lstFina_Exchange.map((col) => col.IDFinancialType.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.IDFinancialCluses) {
		return lstFina_Exchange.map((col) => col.IDFinancialCluses.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.Note) {
		return lstFina_Exchange.map((col) => col.Note.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.IsBindeDocument) {
		return lstFina_Exchange.map((col) => col.IsBindeDocument.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.BindeDocumentTypeID) {
		return lstFina_Exchange.map((col) => col.BindeDocumentTypeID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.BindeDocumentID) {
		return lstFina_Exchange.map((col) => col.BindeDocumentID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.BindeDocumentText) {
		return lstFina_Exchange.map((col) => col.BindeDocumentText.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.BindeDocumentCode) {
		return lstFina_Exchange.map((col) => col.BindeDocumentCode.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.IsAccountedByRepresent) {
		return lstFina_Exchange.map((col) => col.IsAccountedByRepresent.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.IDUser) {
		return lstFina_Exchange.map((col) => col.IDUser.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.IDBranch) {
		return lstFina_Exchange.map((col) => col.IDBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.IsClosedTreasure) {
		return lstFina_Exchange.map((col) => col.IsClosedTreasure.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.IDClosedTreasure) {
		return lstFina_Exchange.map((col) => col.IDClosedTreasure.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.IsClosedEdit) {
		return lstFina_Exchange.map((col) => col.IsClosedEdit.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_Exchange.IDCalcSalary) {
		return lstFina_Exchange.map((col) => col.IDCalcSalary.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

