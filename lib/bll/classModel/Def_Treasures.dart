

enum enTable_Def_Treasures{ ID, Code, Name, IsActive, IsBindBranch, IDBranch, Balance }

class Def_Treasures
	{
		static List<String> ColumnsName = enTable_Def_Treasures.values.map((item) => item.name).toList();

 int? ID;
 int? Code;
 String? Name;
 bool? IsActive;
 bool? IsBindBranch;
 int? IDBranch;
 double? Balance;

Def_Treasures({
 		this.ID,
 		this.Code,
 		this.Name,
 		this.IsActive,
 		this.IsBindBranch,
 		this.IDBranch,
 		this.Balance,
});


//**************************** general function ****************************

Def_Treasures.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Code = json['Code'];
		 Name = json['Name'].toString();
		 IsActive = json['IsActive'];
		 IsBindBranch = json['IsBindBranch'];
		 IDBranch = json['IDBranch'];
		 Balance = json['Balance'];
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Code' : Code,
	 'Name' : Name,
	 'IsActive' : IsActive,
	 'IsBindBranch' : IsBindBranch,
	 'IDBranch' : IDBranch,
	 'Balance' : Balance,
		};
}

static List<dynamic> getColumnAsList(List<Def_Treasures> lstDef_Treasures, enTable_Def_Treasures enTable)
	{
	if (enTable == enTable_Def_Treasures.ID) {
		return lstDef_Treasures.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Def_Treasures.Code) {
		return lstDef_Treasures.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Def_Treasures.Name) {
		return lstDef_Treasures.map((col) => col.Name).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Def_Treasures.IsActive) {
		return lstDef_Treasures.map((col) => col.IsActive).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Def_Treasures.IsBindBranch) {
		return lstDef_Treasures.map((col) => col.IsBindBranch).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Def_Treasures.IDBranch) {
		return lstDef_Treasures.map((col) => col.IDBranch).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Def_Treasures.Balance) {
		return lstDef_Treasures.map((col) => col.Balance).toSet().toList() as List<double>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Def_Treasures> lstDef_Treasures, enTable_Def_Treasures enTable)
	{
	if (enTable == enTable_Def_Treasures.ID) {
		return lstDef_Treasures.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Treasures.Code) {
		return lstDef_Treasures.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Treasures.Name) {
		return lstDef_Treasures.map((col) => col.Name.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Treasures.IsActive) {
		return lstDef_Treasures.map((col) => col.IsActive.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Treasures.IsBindBranch) {
		return lstDef_Treasures.map((col) => col.IsBindBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Treasures.IDBranch) {
		return lstDef_Treasures.map((col) => col.IDBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Treasures.Balance) {
		return lstDef_Treasures.map((col) => col.Balance.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

