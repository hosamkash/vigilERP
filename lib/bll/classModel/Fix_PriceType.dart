

enum enTable_Fix_PriceType{ ID, Name }

class Fix_PriceType
	{
		static List<String> ColumnsName = enTable_Fix_PriceType.values.map((item) => item.name).toList();

 int? ID;
 String? Name;

Fix_PriceType({
 		this.ID,
 		this.Name,
});


//**************************** general function ****************************

Fix_PriceType.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
		};
}

static List<dynamic> getColumnAsList(List<Fix_PriceType> lstFix_PriceType, enTable_Fix_PriceType enTable)
	{
	if (enTable == enTable_Fix_PriceType.ID) {
		return lstFix_PriceType.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fix_PriceType.Name) {
		return lstFix_PriceType.map((col) => col.Name).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fix_PriceType> lstFix_PriceType, enTable_Fix_PriceType enTable)
	{
	if (enTable == enTable_Fix_PriceType.ID) {
		return lstFix_PriceType.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_PriceType.Name) {
		return lstFix_PriceType.map((col) => col.Name.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

