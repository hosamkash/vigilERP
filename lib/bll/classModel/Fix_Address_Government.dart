

enum enTable_Fix_Address_Government{ ID, Name }

class Fix_Address_Government
	{
		static List<String> ColumnsName = enTable_Fix_Address_Government.values.map((item) => item.name).toList();

 int? ID;
 String? Name;

Fix_Address_Government({
 		this.ID,
 		this.Name,
});


//**************************** general function ****************************

Fix_Address_Government.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
		};
}

static List<dynamic> getColumnAsList(List<Fix_Address_Government> lstFix_Address_Government, enTable_Fix_Address_Government enTable)
	{
	if (enTable == enTable_Fix_Address_Government.ID) {
		return lstFix_Address_Government.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fix_Address_Government.Name) {
		return lstFix_Address_Government.map((col) => col.Name).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fix_Address_Government> lstFix_Address_Government, enTable_Fix_Address_Government enTable)
	{
	if (enTable == enTable_Fix_Address_Government.ID) {
		return lstFix_Address_Government.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_Address_Government.Name) {
		return lstFix_Address_Government.map((col) => col.Name.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

