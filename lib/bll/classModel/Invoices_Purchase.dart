

enum enTable_Invoices_Purchase{ ID, Code, Date, Time, IDBranch, IDStock, IDEmployee, IDVendor, VendorSerial, TotalValue, DiscountValue, DiscountPercent, NetValue, IsClosed, Note, UID, CurrentBalance }

class Invoices_Purchase
	{
		static List<String> ColumnsName = enTable_Invoices_Purchase.values.map((item) => item.name).toList();

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

Invoices_Purchase({
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

Invoices_Purchase.fromJson(Map<String, dynamic> json) {
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

static List<dynamic> getColumnAsList(List<Invoices_Purchase> lstInvoices_Purchase, enTable_Invoices_Purchase enTable)
	{
	if (enTable == enTable_Invoices_Purchase.ID) {
		return lstInvoices_Purchase.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_Purchase.Code) {
		return lstInvoices_Purchase.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_Purchase.Date) {
		return lstInvoices_Purchase.map((col) => col.Date).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Invoices_Purchase.Time) {
		return lstInvoices_Purchase.map((col) => col.Time).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Invoices_Purchase.IDBranch) {
		return lstInvoices_Purchase.map((col) => col.IDBranch).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_Purchase.IDStock) {
		return lstInvoices_Purchase.map((col) => col.IDStock).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_Purchase.IDEmployee) {
		return lstInvoices_Purchase.map((col) => col.IDEmployee).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_Purchase.IDVendor) {
		return lstInvoices_Purchase.map((col) => col.IDVendor).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_Purchase.VendorSerial) {
		return lstInvoices_Purchase.map((col) => col.VendorSerial).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Invoices_Purchase.TotalValue) {
		return lstInvoices_Purchase.map((col) => col.TotalValue).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_Purchase.DiscountValue) {
		return lstInvoices_Purchase.map((col) => col.DiscountValue).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_Purchase.DiscountPercent) {
		return lstInvoices_Purchase.map((col) => col.DiscountPercent).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_Purchase.NetValue) {
		return lstInvoices_Purchase.map((col) => col.NetValue).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_Purchase.IsClosed) {
		return lstInvoices_Purchase.map((col) => col.IsClosed).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Invoices_Purchase.Note) {
		return lstInvoices_Purchase.map((col) => col.Note).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Invoices_Purchase.UID) {
		return lstInvoices_Purchase.map((col) => col.UID).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Invoices_Purchase.CurrentBalance) {
		return lstInvoices_Purchase.map((col) => col.CurrentBalance).toSet().toList() as List<double>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Invoices_Purchase> lstInvoices_Purchase, enTable_Invoices_Purchase enTable)
	{
	if (enTable == enTable_Invoices_Purchase.ID) {
		return lstInvoices_Purchase.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Purchase.Code) {
		return lstInvoices_Purchase.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Purchase.Date) {
		return lstInvoices_Purchase.map((col) => col.Date.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Purchase.Time) {
		return lstInvoices_Purchase.map((col) => col.Time.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Purchase.IDBranch) {
		return lstInvoices_Purchase.map((col) => col.IDBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Purchase.IDStock) {
		return lstInvoices_Purchase.map((col) => col.IDStock.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Purchase.IDEmployee) {
		return lstInvoices_Purchase.map((col) => col.IDEmployee.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Purchase.IDVendor) {
		return lstInvoices_Purchase.map((col) => col.IDVendor.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Purchase.VendorSerial) {
		return lstInvoices_Purchase.map((col) => col.VendorSerial.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Purchase.TotalValue) {
		return lstInvoices_Purchase.map((col) => col.TotalValue.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Purchase.DiscountValue) {
		return lstInvoices_Purchase.map((col) => col.DiscountValue.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Purchase.DiscountPercent) {
		return lstInvoices_Purchase.map((col) => col.DiscountPercent.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Purchase.NetValue) {
		return lstInvoices_Purchase.map((col) => col.NetValue.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Purchase.IsClosed) {
		return lstInvoices_Purchase.map((col) => col.IsClosed.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Purchase.Note) {
		return lstInvoices_Purchase.map((col) => col.Note.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Purchase.UID) {
		return lstInvoices_Purchase.map((col) => col.UID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_Purchase.CurrentBalance) {
		return lstInvoices_Purchase.map((col) => col.CurrentBalance.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

