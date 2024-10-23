

enum enTable_Fix_FinancialType{ ID, Name }

class Fix_FinancialType
	{
		static List<String> ColumnsName = enTable_Fix_FinancialType.values.map((item) => item.name).toList();

 int? ID;
 String? Name;

Fix_FinancialType({
 		this.ID,
 		this.Name,
});


//**************************** general function ****************************

Fix_FinancialType.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
		};
}

static List<dynamic> getColumnAsList(List<Fix_FinancialType> lstFix_FinancialType, enTable_Fix_FinancialType enTable)
	{
	if (enTable == enTable_Fix_FinancialType.ID) {
		return lstFix_FinancialType.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fix_FinancialType.Name) {
		return lstFix_FinancialType.map((col) => col.Name).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fix_FinancialType> lstFix_FinancialType, enTable_Fix_FinancialType enTable)
	{
	if (enTable == enTable_Fix_FinancialType.ID) {
		return lstFix_FinancialType.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_FinancialType.Name) {
		return lstFix_FinancialType.map((col) => col.Name.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

