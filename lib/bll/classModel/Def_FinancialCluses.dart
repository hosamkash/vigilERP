

enum enTable_Def_FinancialCluses{ ID, Code, Name, IsViewToRepresent, IDFinancialType, IsDefaultToTransferMony, IsActive }

class Def_FinancialCluses
	{
		static List<String> ColumnsName = enTable_Def_FinancialCluses.values.map((item) => item.name).toList();

 int? ID;
 int? Code;
 String? Name;
 bool? IsViewToRepresent;
 int? IDFinancialType;
 bool? IsDefaultToTransferMony;
 bool? IsActive;

Def_FinancialCluses({
 		this.ID,
 		this.Code,
 		this.Name,
 		this.IsViewToRepresent,
 		this.IDFinancialType,
 		this.IsDefaultToTransferMony,
 		this.IsActive,
});


//**************************** general function ****************************

Def_FinancialCluses.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Code = json['Code'];
		 Name = json['Name'].toString();
		 IsViewToRepresent = json['IsViewToRepresent'];
		 IDFinancialType = json['IDFinancialType'];
		 IsDefaultToTransferMony = json['IsDefaultToTransferMony'];
		 IsActive = json['IsActive'];
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Code' : Code,
	 'Name' : Name,
	 'IsViewToRepresent' : IsViewToRepresent,
	 'IDFinancialType' : IDFinancialType,
	 'IsDefaultToTransferMony' : IsDefaultToTransferMony,
	 'IsActive' : IsActive,
		};
}

static List<dynamic> getColumnAsList(List<Def_FinancialCluses> lstDef_FinancialCluses, enTable_Def_FinancialCluses enTable)
	{
	if (enTable == enTable_Def_FinancialCluses.ID) {
		return lstDef_FinancialCluses.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Def_FinancialCluses.Code) {
		return lstDef_FinancialCluses.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Def_FinancialCluses.Name) {
		return lstDef_FinancialCluses.map((col) => col.Name).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Def_FinancialCluses.IsViewToRepresent) {
		return lstDef_FinancialCluses.map((col) => col.IsViewToRepresent).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Def_FinancialCluses.IDFinancialType) {
		return lstDef_FinancialCluses.map((col) => col.IDFinancialType).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Def_FinancialCluses.IsDefaultToTransferMony) {
		return lstDef_FinancialCluses.map((col) => col.IsDefaultToTransferMony).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Def_FinancialCluses.IsActive) {
		return lstDef_FinancialCluses.map((col) => col.IsActive).toSet().toList() as List<bool>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Def_FinancialCluses> lstDef_FinancialCluses, enTable_Def_FinancialCluses enTable)
	{
	if (enTable == enTable_Def_FinancialCluses.ID) {
		return lstDef_FinancialCluses.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_FinancialCluses.Code) {
		return lstDef_FinancialCluses.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_FinancialCluses.Name) {
		return lstDef_FinancialCluses.map((col) => col.Name.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_FinancialCluses.IsViewToRepresent) {
		return lstDef_FinancialCluses.map((col) => col.IsViewToRepresent.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_FinancialCluses.IDFinancialType) {
		return lstDef_FinancialCluses.map((col) => col.IDFinancialType.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_FinancialCluses.IsDefaultToTransferMony) {
		return lstDef_FinancialCluses.map((col) => col.IsDefaultToTransferMony.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_FinancialCluses.IsActive) {
		return lstDef_FinancialCluses.map((col) => col.IsActive.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

