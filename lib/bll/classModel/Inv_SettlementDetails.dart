

enum enTable_Inv_SettlementDetails{ ID, IDSettlement, IDProduct, Barcode, IDClassefication, IDProductionCompanies, IDUnit, BookingQty, ActualQty, PriceType, Price, DiffQty, DiffTotalPrice, AddQty, AddTotalPrice }

class Inv_SettlementDetails
	{
		static List<String> ColumnsName = enTable_Inv_SettlementDetails.values.map((item) => item.name).toList();

 int? ID;
 int? IDSettlement;
 int? IDProduct;
 int? Barcode;
 int? IDClassefication;
 int? IDProductionCompanies;
 int? IDUnit;
 int? BookingQty;
 int? ActualQty;
 int? PriceType;
 double? Price;
 int? DiffQty;
 double? DiffTotalPrice;
 int? AddQty;
 double? AddTotalPrice;

Inv_SettlementDetails({
 		this.ID,
 		this.IDSettlement,
 		this.IDProduct,
 		this.Barcode,
 		this.IDClassefication,
 		this.IDProductionCompanies,
 		this.IDUnit,
 		this.BookingQty,
 		this.ActualQty,
 		this.PriceType,
 		this.Price,
 		this.DiffQty,
 		this.DiffTotalPrice,
 		this.AddQty,
 		this.AddTotalPrice,
});


//**************************** general function ****************************

Inv_SettlementDetails.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 IDSettlement = json['IDSettlement'];
		 IDProduct = json['IDProduct'];
		 Barcode = json['Barcode'];
		 IDClassefication = json['IDClassefication'];
		 IDProductionCompanies = json['IDProductionCompanies'];
		 IDUnit = json['IDUnit'];
		 BookingQty = json['BookingQty'];
		 ActualQty = json['ActualQty'];
		 PriceType = json['PriceType'];
		 Price = json['Price'];
		 DiffQty = json['DiffQty'];
		 DiffTotalPrice = json['DiffTotalPrice'];
		 AddQty = json['AddQty'];
		 AddTotalPrice = json['AddTotalPrice'];
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'IDSettlement' : IDSettlement,
	 'IDProduct' : IDProduct,
	 'Barcode' : Barcode,
	 'IDClassefication' : IDClassefication,
	 'IDProductionCompanies' : IDProductionCompanies,
	 'IDUnit' : IDUnit,
	 'BookingQty' : BookingQty,
	 'ActualQty' : ActualQty,
	 'PriceType' : PriceType,
	 'Price' : Price,
	 'DiffQty' : DiffQty,
	 'DiffTotalPrice' : DiffTotalPrice,
	 'AddQty' : AddQty,
	 'AddTotalPrice' : AddTotalPrice,
		};
}

static List<dynamic> getColumnAsList(List<Inv_SettlementDetails> lstInv_SettlementDetails, enTable_Inv_SettlementDetails enTable)
	{
	if (enTable == enTable_Inv_SettlementDetails.ID) {
		return lstInv_SettlementDetails.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_SettlementDetails.IDSettlement) {
		return lstInv_SettlementDetails.map((col) => col.IDSettlement).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_SettlementDetails.IDProduct) {
		return lstInv_SettlementDetails.map((col) => col.IDProduct).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_SettlementDetails.Barcode) {
		return lstInv_SettlementDetails.map((col) => col.Barcode).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_SettlementDetails.IDClassefication) {
		return lstInv_SettlementDetails.map((col) => col.IDClassefication).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_SettlementDetails.IDProductionCompanies) {
		return lstInv_SettlementDetails.map((col) => col.IDProductionCompanies).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_SettlementDetails.IDUnit) {
		return lstInv_SettlementDetails.map((col) => col.IDUnit).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_SettlementDetails.BookingQty) {
		return lstInv_SettlementDetails.map((col) => col.BookingQty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_SettlementDetails.ActualQty) {
		return lstInv_SettlementDetails.map((col) => col.ActualQty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_SettlementDetails.PriceType) {
		return lstInv_SettlementDetails.map((col) => col.PriceType).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_SettlementDetails.Price) {
		return lstInv_SettlementDetails.map((col) => col.Price).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_SettlementDetails.DiffQty) {
		return lstInv_SettlementDetails.map((col) => col.DiffQty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_SettlementDetails.DiffTotalPrice) {
		return lstInv_SettlementDetails.map((col) => col.DiffTotalPrice).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_SettlementDetails.AddQty) {
		return lstInv_SettlementDetails.map((col) => col.AddQty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_SettlementDetails.AddTotalPrice) {
		return lstInv_SettlementDetails.map((col) => col.AddTotalPrice).toSet().toList() as List<double>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Inv_SettlementDetails> lstInv_SettlementDetails, enTable_Inv_SettlementDetails enTable)
	{
	if (enTable == enTable_Inv_SettlementDetails.ID) {
		return lstInv_SettlementDetails.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_SettlementDetails.IDSettlement) {
		return lstInv_SettlementDetails.map((col) => col.IDSettlement.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_SettlementDetails.IDProduct) {
		return lstInv_SettlementDetails.map((col) => col.IDProduct.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_SettlementDetails.Barcode) {
		return lstInv_SettlementDetails.map((col) => col.Barcode.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_SettlementDetails.IDClassefication) {
		return lstInv_SettlementDetails.map((col) => col.IDClassefication.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_SettlementDetails.IDProductionCompanies) {
		return lstInv_SettlementDetails.map((col) => col.IDProductionCompanies.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_SettlementDetails.IDUnit) {
		return lstInv_SettlementDetails.map((col) => col.IDUnit.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_SettlementDetails.BookingQty) {
		return lstInv_SettlementDetails.map((col) => col.BookingQty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_SettlementDetails.ActualQty) {
		return lstInv_SettlementDetails.map((col) => col.ActualQty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_SettlementDetails.PriceType) {
		return lstInv_SettlementDetails.map((col) => col.PriceType.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_SettlementDetails.Price) {
		return lstInv_SettlementDetails.map((col) => col.Price.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_SettlementDetails.DiffQty) {
		return lstInv_SettlementDetails.map((col) => col.DiffQty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_SettlementDetails.DiffTotalPrice) {
		return lstInv_SettlementDetails.map((col) => col.DiffTotalPrice.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_SettlementDetails.AddQty) {
		return lstInv_SettlementDetails.map((col) => col.AddQty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_SettlementDetails.AddTotalPrice) {
		return lstInv_SettlementDetails.map((col) => col.AddTotalPrice.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

