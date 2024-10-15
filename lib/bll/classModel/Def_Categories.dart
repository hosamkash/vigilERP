

enum enTable_Def_Categories{ ID, Name, IsActive, IsSalesCategory, IsViewAllProducts }

class Def_Categories
	{
		static List<String> ColumnsName = enTable_Def_Categories.values.map((item) => item.name).toList();

 int? ID;
 String? Name;
 bool? IsActive;
 bool? IsSalesCategory;
 bool? IsViewAllProducts;

Def_Categories({
 		this.ID,
 		this.Name,
 		this.IsActive,
 		this.IsSalesCategory,
 		this.IsViewAllProducts,
});


//**************************** general function ****************************

Def_Categories.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
		 IsActive = json['IsActive'];
		 IsSalesCategory = json['IsSalesCategory'];
		 IsViewAllProducts = json['IsViewAllProducts'];
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
	 'IsActive' : IsActive,
	 'IsSalesCategory' : IsSalesCategory,
	 'IsViewAllProducts' : IsViewAllProducts,
		};
}

static List<dynamic> getColumnAsList(List<Def_Categories> lstDef_Categories, enTable_Def_Categories enTable)
	{
	if (enTable == enTable_Def_Categories.ID) {
		return lstDef_Categories.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Def_Categories.Name) {
		return lstDef_Categories.map((col) => col.Name).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Def_Categories.IsActive) {
		return lstDef_Categories.map((col) => col.IsActive).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Def_Categories.IsSalesCategory) {
		return lstDef_Categories.map((col) => col.IsSalesCategory).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Def_Categories.IsViewAllProducts) {
		return lstDef_Categories.map((col) => col.IsViewAllProducts).toSet().toList() as List<bool>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Def_Categories> lstDef_Categories, enTable_Def_Categories enTable)
	{
	if (enTable == enTable_Def_Categories.ID) {
		return lstDef_Categories.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Categories.Name) {
		return lstDef_Categories.map((col) => col.Name.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Categories.IsActive) {
		return lstDef_Categories.map((col) => col.IsActive.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Categories.IsSalesCategory) {
		return lstDef_Categories.map((col) => col.IsSalesCategory.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Categories.IsViewAllProducts) {
		return lstDef_Categories.map((col) => col.IsViewAllProducts.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

