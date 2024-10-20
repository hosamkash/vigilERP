

enum enTable_Def_Units{ ID, Name, IsActive }

class Def_Units
	{
		static List<String> ColumnsName = enTable_Def_Units.values.map((item) => item.name).toList();

 int? ID;
 String? Name;
 bool? IsActive;

Def_Units({
 		this.ID,
 		this.Name,
 		this.IsActive,
});


//**************************** general function ****************************

Def_Units.fromJson(Map<String, dynamic> json) {
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

static List<dynamic> getColumnAsList(List<Def_Units> lstDef_Units, enTable_Def_Units enTable)
	{
	if (enTable == enTable_Def_Units.ID) {
		return lstDef_Units.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Def_Units.Name) {
		return lstDef_Units.map((col) => col.Name).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Def_Units.IsActive) {
		return lstDef_Units.map((col) => col.IsActive).toSet().toList() as List<bool>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Def_Units> lstDef_Units, enTable_Def_Units enTable)
	{
	if (enTable == enTable_Def_Units.ID) {
		return lstDef_Units.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Units.Name) {
		return lstDef_Units.map((col) => col.Name.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Units.IsActive) {
		return lstDef_Units.map((col) => col.IsActive.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

