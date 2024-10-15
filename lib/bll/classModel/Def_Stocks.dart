

enum enTable_Def_Stocks{ ID, Code, Name, IsActive, IsBindBranch, IDBranch }

class Def_Stocks
	{
		static List<String> ColumnsName = enTable_Def_Stocks.values.map((item) => item.name).toList();

 int? ID;
 int? Code;
 String? Name;
 bool? IsActive;
 bool? IsBindBranch;
 int? IDBranch;

Def_Stocks({
 		this.ID,
 		this.Code,
 		this.Name,
 		this.IsActive,
 		this.IsBindBranch,
 		this.IDBranch,
});


//**************************** general function ****************************

Def_Stocks.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Code = json['Code'];
		 Name = json['Name'].toString();
		 IsActive = json['IsActive'];
		 IsBindBranch = json['IsBindBranch'];
		 IDBranch = json['IDBranch'];
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Code' : Code,
	 'Name' : Name,
	 'IsActive' : IsActive,
	 'IsBindBranch' : IsBindBranch,
	 'IDBranch' : IDBranch,
		};
}

static List<dynamic> getColumnAsList(List<Def_Stocks> lstDef_Stocks, enTable_Def_Stocks enTable)
	{
	if (enTable == enTable_Def_Stocks.ID) {
		return lstDef_Stocks.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Def_Stocks.Code) {
		return lstDef_Stocks.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Def_Stocks.Name) {
		return lstDef_Stocks.map((col) => col.Name).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Def_Stocks.IsActive) {
		return lstDef_Stocks.map((col) => col.IsActive).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Def_Stocks.IsBindBranch) {
		return lstDef_Stocks.map((col) => col.IsBindBranch).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Def_Stocks.IDBranch) {
		return lstDef_Stocks.map((col) => col.IDBranch).toSet().toList() as List<int>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Def_Stocks> lstDef_Stocks, enTable_Def_Stocks enTable)
	{
	if (enTable == enTable_Def_Stocks.ID) {
		return lstDef_Stocks.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Stocks.Code) {
		return lstDef_Stocks.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Stocks.Name) {
		return lstDef_Stocks.map((col) => col.Name.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Stocks.IsActive) {
		return lstDef_Stocks.map((col) => col.IsActive.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Stocks.IsBindBranch) {
		return lstDef_Stocks.map((col) => col.IsBindBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Stocks.IDBranch) {
		return lstDef_Stocks.map((col) => col.IDBranch.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

