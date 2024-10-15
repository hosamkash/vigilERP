

enum enTable_Fix_Monthes{ ID, Name }

class Fix_Monthes
	{
		static List<String> ColumnsName = enTable_Fix_Monthes.values.map((item) => item.name).toList();

 int? ID;
 String? Name;

Fix_Monthes({
 		this.ID,
 		this.Name,
});


//**************************** general function ****************************

Fix_Monthes.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
		};
}

static List<dynamic> getColumnAsList(List<Fix_Monthes> lstFix_Monthes, enTable_Fix_Monthes enTable)
	{
	if (enTable == enTable_Fix_Monthes.ID) {
		return lstFix_Monthes.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fix_Monthes.Name) {
		return lstFix_Monthes.map((col) => col.Name).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fix_Monthes> lstFix_Monthes, enTable_Fix_Monthes enTable)
	{
	if (enTable == enTable_Fix_Monthes.ID) {
		return lstFix_Monthes.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_Monthes.Name) {
		return lstFix_Monthes.map((col) => col.Name.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

