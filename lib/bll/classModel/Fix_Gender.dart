

enum enTable_Fix_Gender{ ID, Name }

class Fix_Gender
	{
		static List<String> ColumnsName = enTable_Fix_Gender.values.map((item) => item.name).toList();

 int? ID;
 String? Name;

Fix_Gender({
 		this.ID,
 		this.Name,
});


//**************************** general function ****************************

Fix_Gender.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
		};
}

static List<dynamic> getColumnAsList(List<Fix_Gender> lstFix_Gender, enTable_Fix_Gender enTable)
	{
	if (enTable == enTable_Fix_Gender.ID) {
		return lstFix_Gender.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fix_Gender.Name) {
		return lstFix_Gender.map((col) => col.Name).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fix_Gender> lstFix_Gender, enTable_Fix_Gender enTable)
	{
	if (enTable == enTable_Fix_Gender.ID) {
		return lstFix_Gender.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_Gender.Name) {
		return lstFix_Gender.map((col) => col.Name.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

