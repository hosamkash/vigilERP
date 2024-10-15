

enum enTable_Inv_ProductsQty{ ID, IDStock, StockName, BarCode, IDProduct, ProductName, IDClassefications, ClasseficationsName, IDProductionCompanies, ProductionCompaniesName, IDUnit, UnitName, QtyBefore, Qty, QtyAfter, QtyRepresents, TotalQty, DateInserted, IDDocument, IDDocumentType, DocumentTypeName, LineNumber, Price, TotalPrice, IDPriceType, PriceTypeName }

class Inv_ProductsQty
	{
		static List<String> ColumnsName = enTable_Inv_ProductsQty.values.map((item) => item.name).toList();

 String? ID;
 int? IDStock;
 String? StockName;
 int? BarCode;
 int? IDProduct;
 String? ProductName;
 int? IDClassefications;
 String? ClasseficationsName;
 int? IDProductionCompanies;
 String? ProductionCompaniesName;
 int? IDUnit;
 String? UnitName;
 int? QtyBefore;
 int? Qty;
 int? QtyAfter;
 int? QtyRepresents;
 int? TotalQty;
 String? DateInserted;
 int? IDDocument;
 int? IDDocumentType;
 String? DocumentTypeName;
 int? LineNumber;
 double? Price;
 double? TotalPrice;
 int? IDPriceType;
 String? PriceTypeName;

Inv_ProductsQty({
 		this.ID,
 		this.IDStock,
 		this.StockName,
 		this.BarCode,
 		this.IDProduct,
 		this.ProductName,
 		this.IDClassefications,
 		this.ClasseficationsName,
 		this.IDProductionCompanies,
 		this.ProductionCompaniesName,
 		this.IDUnit,
 		this.UnitName,
 		this.QtyBefore,
 		this.Qty,
 		this.QtyAfter,
 		this.QtyRepresents,
 		this.TotalQty,
 		this.DateInserted,
 		this.IDDocument,
 		this.IDDocumentType,
 		this.DocumentTypeName,
 		this.LineNumber,
 		this.Price,
 		this.TotalPrice,
 		this.IDPriceType,
 		this.PriceTypeName,
});


//**************************** general function ****************************

Inv_ProductsQty.fromJson(Map<String, dynamic> json) {
 ID = json['ID'].toString();
		 IDStock = json['IDStock'];
		 StockName = json['StockName'].toString();
		 BarCode = json['BarCode'];
		 IDProduct = json['IDProduct'];
		 ProductName = json['ProductName'].toString();
		 IDClassefications = json['IDClassefications'];
		 ClasseficationsName = json['ClasseficationsName'].toString();
		 IDProductionCompanies = json['IDProductionCompanies'];
		 ProductionCompaniesName = json['ProductionCompaniesName'].toString();
		 IDUnit = json['IDUnit'];
		 UnitName = json['UnitName'].toString();
		 QtyBefore = json['QtyBefore'];
		 Qty = json['Qty'];
		 QtyAfter = json['QtyAfter'];
		 QtyRepresents = json['QtyRepresents'];
		 TotalQty = json['TotalQty'];
		 DateInserted = json['DateInserted'].toString();
		 IDDocument = json['IDDocument'];
		 IDDocumentType = json['IDDocumentType'];
		 DocumentTypeName = json['DocumentTypeName'].toString();
		 LineNumber = json['LineNumber'];
		 Price = json['Price'];
		 TotalPrice = json['TotalPrice'];
		 IDPriceType = json['IDPriceType'];
		 PriceTypeName = json['PriceTypeName'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'IDStock' : IDStock,
	 'StockName' : StockName,
	 'BarCode' : BarCode,
	 'IDProduct' : IDProduct,
	 'ProductName' : ProductName,
	 'IDClassefications' : IDClassefications,
	 'ClasseficationsName' : ClasseficationsName,
	 'IDProductionCompanies' : IDProductionCompanies,
	 'ProductionCompaniesName' : ProductionCompaniesName,
	 'IDUnit' : IDUnit,
	 'UnitName' : UnitName,
	 'QtyBefore' : QtyBefore,
	 'Qty' : Qty,
	 'QtyAfter' : QtyAfter,
	 'QtyRepresents' : QtyRepresents,
	 'TotalQty' : TotalQty,
	 'DateInserted' : DateInserted,
	 'IDDocument' : IDDocument,
	 'IDDocumentType' : IDDocumentType,
	 'DocumentTypeName' : DocumentTypeName,
	 'LineNumber' : LineNumber,
	 'Price' : Price,
	 'TotalPrice' : TotalPrice,
	 'IDPriceType' : IDPriceType,
	 'PriceTypeName' : PriceTypeName,
		};
}

static List<dynamic> getColumnAsList(List<Inv_ProductsQty> lstInv_ProductsQty, enTable_Inv_ProductsQty enTable)
	{
	if (enTable == enTable_Inv_ProductsQty.ID) {
		return lstInv_ProductsQty.map((col) => col.ID).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_ProductsQty.IDStock) {
		return lstInv_ProductsQty.map((col) => col.IDStock).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_ProductsQty.StockName) {
		return lstInv_ProductsQty.map((col) => col.StockName).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_ProductsQty.BarCode) {
		return lstInv_ProductsQty.map((col) => col.BarCode).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_ProductsQty.IDProduct) {
		return lstInv_ProductsQty.map((col) => col.IDProduct).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_ProductsQty.ProductName) {
		return lstInv_ProductsQty.map((col) => col.ProductName).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_ProductsQty.IDClassefications) {
		return lstInv_ProductsQty.map((col) => col.IDClassefications).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_ProductsQty.ClasseficationsName) {
		return lstInv_ProductsQty.map((col) => col.ClasseficationsName).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_ProductsQty.IDProductionCompanies) {
		return lstInv_ProductsQty.map((col) => col.IDProductionCompanies).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_ProductsQty.ProductionCompaniesName) {
		return lstInv_ProductsQty.map((col) => col.ProductionCompaniesName).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_ProductsQty.IDUnit) {
		return lstInv_ProductsQty.map((col) => col.IDUnit).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_ProductsQty.UnitName) {
		return lstInv_ProductsQty.map((col) => col.UnitName).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_ProductsQty.QtyBefore) {
		return lstInv_ProductsQty.map((col) => col.QtyBefore).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_ProductsQty.Qty) {
		return lstInv_ProductsQty.map((col) => col.Qty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_ProductsQty.QtyAfter) {
		return lstInv_ProductsQty.map((col) => col.QtyAfter).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_ProductsQty.QtyRepresents) {
		return lstInv_ProductsQty.map((col) => col.QtyRepresents).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_ProductsQty.TotalQty) {
		return lstInv_ProductsQty.map((col) => col.TotalQty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_ProductsQty.DateInserted) {
		return lstInv_ProductsQty.map((col) => col.DateInserted).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_ProductsQty.IDDocument) {
		return lstInv_ProductsQty.map((col) => col.IDDocument).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_ProductsQty.IDDocumentType) {
		return lstInv_ProductsQty.map((col) => col.IDDocumentType).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_ProductsQty.DocumentTypeName) {
		return lstInv_ProductsQty.map((col) => col.DocumentTypeName).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Inv_ProductsQty.LineNumber) {
		return lstInv_ProductsQty.map((col) => col.LineNumber).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_ProductsQty.Price) {
		return lstInv_ProductsQty.map((col) => col.Price).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_ProductsQty.TotalPrice) {
		return lstInv_ProductsQty.map((col) => col.TotalPrice).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_ProductsQty.IDPriceType) {
		return lstInv_ProductsQty.map((col) => col.IDPriceType).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_ProductsQty.PriceTypeName) {
		return lstInv_ProductsQty.map((col) => col.PriceTypeName).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Inv_ProductsQty> lstInv_ProductsQty, enTable_Inv_ProductsQty enTable)
	{
	if (enTable == enTable_Inv_ProductsQty.ID) {
		return lstInv_ProductsQty.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.IDStock) {
		return lstInv_ProductsQty.map((col) => col.IDStock.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.StockName) {
		return lstInv_ProductsQty.map((col) => col.StockName.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.BarCode) {
		return lstInv_ProductsQty.map((col) => col.BarCode.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.IDProduct) {
		return lstInv_ProductsQty.map((col) => col.IDProduct.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.ProductName) {
		return lstInv_ProductsQty.map((col) => col.ProductName.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.IDClassefications) {
		return lstInv_ProductsQty.map((col) => col.IDClassefications.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.ClasseficationsName) {
		return lstInv_ProductsQty.map((col) => col.ClasseficationsName.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.IDProductionCompanies) {
		return lstInv_ProductsQty.map((col) => col.IDProductionCompanies.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.ProductionCompaniesName) {
		return lstInv_ProductsQty.map((col) => col.ProductionCompaniesName.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.IDUnit) {
		return lstInv_ProductsQty.map((col) => col.IDUnit.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.UnitName) {
		return lstInv_ProductsQty.map((col) => col.UnitName.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.QtyBefore) {
		return lstInv_ProductsQty.map((col) => col.QtyBefore.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.Qty) {
		return lstInv_ProductsQty.map((col) => col.Qty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.QtyAfter) {
		return lstInv_ProductsQty.map((col) => col.QtyAfter.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.QtyRepresents) {
		return lstInv_ProductsQty.map((col) => col.QtyRepresents.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.TotalQty) {
		return lstInv_ProductsQty.map((col) => col.TotalQty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.DateInserted) {
		return lstInv_ProductsQty.map((col) => col.DateInserted.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.IDDocument) {
		return lstInv_ProductsQty.map((col) => col.IDDocument.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.IDDocumentType) {
		return lstInv_ProductsQty.map((col) => col.IDDocumentType.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.DocumentTypeName) {
		return lstInv_ProductsQty.map((col) => col.DocumentTypeName.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.LineNumber) {
		return lstInv_ProductsQty.map((col) => col.LineNumber.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.Price) {
		return lstInv_ProductsQty.map((col) => col.Price.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.TotalPrice) {
		return lstInv_ProductsQty.map((col) => col.TotalPrice.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.IDPriceType) {
		return lstInv_ProductsQty.map((col) => col.IDPriceType.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_ProductsQty.PriceTypeName) {
		return lstInv_ProductsQty.map((col) => col.PriceTypeName.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

