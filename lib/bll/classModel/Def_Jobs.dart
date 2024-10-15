

enum enTable_Def_Jobs{ ID, Name, IsActive }

class Def_Jobs
	{
		static List<String> ColumnsName = enTable_Def_Jobs.values.map((item) => item.name).toList();

 int? ID;
 String? Name;
 bool? IsActive;

Def_Jobs({
 		this.ID,
 		this.Name,
 		this.IsActive,
});


//**************************** general function ****************************

Def_Jobs.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
		 IsActive = json['IsActive'];
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
	 'IsActive' : IsActive,
		};
}

static List<dynamic> getColumnAsList(List<Def_Jobs> lstDef_Jobs, enTable_Def_Jobs enTable)
	{
	if (enTable == enTable_Def_Jobs.ID) {
		return lstDef_Jobs.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Def_Jobs.Name) {
		return lstDef_Jobs.map((col) => col.Name).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Def_Jobs.IsActive) {
		return lstDef_Jobs.map((col) => col.IsActive).toSet().toList() as List<bool>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Def_Jobs> lstDef_Jobs, enTable_Def_Jobs enTable)
	{
	if (enTable == enTable_Def_Jobs.ID) {
		return lstDef_Jobs.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Jobs.Name) {
		return lstDef_Jobs.map((col) => col.Name.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Jobs.IsActive) {
		return lstDef_Jobs.map((col) => col.IsActive.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

