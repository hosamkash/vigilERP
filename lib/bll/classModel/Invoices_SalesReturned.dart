

enum enTable_Invoices_SalesReturned{ ID, Code, Date, Time, IDBranch, IDStock, IDEmployee, IDClient, TotalValue, DiscountValue, DiscountPercent, NetValue, IsClosed, Note, UID, CurrentBalance }

class Invoices_SalesReturned
	{
		static List<String> ColumnsName = enTable_Invoices_SalesReturned.values.map((item) => item.name).toList();

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

Invoices_SalesReturned({
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

Invoices_SalesReturned.fromJson(Map<String, dynamic> json) {
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

static List<dynamic> getColumnAsList(List<Invoices_SalesReturned> lstInvoices_SalesReturned, enTable_Invoices_SalesReturned enTable)
	{
	if (enTable == enTable_Invoices_SalesReturned.ID) {
		return lstInvoices_SalesReturned.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_SalesReturned.Code) {
		return lstInvoices_SalesReturned.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_SalesReturned.Date) {
		return lstInvoices_SalesReturned.map((col) => col.Date).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Invoices_SalesReturned.Time) {
		return lstInvoices_SalesReturned.map((col) => col.Time).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Invoices_SalesReturned.IDBranch) {
		return lstInvoices_SalesReturned.map((col) => col.IDBranch).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_SalesReturned.IDStock) {
		return lstInvoices_SalesReturned.map((col) => col.IDStock).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_SalesReturned.IDEmployee) {
		return lstInvoices_SalesReturned.map((col) => col.IDEmployee).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_SalesReturned.IDClient) {
		return lstInvoices_SalesReturned.map((col) => col.IDClient).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_SalesReturned.TotalValue) {
		return lstInvoices_SalesReturned.map((col) => col.TotalValue).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_SalesReturned.DiscountValue) {
		return lstInvoices_SalesReturned.map((col) => col.DiscountValue).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_SalesReturned.DiscountPercent) {
		return lstInvoices_SalesReturned.map((col) => col.DiscountPercent).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_SalesReturned.NetValue) {
		return lstInvoices_SalesReturned.map((col) => col.NetValue).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_SalesReturned.IsClosed) {
		return lstInvoices_SalesReturned.map((col) => col.IsClosed).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Invoices_SalesReturned.Note) {
		return lstInvoices_SalesReturned.map((col) => col.Note).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Invoices_SalesReturned.UID) {
		return lstInvoices_SalesReturned.map((col) => col.UID).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Invoices_SalesReturned.CurrentBalance) {
		return lstInvoices_SalesReturned.map((col) => col.CurrentBalance).toSet().toList() as List<double>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Invoices_SalesReturned> lstInvoices_SalesReturned, enTable_Invoices_SalesReturned enTable)
	{
	if (enTable == enTable_Invoices_SalesReturned.ID) {
		return lstInvoices_SalesReturned.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturned.Code) {
		return lstInvoices_SalesReturned.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturned.Date) {
		return lstInvoices_SalesReturned.map((col) => col.Date.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturned.Time) {
		return lstInvoices_SalesReturned.map((col) => col.Time.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturned.IDBranch) {
		return lstInvoices_SalesReturned.map((col) => col.IDBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturned.IDStock) {
		return lstInvoices_SalesReturned.map((col) => col.IDStock.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturned.IDEmployee) {
		return lstInvoices_SalesReturned.map((col) => col.IDEmployee.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturned.IDClient) {
		return lstInvoices_SalesReturned.map((col) => col.IDClient.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturned.TotalValue) {
		return lstInvoices_SalesReturned.map((col) => col.TotalValue.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturned.DiscountValue) {
		return lstInvoices_SalesReturned.map((col) => col.DiscountValue.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturned.DiscountPercent) {
		return lstInvoices_SalesReturned.map((col) => col.DiscountPercent.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturned.NetValue) {
		return lstInvoices_SalesReturned.map((col) => col.NetValue.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturned.IsClosed) {
		return lstInvoices_SalesReturned.map((col) => col.IsClosed.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturned.Note) {
		return lstInvoices_SalesReturned.map((col) => col.Note.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturned.UID) {
		return lstInvoices_SalesReturned.map((col) => col.UID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturned.CurrentBalance) {
		return lstInvoices_SalesReturned.map((col) => col.CurrentBalance.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

