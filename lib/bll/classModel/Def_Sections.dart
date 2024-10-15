

enum enTable_Def_Sections{ ID, Name, IsActive }

class Def_Sections
	{
		static List<String> ColumnsName = enTable_Def_Sections.values.map((item) => item.name).toList();

 int? ID;
 String? Name;
 bool? IsActive;

Def_Sections({
 		this.ID,
 		this.Name,
 		this.IsActive,
});


//**************************** general function ****************************

Def_Sections.fromJson(Map<String, dynamic> json) {
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

static List<dynamic> getColumnAsList(List<Def_Sections> lstDef_Sections, enTable_Def_Sections enTable)
	{
	if (enTable == enTable_Def_Sections.ID) {
		return lstDef_Sections.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Def_Sections.Name) {
		return lstDef_Sections.map((col) => col.Name).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Def_Sections.IsActive) {
		return lstDef_Sections.map((col) => col.IsActive).toSet().toList() as List<bool>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Def_Sections> lstDef_Sections, enTable_Def_Sections enTable)
	{
	if (enTable == enTable_Def_Sections.ID) {
		return lstDef_Sections.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Sections.Name) {
		return lstDef_Sections.map((col) => col.Name.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_Sections.IsActive) {
		return lstDef_Sections.map((col) => col.IsActive.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

