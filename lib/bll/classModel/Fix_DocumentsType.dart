

enum enTable_Fix_DocumentsType{ ID, Name }

class Fix_DocumentsType
	{
		static List<String> ColumnsName = enTable_Fix_DocumentsType.values.map((item) => item.name).toList();

 int? ID;
 String? Name;

Fix_DocumentsType({
 		this.ID,
 		this.Name,
});


//**************************** general function ****************************

Fix_DocumentsType.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
		};
}

static List<dynamic> getColumnAsList(List<Fix_DocumentsType> lstFix_DocumentsType, enTable_Fix_DocumentsType enTable)
	{
	if (enTable == enTable_Fix_DocumentsType.ID) {
		return lstFix_DocumentsType.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fix_DocumentsType.Name) {
		return lstFix_DocumentsType.map((col) => col.Name).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fix_DocumentsType> lstFix_DocumentsType, enTable_Fix_DocumentsType enTable)
	{
	if (enTable == enTable_Fix_DocumentsType.ID) {
		return lstFix_DocumentsType.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_DocumentsType.Name) {
		return lstFix_DocumentsType.map((col) => col.Name.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

