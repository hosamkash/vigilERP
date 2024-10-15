

enum enTable_Fix_Address_Building{ ID, Name }

class Fix_Address_Building
	{
		static List<String> ColumnsName = enTable_Fix_Address_Building.values.map((item) => item.name).toList();

 int? ID;
 String? Name;

Fix_Address_Building({
 		this.ID,
 		this.Name,
});


//**************************** general function ****************************

Fix_Address_Building.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
		};
}

static List<dynamic> getColumnAsList(List<Fix_Address_Building> lstFix_Address_Building, enTable_Fix_Address_Building enTable)
	{
	if (enTable == enTable_Fix_Address_Building.ID) {
		return lstFix_Address_Building.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fix_Address_Building.Name) {
		return lstFix_Address_Building.map((col) => col.Name).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fix_Address_Building> lstFix_Address_Building, enTable_Fix_Address_Building enTable)
	{
	if (enTable == enTable_Fix_Address_Building.ID) {
		return lstFix_Address_Building.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_Address_Building.Name) {
		return lstFix_Address_Building.map((col) => col.Name.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

