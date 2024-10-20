

enum enTable_Invoices_SalesReturnedDetails{ ID, IDInvoices_Sales, IDProduct, Barcode, IDClassefication, IDProductionCompanies, UnitBig_ID, UnitBig_Qty, UnitBig_Price, UnitCountOf, UnitSmall_ID, UnitSmall_Price, UnitSmall_Qty, isBigUnit, TotalPrice, PriceType }

class Invoices_SalesReturnedDetails
	{
		static List<String> ColumnsName = enTable_Invoices_SalesReturnedDetails.values.map((item) => item.name).toList();

 int? ID;
 int? IDInvoices_Sales;
 int? IDProduct;
 int? Barcode;
 int? IDClassefication;
 int? IDProductionCompanies;
 int? UnitBig_ID;
 int? UnitBig_Qty;
 double? UnitBig_Price;
 int? UnitCountOf;
 int? UnitSmall_ID;
 double? UnitSmall_Price;
 int? UnitSmall_Qty;
 bool? isBigUnit;
 double? TotalPrice;
 int? PriceType;

Invoices_SalesReturnedDetails({
 		this.ID,
 		this.IDInvoices_Sales,
 		this.IDProduct,
 		this.Barcode,
 		this.IDClassefication,
 		this.IDProductionCompanies,
 		this.UnitBig_ID,
 		this.UnitBig_Qty,
 		this.UnitBig_Price,
 		this.UnitCountOf,
 		this.UnitSmall_ID,
 		this.UnitSmall_Price,
 		this.UnitSmall_Qty,
 		this.isBigUnit,
 		this.TotalPrice,
 		this.PriceType,
});


//**************************** general function ****************************

Invoices_SalesReturnedDetails.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 IDInvoices_Sales = json['IDInvoices_Sales'];
		 IDProduct = json['IDProduct'];
		 Barcode = json['Barcode'];
		 IDClassefication = json['IDClassefication'];
		 IDProductionCompanies = json['IDProductionCompanies'];
		 UnitBig_ID = json['UnitBig_ID'];
		 UnitBig_Qty = json['UnitBig_Qty'];
		 UnitBig_Price = json['UnitBig_Price'];
		 UnitCountOf = json['UnitCountOf'];
		 UnitSmall_ID = json['UnitSmall_ID'];
		 UnitSmall_Price = json['UnitSmall_Price'];
		 UnitSmall_Qty = json['UnitSmall_Qty'];
		 isBigUnit = json['isBigUnit'];
		 TotalPrice = json['TotalPrice'];
		 PriceType = json['PriceType'];
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'IDInvoices_Sales' : IDInvoices_Sales,
	 'IDProduct' : IDProduct,
	 'Barcode' : Barcode,
	 'IDClassefication' : IDClassefication,
	 'IDProductionCompanies' : IDProductionCompanies,
	 'UnitBig_ID' : UnitBig_ID,
	 'UnitBig_Qty' : UnitBig_Qty,
	 'UnitBig_Price' : UnitBig_Price,
	 'UnitCountOf' : UnitCountOf,
	 'UnitSmall_ID' : UnitSmall_ID,
	 'UnitSmall_Price' : UnitSmall_Price,
	 'UnitSmall_Qty' : UnitSmall_Qty,
	 'isBigUnit' : isBigUnit,
	 'TotalPrice' : TotalPrice,
	 'PriceType' : PriceType,
		};
}

static List<dynamic> getColumnAsList(List<Invoices_SalesReturnedDetails> lstInvoices_SalesReturnedDetails, enTable_Invoices_SalesReturnedDetails enTable)
	{
	if (enTable == enTable_Invoices_SalesReturnedDetails.ID) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.IDInvoices_Sales) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.IDInvoices_Sales).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.IDProduct) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.IDProduct).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.Barcode) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.Barcode).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.IDClassefication) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.IDClassefication).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.IDProductionCompanies) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.IDProductionCompanies).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.UnitBig_ID) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.UnitBig_ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.UnitBig_Qty) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.UnitBig_Qty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.UnitBig_Price) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.UnitBig_Price).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.UnitCountOf) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.UnitCountOf).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.UnitSmall_ID) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.UnitSmall_ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.UnitSmall_Price) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.UnitSmall_Price).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.UnitSmall_Qty) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.UnitSmall_Qty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.isBigUnit) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.isBigUnit).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.TotalPrice) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.TotalPrice).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.PriceType) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.PriceType).toSet().toList() as List<int>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Invoices_SalesReturnedDetails> lstInvoices_SalesReturnedDetails, enTable_Invoices_SalesReturnedDetails enTable)
	{
	if (enTable == enTable_Invoices_SalesReturnedDetails.ID) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.IDInvoices_Sales) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.IDInvoices_Sales.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.IDProduct) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.IDProduct.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.Barcode) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.Barcode.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.IDClassefication) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.IDClassefication.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.IDProductionCompanies) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.IDProductionCompanies.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.UnitBig_ID) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.UnitBig_ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.UnitBig_Qty) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.UnitBig_Qty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.UnitBig_Price) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.UnitBig_Price.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.UnitCountOf) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.UnitCountOf.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.UnitSmall_ID) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.UnitSmall_ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.UnitSmall_Price) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.UnitSmall_Price.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.UnitSmall_Qty) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.UnitSmall_Qty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.isBigUnit) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.isBigUnit.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.TotalPrice) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.TotalPrice.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_SalesReturnedDetails.PriceType) {
		return lstInvoices_SalesReturnedDetails.map((col) => col.PriceType.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

