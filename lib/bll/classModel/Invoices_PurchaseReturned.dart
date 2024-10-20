

enum enTable_Invoices_PurchaseReturned{ ID, Code, Date, Time, IDBranch, IDStock, IDEmployee, IDVendor, VendorSerial, TotalValue, DiscountValue, DiscountPercent, NetValue, IsClosed, Note, UID, CurrentBalance }

class Invoices_PurchaseReturned
	{
		static List<String> ColumnsName = enTable_Invoices_PurchaseReturned.values.map((item) => item.name).toList();

 int? ID;
 int? Code;
 String? Date;
 String? Time;
 int? IDBranch;
 int? IDStock;
 int? IDEmployee;
 int? IDVendor;
 String? VendorSerial;
 double? TotalValue;
 double? DiscountValue;
 double? DiscountPercent;
 double? NetValue;
 bool? IsClosed;
 String? Note;
 String? UID;
 double? CurrentBalance;

Invoices_PurchaseReturned({
 		this.ID,
 		this.Code,
 		this.Date,
 		this.Time,
 		this.IDBranch,
 		this.IDStock,
 		this.IDEmployee,
 		this.IDVendor,
 		this.VendorSerial,
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

Invoices_PurchaseReturned.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Code = json['Code'];
		 Date = json['Date'].toString();
		 Time = json['Time'].toString();
		 IDBranch = json['IDBranch'];
		 IDStock = json['IDStock'];
		 IDEmployee = json['IDEmployee'];
		 IDVendor = json['IDVendor'];
		 VendorSerial = json['VendorSerial'].toString();
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
	 'IDVendor' : IDVendor,
	 'VendorSerial' : VendorSerial,
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

static List<dynamic> getColumnAsList(List<Invoices_PurchaseReturned> lstInvoices_PurchaseReturned, enTable_Invoices_PurchaseReturned enTable)
	{
	if (enTable == enTable_Invoices_PurchaseReturned.ID) {
		return lstInvoices_PurchaseReturned.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.Code) {
		return lstInvoices_PurchaseReturned.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.Date) {
		return lstInvoices_PurchaseReturned.map((col) => col.Date).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.Time) {
		return lstInvoices_PurchaseReturned.map((col) => col.Time).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.IDBranch) {
		return lstInvoices_PurchaseReturned.map((col) => col.IDBranch).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.IDStock) {
		return lstInvoices_PurchaseReturned.map((col) => col.IDStock).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.IDEmployee) {
		return lstInvoices_PurchaseReturned.map((col) => col.IDEmployee).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.IDVendor) {
		return lstInvoices_PurchaseReturned.map((col) => col.IDVendor).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.VendorSerial) {
		return lstInvoices_PurchaseReturned.map((col) => col.VendorSerial).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.TotalValue) {
		return lstInvoices_PurchaseReturned.map((col) => col.TotalValue).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.DiscountValue) {
		return lstInvoices_PurchaseReturned.map((col) => col.DiscountValue).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.DiscountPercent) {
		return lstInvoices_PurchaseReturned.map((col) => col.DiscountPercent).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.NetValue) {
		return lstInvoices_PurchaseReturned.map((col) => col.NetValue).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.IsClosed) {
		return lstInvoices_PurchaseReturned.map((col) => col.IsClosed).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.Note) {
		return lstInvoices_PurchaseReturned.map((col) => col.Note).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.UID) {
		return lstInvoices_PurchaseReturned.map((col) => col.UID).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.CurrentBalance) {
		return lstInvoices_PurchaseReturned.map((col) => col.CurrentBalance).toSet().toList() as List<double>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Invoices_PurchaseReturned> lstInvoices_PurchaseReturned, enTable_Invoices_PurchaseReturned enTable)
	{
	if (enTable == enTable_Invoices_PurchaseReturned.ID) {
		return lstInvoices_PurchaseReturned.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.Code) {
		return lstInvoices_PurchaseReturned.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.Date) {
		return lstInvoices_PurchaseReturned.map((col) => col.Date.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.Time) {
		return lstInvoices_PurchaseReturned.map((col) => col.Time.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.IDBranch) {
		return lstInvoices_PurchaseReturned.map((col) => col.IDBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.IDStock) {
		return lstInvoices_PurchaseReturned.map((col) => col.IDStock.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.IDEmployee) {
		return lstInvoices_PurchaseReturned.map((col) => col.IDEmployee.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.IDVendor) {
		return lstInvoices_PurchaseReturned.map((col) => col.IDVendor.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.VendorSerial) {
		return lstInvoices_PurchaseReturned.map((col) => col.VendorSerial.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.TotalValue) {
		return lstInvoices_PurchaseReturned.map((col) => col.TotalValue.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.DiscountValue) {
		return lstInvoices_PurchaseReturned.map((col) => col.DiscountValue.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.DiscountPercent) {
		return lstInvoices_PurchaseReturned.map((col) => col.DiscountPercent.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.NetValue) {
		return lstInvoices_PurchaseReturned.map((col) => col.NetValue.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.IsClosed) {
		return lstInvoices_PurchaseReturned.map((col) => col.IsClosed.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.Note) {
		return lstInvoices_PurchaseReturned.map((col) => col.Note.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.UID) {
		return lstInvoices_PurchaseReturned.map((col) => col.UID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturned.CurrentBalance) {
		return lstInvoices_PurchaseReturned.map((col) => col.CurrentBalance.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

