

enum enTable_Fix_RequestStatus{ ID, Name }

class Fix_RequestStatus
	{
		static List<String> ColumnsName = enTable_Fix_RequestStatus.values.map((item) => item.name).toList();

 int? ID;
 String? Name;

Fix_RequestStatus({
 		this.ID,
 		this.Name,
});


//**************************** general function ****************************

Fix_RequestStatus.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
		};
}

static List<dynamic> getColumnAsList(List<Fix_RequestStatus> lstFix_RequestStatus, enTable_Fix_RequestStatus enTable)
	{
	if (enTable == enTable_Fix_RequestStatus.ID) {
		return lstFix_RequestStatus.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fix_RequestStatus.Name) {
		return lstFix_RequestStatus.map((col) => col.Name).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fix_RequestStatus> lstFix_RequestStatus, enTable_Fix_RequestStatus enTable)
	{
	if (enTable == enTable_Fix_RequestStatus.ID) {
		return lstFix_RequestStatus.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_RequestStatus.Name) {
		return lstFix_RequestStatus.map((col) => col.Name.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

