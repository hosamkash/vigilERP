

enum enTable_Fix_FinacialType{ ID, Name }

class Fix_FinacialType
	{
		static List<String> ColumnsName = enTable_Fix_FinacialType.values.map((item) => item.name).toList();

 int? ID;
 String? Name;

Fix_FinacialType({
 		this.ID,
 		this.Name,
});


//**************************** general function ****************************

Fix_FinacialType.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
		};
}

static List<dynamic> getColumnAsList(List<Fix_FinacialType> lstFix_FinacialType, enTable_Fix_FinacialType enTable)
	{
	if (enTable == enTable_Fix_FinacialType.ID) {
		return lstFix_FinacialType.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fix_FinacialType.Name) {
		return lstFix_FinacialType.map((col) => col.Name).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fix_FinacialType> lstFix_FinacialType, enTable_Fix_FinacialType enTable)
	{
	if (enTable == enTable_Fix_FinacialType.ID) {
		return lstFix_FinacialType.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_FinacialType.Name) {
		return lstFix_FinacialType.map((col) => col.Name.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

