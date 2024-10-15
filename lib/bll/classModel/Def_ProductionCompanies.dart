

enum enTable_Def_ProductionCompanies{ ID, Name, IsActive, IsSalesCategory }

class Def_ProductionCompanies
	{
		static List<String> ColumnsName = enTable_Def_ProductionCompanies.values.map((item) => item.name).toList();

 int? ID;
 String? Name;
 bool? IsActive;
 bool? IsSalesCategory;

Def_ProductionCompanies({
 		this.ID,
 		this.Name,
 		this.IsActive,
 		this.IsSalesCategory,
});


//**************************** general function ****************************

Def_ProductionCompanies.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
		 IsActive = json['IsActive'];
		 IsSalesCategory = json['IsSalesCategory'];
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
	 'IsActive' : IsActive,
	 'IsSalesCategory' : IsSalesCategory,
		};
}

static List<dynamic> getColumnAsList(List<Def_ProductionCompanies> lstDef_ProductionCompanies, enTable_Def_ProductionCompanies enTable)
	{
	if (enTable == enTable_Def_ProductionCompanies.ID) {
		return lstDef_ProductionCompanies.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Def_ProductionCompanies.Name) {
		return lstDef_ProductionCompanies.map((col) => col.Name).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Def_ProductionCompanies.IsActive) {
		return lstDef_ProductionCompanies.map((col) => col.IsActive).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Def_ProductionCompanies.IsSalesCategory) {
		return lstDef_ProductionCompanies.map((col) => col.IsSalesCategory).toSet().toList() as List<bool>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Def_ProductionCompanies> lstDef_ProductionCompanies, enTable_Def_ProductionCompanies enTable)
	{
	if (enTable == enTable_Def_ProductionCompanies.ID) {
		return lstDef_ProductionCompanies.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_ProductionCompanies.Name) {
		return lstDef_ProductionCompanies.map((col) => col.Name.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_ProductionCompanies.IsActive) {
		return lstDef_ProductionCompanies.map((col) => col.IsActive.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_ProductionCompanies.IsSalesCategory) {
		return lstDef_ProductionCompanies.map((col) => col.IsSalesCategory.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

