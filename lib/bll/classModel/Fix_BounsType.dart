

enum enTable_Fix_BounsType{ ID, Name }

class Fix_BounsType
	{
		static List<String> ColumnsName = enTable_Fix_BounsType.values.map((item) => item.name).toList();

 int? ID;
 String? Name;

Fix_BounsType({
 		this.ID,
 		this.Name,
});


//**************************** general function ****************************

Fix_BounsType.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
		};
}

static List<dynamic> getColumnAsList(List<Fix_BounsType> lstFix_BounsType, enTable_Fix_BounsType enTable)
	{
	if (enTable == enTable_Fix_BounsType.ID) {
		return lstFix_BounsType.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fix_BounsType.Name) {
		return lstFix_BounsType.map((col) => col.Name).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fix_BounsType> lstFix_BounsType, enTable_Fix_BounsType enTable)
	{
	if (enTable == enTable_Fix_BounsType.ID) {
		return lstFix_BounsType.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_BounsType.Name) {
		return lstFix_BounsType.map((col) => col.Name.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

