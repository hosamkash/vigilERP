

enum enTable_Dealing_Vendors{ ID, IDBranch, Code, Name, IsActive, CurrentBalance, BalanceType, Mobile, Phone, Address, Note }

class Dealing_Vendors
	{
		static List<String> ColumnsName = enTable_Dealing_Vendors.values.map((item) => item.name).toList();

 int? ID;
 int? IDBranch;
 int? Code;
 String? Name;
 bool? IsActive;
 double? CurrentBalance;
 int? BalanceType;
 String? Mobile;
 String? Phone;
 String? Address;
 String? Note;

Dealing_Vendors({
 		this.ID,
 		this.IDBranch,
 		this.Code,
 		this.Name,
 		this.IsActive,
 		this.CurrentBalance,
 		this.BalanceType,
 		this.Mobile,
 		this.Phone,
 		this.Address,
 		this.Note,
});


//**************************** general function ****************************

Dealing_Vendors.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 IDBranch = json['IDBranch'];
		 Code = json['Code'];
		 Name = json['Name'].toString();
		 IsActive = json['IsActive'];
		 CurrentBalance = json['CurrentBalance'];
		 BalanceType = json['BalanceType'];
		 Mobile = json['Mobile'].toString();
		 Phone = json['Phone'].toString();
		 Address = json['Address'].toString();
		 Note = json['Note'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'IDBranch' : IDBranch,
	 'Code' : Code,
	 'Name' : Name,
	 'IsActive' : IsActive,
	 'CurrentBalance' : CurrentBalance,
	 'BalanceType' : BalanceType,
	 'Mobile' : Mobile,
	 'Phone' : Phone,
	 'Address' : Address,
	 'Note' : Note,
		};
}

static List<dynamic> getColumnAsList(List<Dealing_Vendors> lstDealing_Vendors, enTable_Dealing_Vendors enTable)
	{
	if (enTable == enTable_Dealing_Vendors.ID) {
		return lstDealing_Vendors.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Dealing_Vendors.IDBranch) {
		return lstDealing_Vendors.map((col) => col.IDBranch).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Dealing_Vendors.Code) {
		return lstDealing_Vendors.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Dealing_Vendors.Name) {
		return lstDealing_Vendors.map((col) => col.Name).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Dealing_Vendors.IsActive) {
		return lstDealing_Vendors.map((col) => col.IsActive).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Dealing_Vendors.CurrentBalance) {
		return lstDealing_Vendors.map((col) => col.CurrentBalance).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Dealing_Vendors.BalanceType) {
		return lstDealing_Vendors.map((col) => col.BalanceType).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Dealing_Vendors.Mobile) {
		return lstDealing_Vendors.map((col) => col.Mobile).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Dealing_Vendors.Phone) {
		return lstDealing_Vendors.map((col) => col.Phone).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Dealing_Vendors.Address) {
		return lstDealing_Vendors.map((col) => col.Address).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Dealing_Vendors.Note) {
		return lstDealing_Vendors.map((col) => col.Note).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Dealing_Vendors> lstDealing_Vendors, enTable_Dealing_Vendors enTable)
	{
	if (enTable == enTable_Dealing_Vendors.ID) {
		return lstDealing_Vendors.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Vendors.IDBranch) {
		return lstDealing_Vendors.map((col) => col.IDBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Vendors.Code) {
		return lstDealing_Vendors.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Vendors.Name) {
		return lstDealing_Vendors.map((col) => col.Name.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Vendors.IsActive) {
		return lstDealing_Vendors.map((col) => col.IsActive.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Vendors.CurrentBalance) {
		return lstDealing_Vendors.map((col) => col.CurrentBalance.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Vendors.BalanceType) {
		return lstDealing_Vendors.map((col) => col.BalanceType.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Vendors.Mobile) {
		return lstDealing_Vendors.map((col) => col.Mobile.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Vendors.Phone) {
		return lstDealing_Vendors.map((col) => col.Phone.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Vendors.Address) {
		return lstDealing_Vendors.map((col) => col.Address.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Vendors.Note) {
		return lstDealing_Vendors.map((col) => col.Note.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

