

enum enTable_Fix_MilitaryStatus{ ID, Name }

class Fix_MilitaryStatus
	{
		static List<String> ColumnsName = enTable_Fix_MilitaryStatus.values.map((item) => item.name).toList();

 int? ID;
 String? Name;

Fix_MilitaryStatus({
 		this.ID,
 		this.Name,
});


//**************************** general function ****************************

Fix_MilitaryStatus.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Name = json['Name'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Name' : Name,
		};
}

static List<dynamic> getColumnAsList(List<Fix_MilitaryStatus> lstFix_MilitaryStatus, enTable_Fix_MilitaryStatus enTable)
	{
	if (enTable == enTable_Fix_MilitaryStatus.ID) {
		return lstFix_MilitaryStatus.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Fix_MilitaryStatus.Name) {
		return lstFix_MilitaryStatus.map((col) => col.Name).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Fix_MilitaryStatus> lstFix_MilitaryStatus, enTable_Fix_MilitaryStatus enTable)
	{
	if (enTable == enTable_Fix_MilitaryStatus.ID) {
		return lstFix_MilitaryStatus.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Fix_MilitaryStatus.Name) {
		return lstFix_MilitaryStatus.map((col) => col.Name.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

