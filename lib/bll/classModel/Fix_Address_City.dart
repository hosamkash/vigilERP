

enum enTable_Fix_Address_City{ ID, Name, IDGovernment }

class Fix_Address_City
	{
		static List<String> ColumnsName = enTable_Fix_Address_City.values.map((item) => item.name).toList();

 int? ID;
 String? Name;
 int? IDGovernment;

Fix_Address_City({
 		this.ID,
 		this.Name,
 		this.IDGovernment,
});


//**************************** general function ****************************

Fix_Address_City.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
		 IDGovernment = json['IDGovernment'];
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
	 'IDGovernment' : IDGovernment,
		};
}

static List<dynamic> getColumnAsList(List<Fix_Address_City> lstFix_Address_City, enTable_Fix_Address_City enTable)
	{
	if (enTable == enTable_Fix_Address_City.ID) {
		return lstFix_Address_City.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fix_Address_City.Name) {
		return lstFix_Address_City.map((col) => col.Name).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fix_Address_City.IDGovernment) {
		return lstFix_Address_City.map((col) => col.IDGovernment).toSet().toList() as List<int>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fix_Address_City> lstFix_Address_City, enTable_Fix_Address_City enTable)
	{
	if (enTable == enTable_Fix_Address_City.ID) {
		return lstFix_Address_City.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_Address_City.Name) {
		return lstFix_Address_City.map((col) => col.Name.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_Address_City.IDGovernment) {
		return lstFix_Address_City.map((col) => col.IDGovernment.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

