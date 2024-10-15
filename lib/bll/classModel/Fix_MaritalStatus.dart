

enum enTable_Fix_MaritalStatus{ ID, Name }

class Fix_MaritalStatus
	{
		static List<String> ColumnsName = enTable_Fix_MaritalStatus.values.map((item) => item.name).toList();

 int? ID;
 String? Name;

Fix_MaritalStatus({
 		this.ID,
 		this.Name,
});


//**************************** general function ****************************

Fix_MaritalStatus.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
		};
}

static List<dynamic> getColumnAsList(List<Fix_MaritalStatus> lstFix_MaritalStatus, enTable_Fix_MaritalStatus enTable)
	{
	if (enTable == enTable_Fix_MaritalStatus.ID) {
		return lstFix_MaritalStatus.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fix_MaritalStatus.Name) {
		return lstFix_MaritalStatus.map((col) => col.Name).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fix_MaritalStatus> lstFix_MaritalStatus, enTable_Fix_MaritalStatus enTable)
	{
	if (enTable == enTable_Fix_MaritalStatus.ID) {
		return lstFix_MaritalStatus.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_MaritalStatus.Name) {
		return lstFix_MaritalStatus.map((col) => col.Name.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

