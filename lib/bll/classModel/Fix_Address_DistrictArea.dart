

enum enTable_Fix_Address_DistrictArea{ ID, Name, CityID }

class Fix_Address_DistrictArea
	{
		static List<String> ColumnsName = enTable_Fix_Address_DistrictArea.values.map((item) => item.name).toList();

 int? ID;
 String? Name;
 int? CityID;

Fix_Address_DistrictArea({
 		this.ID,
 		this.Name,
 		this.CityID,
});


//**************************** general function ****************************

Fix_Address_DistrictArea.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
		 CityID = json['CityID'];
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
	 'CityID' : CityID,
		};
}

static List<dynamic> getColumnAsList(List<Fix_Address_DistrictArea> lstFix_Address_DistrictArea, enTable_Fix_Address_DistrictArea enTable)
	{
	if (enTable == enTable_Fix_Address_DistrictArea.ID) {
		return lstFix_Address_DistrictArea.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fix_Address_DistrictArea.Name) {
		return lstFix_Address_DistrictArea.map((col) => col.Name).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Fix_Address_DistrictArea.CityID) {
		return lstFix_Address_DistrictArea.map((col) => col.CityID).toSet().toList() as List<int>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fix_Address_DistrictArea> lstFix_Address_DistrictArea, enTable_Fix_Address_DistrictArea enTable)
	{
	if (enTable == enTable_Fix_Address_DistrictArea.ID) {
		return lstFix_Address_DistrictArea.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_Address_DistrictArea.Name) {
		return lstFix_Address_DistrictArea.map((col) => col.Name.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_Address_DistrictArea.CityID) {
		return lstFix_Address_DistrictArea.map((col) => col.CityID.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

