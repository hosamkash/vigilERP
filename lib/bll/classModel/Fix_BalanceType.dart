

enum enTable_Fix_BalanceType{ ID, Name }

class Fix_BalanceType
	{
		static List<String> ColumnsName = enTable_Fix_BalanceType.values.map((item) => item.name).toList();

 int? ID;
 String? Name;

Fix_BalanceType({
 		this.ID,
 		this.Name,
});


//**************************** general function ****************************

Fix_BalanceType.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
		};
}

static List<dynamic> getColumnAsList(List<Fix_BalanceType> lstFix_BalanceType, enTable_Fix_BalanceType enTable)
	{
	if (enTable == enTable_Fix_BalanceType.ID) {
		return lstFix_BalanceType.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fix_BalanceType.Name) {
		return lstFix_BalanceType.map((col) => col.Name).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fix_BalanceType> lstFix_BalanceType, enTable_Fix_BalanceType enTable)
	{
	if (enTable == enTable_Fix_BalanceType.ID) {
		return lstFix_BalanceType.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_BalanceType.Name) {
		return lstFix_BalanceType.map((col) => col.Name.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

