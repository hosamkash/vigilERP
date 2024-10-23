

enum enTable_Fix_DealingType{ ID, Name }

class Fix_DealingType
	{
		static List<String> ColumnsName = enTable_Fix_DealingType.values.map((item) => item.name).toList();

 int? ID;
 String? Name;

Fix_DealingType({
 		this.ID,
 		this.Name,
});


//**************************** general function ****************************

Fix_DealingType.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
		};
}

static List<dynamic> getColumnAsList(List<Fix_DealingType> lstFix_DealingType, enTable_Fix_DealingType enTable)
	{
	if (enTable == enTable_Fix_DealingType.ID) {
		return lstFix_DealingType.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fix_DealingType.Name) {
		return lstFix_DealingType.map((col) => col.Name).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fix_DealingType> lstFix_DealingType, enTable_Fix_DealingType enTable)
	{
	if (enTable == enTable_Fix_DealingType.ID) {
		return lstFix_DealingType.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_DealingType.Name) {
		return lstFix_DealingType.map((col) => col.Name.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

