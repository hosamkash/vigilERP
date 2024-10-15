

enum enTable_Fix_Religions{ ID, Name }

class Fix_Religions
	{
		static List<String> ColumnsName = enTable_Fix_Religions.values.map((item) => item.name).toList();

 int? ID;
 String? Name;

Fix_Religions({
 		this.ID,
 		this.Name,
});


//**************************** general function ****************************

Fix_Religions.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
		};
}

static List<dynamic> getColumnAsList(List<Fix_Religions> lstFix_Religions, enTable_Fix_Religions enTable)
	{
	if (enTable == enTable_Fix_Religions.ID) {
		return lstFix_Religions.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fix_Religions.Name) {
		return lstFix_Religions.map((col) => col.Name).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fix_Religions> lstFix_Religions, enTable_Fix_Religions enTable)
	{
	if (enTable == enTable_Fix_Religions.ID) {
		return lstFix_Religions.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_Religions.Name) {
		return lstFix_Religions.map((col) => col.Name.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

