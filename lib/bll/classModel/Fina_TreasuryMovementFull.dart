

enum enTable_Fina_TreasuryMovementFull{ ID, Code, Serial, Date, Time, IDTreasur, TreasurName, DealingTypeID, DealingTypeName, DealingID, DealingName, BalanceBefor, Value, BalanceAfter, IDFinancialCluses, FinancialClusesName, Note, IsBindeDocument, BindeDocumentTypeID, BindeDocumentID, BindeDocumentText, BindeDocumentCode, IsAccountedByRepresent, IDUser, IDBranch, BranchName, IsTransfere, IDTransfere, IsClosedEdit, IDCalcSalary, FinacialTypeID, FinacialTypeName }

class Fina_TreasuryMovementFull
	{
		static List<String> ColumnsName = enTable_Fina_TreasuryMovementFull.values.map((item) => item.name).toList();

 int? ID;
 int? Code;
 String? Serial;
 String? Date;
 String? Time;
 int? IDTreasur;
 String? TreasurName;
 int? DealingTypeID;
 String? DealingTypeName;
 int? DealingID;
 String? DealingName;
 double? BalanceBefor;
 double? Value;
 double? BalanceAfter;
 int? IDFinancialCluses;
 String? FinancialClusesName;
 String? Note;
 bool? IsBindeDocument;
 int? BindeDocumentTypeID;
 int? BindeDocumentID;
 String? BindeDocumentText;
 int? BindeDocumentCode;
 bool? IsAccountedByRepresent;
 int? IDUser;
 int? IDBranch;
 String? BranchName;
 bool? IsTransfere;
 int? IDTransfere;
 bool? IsClosedEdit;
 int? IDCalcSalary;
 int? FinacialTypeID;
 String? FinacialTypeName;

Fina_TreasuryMovementFull({
 		this.ID,
 		this.Code,
 		this.Serial,
 		this.Date,
 		this.Time,
 		this.IDTreasur,
 		this.TreasurName,
 		this.DealingTypeID,
 		this.DealingTypeName,
 		this.DealingID,
 		this.DealingName,
 		this.BalanceBefor,
 		this.Value,
 		this.BalanceAfter,
 		this.IDFinancialCluses,
 		this.FinancialClusesName,
 		this.Note,
 		this.IsBindeDocument,
 		this.BindeDocumentTypeID,
 		this.BindeDocumentID,
 		this.BindeDocumentText,
 		this.BindeDocumentCode,
 		this.IsAccountedByRepresent,
 		this.IDUser,
 		this.IDBranch,
 		this.BranchName,
 		this.IsTransfere,
 		this.IDTransfere,
 		this.IsClosedEdit,
 		this.IDCalcSalary,
 		this.FinacialTypeID,
 		this.FinacialTypeName,
});


//**************************** general function ****************************

Fina_TreasuryMovementFull.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Code = json['Code'];
		 Serial = json['Serial'].toString();
		 Date = json['Date'].toString();
		 Time = json['Time'].toString();
		 IDTreasur = json['IDTreasur'];
		 TreasurName = json['TreasurName'].toString();
		 DealingTypeID = json['DealingTypeID'];
		 DealingTypeName = json['DealingTypeName'].toString();
		 DealingID = json['DealingID'];
		 DealingName = json['DealingName'].toString();
		 BalanceBefor = json['BalanceBefor'];
		 Value = json['Value'];
		 BalanceAfter = json['BalanceAfter'];
		 IDFinancialCluses = json['IDFinancialCluses'];
		 FinancialClusesName = json['FinancialClusesName'].toString();
		 Note = json['Note'].toString();
		 IsBindeDocument = json['IsBindeDocument'];
		 BindeDocumentTypeID = json['BindeDocumentTypeID'];
		 BindeDocumentID = json['BindeDocumentID'];
		 BindeDocumentText = json['BindeDocumentText'].toString();
		 BindeDocumentCode = json['BindeDocumentCode'];
		 IsAccountedByRepresent = json['IsAccountedByRepresent'];
		 IDUser = json['IDUser'];
		 IDBranch = json['IDBranch'];
		 BranchName = json['BranchName'].toString();
		 IsTransfere = json['IsTransfere'];
		 IDTransfere = json['IDTransfere'];
		 IsClosedEdit = json['IsClosedEdit'];
		 IDCalcSalary = json['IDCalcSalary'];
		 FinacialTypeID = json['FinacialTypeID'];
		 FinacialTypeName = json['FinacialTypeName'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Code' : Code,
	 'Serial' : Serial,
	 'Date' : Date,
	 'Time' : Time,
	 'IDTreasur' : IDTreasur,
	 'TreasurName' : TreasurName,
	 'DealingTypeID' : DealingTypeID,
	 'DealingTypeName' : DealingTypeName,
	 'DealingID' : DealingID,
	 'DealingName' : DealingName,
	 'BalanceBefor' : BalanceBefor,
	 'Value' : Value,
	 'BalanceAfter' : BalanceAfter,
	 'IDFinancialCluses' : IDFinancialCluses,
	 'FinancialClusesName' : FinancialClusesName,
	 'Note' : Note,
	 'IsBindeDocument' : IsBindeDocument,
	 'BindeDocumentTypeID' : BindeDocumentTypeID,
	 'BindeDocumentID' : BindeDocumentID,
	 'BindeDocumentText' : BindeDocumentText,
	 'BindeDocumentCode' : BindeDocumentCode,
	 'IsAccountedByRepresent' : IsAccountedByRepresent,
	 'IDUser' : IDUser,
	 'IDBranch' : IDBranch,
	 'BranchName' : BranchName,
	 'IsTransfere' : IsTransfere,
	 'IDTransfere' : IDTransfere,
	 'IsClosedEdit' : IsClosedEdit,
	 'IDCalcSalary' : IDCalcSalary,
	 'FinacialTypeID' : FinacialTypeID,
	 'FinacialTypeName' : FinacialTypeName,
		};
}

static List<dynamic> getColumnAsList(List<Fina_TreasuryMovementFull> lstFina_TreasuryMovementFull, enTable_Fina_TreasuryMovementFull enTable)
	{
	if (enTable == enTable_Fina_TreasuryMovementFull.ID) {
		return lstFina_TreasuryMovementFull.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.Code) {
		return lstFina_TreasuryMovementFull.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.Serial) {
		return lstFina_TreasuryMovementFull.map((col) => col.Serial).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.Date) {
		return lstFina_TreasuryMovementFull.map((col) => col.Date).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.Time) {
		return lstFina_TreasuryMovementFull.map((col) => col.Time).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IDTreasur) {
		return lstFina_TreasuryMovementFull.map((col) => col.IDTreasur).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.TreasurName) {
		return lstFina_TreasuryMovementFull.map((col) => col.TreasurName).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.DealingTypeID) {
		return lstFina_TreasuryMovementFull.map((col) => col.DealingTypeID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.DealingTypeName) {
		return lstFina_TreasuryMovementFull.map((col) => col.DealingTypeName).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.DealingID) {
		return lstFina_TreasuryMovementFull.map((col) => col.DealingID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.DealingName) {
		return lstFina_TreasuryMovementFull.map((col) => col.DealingName).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.BalanceBefor) {
		return lstFina_TreasuryMovementFull.map((col) => col.BalanceBefor).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.Value) {
		return lstFina_TreasuryMovementFull.map((col) => col.Value).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.BalanceAfter) {
		return lstFina_TreasuryMovementFull.map((col) => col.BalanceAfter).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IDFinancialCluses) {
		return lstFina_TreasuryMovementFull.map((col) => col.IDFinancialCluses).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.FinancialClusesName) {
		return lstFina_TreasuryMovementFull.map((col) => col.FinancialClusesName).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.Note) {
		return lstFina_TreasuryMovementFull.map((col) => col.Note).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IsBindeDocument) {
		return lstFina_TreasuryMovementFull.map((col) => col.IsBindeDocument).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.BindeDocumentTypeID) {
		return lstFina_TreasuryMovementFull.map((col) => col.BindeDocumentTypeID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.BindeDocumentID) {
		return lstFina_TreasuryMovementFull.map((col) => col.BindeDocumentID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.BindeDocumentText) {
		return lstFina_TreasuryMovementFull.map((col) => col.BindeDocumentText).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.BindeDocumentCode) {
		return lstFina_TreasuryMovementFull.map((col) => col.BindeDocumentCode).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IsAccountedByRepresent) {
		return lstFina_TreasuryMovementFull.map((col) => col.IsAccountedByRepresent).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IDUser) {
		return lstFina_TreasuryMovementFull.map((col) => col.IDUser).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IDBranch) {
		return lstFina_TreasuryMovementFull.map((col) => col.IDBranch).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.BranchName) {
		return lstFina_TreasuryMovementFull.map((col) => col.BranchName).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IsTransfere) {
		return lstFina_TreasuryMovementFull.map((col) => col.IsTransfere).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IDTransfere) {
		return lstFina_TreasuryMovementFull.map((col) => col.IDTransfere).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IsClosedEdit) {
		return lstFina_TreasuryMovementFull.map((col) => col.IsClosedEdit).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IDCalcSalary) {
		return lstFina_TreasuryMovementFull.map((col) => col.IDCalcSalary).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.FinacialTypeID) {
		return lstFina_TreasuryMovementFull.map((col) => col.FinacialTypeID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.FinacialTypeName) {
		return lstFina_TreasuryMovementFull.map((col) => col.FinacialTypeName).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fina_TreasuryMovementFull> lstFina_TreasuryMovementFull, enTable_Fina_TreasuryMovementFull enTable)
	{
	if (enTable == enTable_Fina_TreasuryMovementFull.ID) {
		return lstFina_TreasuryMovementFull.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.Code) {
		return lstFina_TreasuryMovementFull.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.Serial) {
		return lstFina_TreasuryMovementFull.map((col) => col.Serial.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.Date) {
		return lstFina_TreasuryMovementFull.map((col) => col.Date.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.Time) {
		return lstFina_TreasuryMovementFull.map((col) => col.Time.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IDTreasur) {
		return lstFina_TreasuryMovementFull.map((col) => col.IDTreasur.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.TreasurName) {
		return lstFina_TreasuryMovementFull.map((col) => col.TreasurName.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.DealingTypeID) {
		return lstFina_TreasuryMovementFull.map((col) => col.DealingTypeID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.DealingTypeName) {
		return lstFina_TreasuryMovementFull.map((col) => col.DealingTypeName.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.DealingID) {
		return lstFina_TreasuryMovementFull.map((col) => col.DealingID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.DealingName) {
		return lstFina_TreasuryMovementFull.map((col) => col.DealingName.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.BalanceBefor) {
		return lstFina_TreasuryMovementFull.map((col) => col.BalanceBefor.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.Value) {
		return lstFina_TreasuryMovementFull.map((col) => col.Value.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.BalanceAfter) {
		return lstFina_TreasuryMovementFull.map((col) => col.BalanceAfter.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IDFinancialCluses) {
		return lstFina_TreasuryMovementFull.map((col) => col.IDFinancialCluses.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.FinancialClusesName) {
		return lstFina_TreasuryMovementFull.map((col) => col.FinancialClusesName.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.Note) {
		return lstFina_TreasuryMovementFull.map((col) => col.Note.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IsBindeDocument) {
		return lstFina_TreasuryMovementFull.map((col) => col.IsBindeDocument.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.BindeDocumentTypeID) {
		return lstFina_TreasuryMovementFull.map((col) => col.BindeDocumentTypeID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.BindeDocumentID) {
		return lstFina_TreasuryMovementFull.map((col) => col.BindeDocumentID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.BindeDocumentText) {
		return lstFina_TreasuryMovementFull.map((col) => col.BindeDocumentText.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.BindeDocumentCode) {
		return lstFina_TreasuryMovementFull.map((col) => col.BindeDocumentCode.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IsAccountedByRepresent) {
		return lstFina_TreasuryMovementFull.map((col) => col.IsAccountedByRepresent.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IDUser) {
		return lstFina_TreasuryMovementFull.map((col) => col.IDUser.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IDBranch) {
		return lstFina_TreasuryMovementFull.map((col) => col.IDBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.BranchName) {
		return lstFina_TreasuryMovementFull.map((col) => col.BranchName.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IsTransfere) {
		return lstFina_TreasuryMovementFull.map((col) => col.IsTransfere.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IDTransfere) {
		return lstFina_TreasuryMovementFull.map((col) => col.IDTransfere.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IsClosedEdit) {
		return lstFina_TreasuryMovementFull.map((col) => col.IsClosedEdit.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.IDCalcSalary) {
		return lstFina_TreasuryMovementFull.map((col) => col.IDCalcSalary.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.FinacialTypeID) {
		return lstFina_TreasuryMovementFull.map((col) => col.FinacialTypeID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fina_TreasuryMovementFull.FinacialTypeName) {
		return lstFina_TreasuryMovementFull.map((col) => col.FinacialTypeName.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

