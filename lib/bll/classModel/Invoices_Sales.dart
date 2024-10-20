

enum enTable_Invoices_Sales{ ID, Code, Date, Time, IDBranch, IDStock, IDEmployee, IDClient, TotalValue, DiscountValue, DiscountPercent, NetValue, IsClosed, Note, UID, CurrentBalance }

class Invoices_Sales
	{
		static List<String> ColumnsName = enTable_Invoices_Sales.values.map((item) => item.name).toList();

 int? ID;
 int? Code;
 String? Date;
 String? Time;
 int? IDBranch;
 int? IDStock;
 int? IDEmployee;
 int? IDClient;
 double? TotalValue;
 double? DiscountValue;
 double? DiscountPercent;
 double? NetValue;
 bool? IsClosed;
 String? Note;
 String? UID;
 double? CurrentBalance;

Invoices_Sales({
 		this.ID,
 		this.Code,
 		this.Date,
 		this.Time,
 		this.IDBranch,
 		this.IDStock,
 		this.IDEmployee,
 		this.IDClient,
 		this.TotalValue,
 		this.DiscountValue,
 		this.DiscountPercent,
 		this.NetValue,
 		this.IsClosed,
 		this.Note,
 		this.UID,
 		this.CurrentBalance,
});


//**************************** general function ****************************

Invoices_Sales.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Code = json['Code'];
		 Date = json['Date'].toString();
		 Time = json['Time'].toString();
		 IDBranch = json['IDBranch'];
		 IDStock = json['IDStock'];
		 IDEmployee = json['IDEmployee'];
		 IDClient = json['IDClient'];
		 TotalValue = json['TotalValue'];
		 DiscountValue = json['DiscountValue'];
		 DiscountPercent = json['DiscountPercent'];
		 NetValue = json['NetValue'];
		 IsClosed = json['IsClosed'];
		 Note = json['Note'].toString();
		 UID = json['UID'].toString();
		 CurrentBalance = json['CurrentBalance'];
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Code' : Code,
	 'Date' : Date,
	 'Time' : Time,
	 'IDBranch' : IDBranch,
	 'IDStock' : IDStock,
	 'IDEmployee' : IDEmployee,
	 'IDClient' : IDClient,
	 'TotalValue' : TotalValue,
	 'DiscountValue' : DiscountValue,
	 'DiscountPercent' : DiscountPercent,
	 'NetValue' : NetValue,
	 'IsClosed' : IsClosed,
	 'Note' : Note,
	 'UID' : UID,
	 'CurrentBalance' : CurrentBalance,
		};
}

static List<dynamic> getColumnAsList(List<Invoices_Sales> lstInvoices_Sales, enTable_Invoices_Sales enTable)
	{
	if (enTable == enTable_Invoices_Sales.ID) {
		return lstInvoices_Sales.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_Sales.Code) {
		return lstInvoices_Sales.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_Sales.Date) {
		return lstInvoices_Sales.map((col) => col.Date).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Invoices_Sales.Time) {
		return lstInvoices_Sales.map((col) => col.Time).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Invoices_Sales.IDBranch) {
		return lstInvoices_Sales.map((col) => col.IDBranch).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_Sales.IDStock) {
		return lstInvoices_Sales.map((col) => col.IDStock).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_Sales.IDEmployee) {
		return lstInvoices_Sales.map((col) => col.IDEmployee).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_Sales.IDClient) {
		return lstInvoices_Sales.map((col) => col.IDClient).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_Sales.TotalValue) {
		return lstInvoices_Sales.map((col) => col.TotalValue).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_Sales.DiscountValue) {
		return lstInvoices_Sales.map((col) => col.DiscountValue).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_Sales.DiscountPercent) {
		return lstInvoices_Sales.map((col) => col.DiscountPercent).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_Sales.NetValue) {
		return lstInvoices_Sales.map((col) => col.NetValue).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_Sales.IsClosed) {
		return lstInvoices_Sales.map((col) => col.IsClosed).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Invoices_Sales.Note) {
		return lstInvoices_Sales.map((col) => col.Note).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Invoices_Sales.UID) {
		return lstInvoices_Sales.map((col) => col.UID).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Invoices_Sales.CurrentBalance) {
		return lstInvoices_Sales.map((col) => col.CurrentBalance).toSet().toList() as List<double>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Invoices_Sales> lstInvoices_Sales, enTable_Invoices_Sales enTable)
	{
	if (enTable == enTable_Invoices_Sales.ID) {
		return lstInvoices_Sales.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Sales.Code) {
		return lstInvoices_Sales.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Sales.Date) {
		return lstInvoices_Sales.map((col) => col.Date.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Sales.Time) {
		return lstInvoices_Sales.map((col) => col.Time.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Sales.IDBranch) {
		return lstInvoices_Sales.map((col) => col.IDBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Sales.IDStock) {
		return lstInvoices_Sales.map((col) => col.IDStock.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Sales.IDEmployee) {
		return lstInvoices_Sales.map((col) => col.IDEmployee.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Sales.IDClient) {
		return lstInvoices_Sales.map((col) => col.IDClient.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Sales.TotalValue) {
		return lstInvoices_Sales.map((col) => col.TotalValue.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Sales.DiscountValue) {
		return lstInvoices_Sales.map((col) => col.DiscountValue.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Sales.DiscountPercent) {
		return lstInvoices_Sales.map((col) => col.DiscountPercent.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Sales.NetValue) {
		return lstInvoices_Sales.map((col) => col.NetValue.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Sales.IsClosed) {
		return lstInvoices_Sales.map((col) => col.IsClosed.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Sales.Note) {
		return lstInvoices_Sales.map((col) => col.Note.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Sales.UID) {
		return lstInvoices_Sales.map((col) => col.UID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Sales.CurrentBalance) {
		return lstInvoices_Sales.map((col) => col.CurrentBalance.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

