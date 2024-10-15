

enum enTable_Dealing_Clients{ ID, IDBranch, Code, Name, IsActive, CurrentBalance, BalanceType, Mobile, Phone, Address, Note, IDPriceType, CreditLimit, LocationLink, LocationLatitude, LocationLongitude, LocationImage }

class Dealing_Clients
	{
		static List<String> ColumnsName = enTable_Dealing_Clients.values.map((item) => item.name).toList();

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
 int? IDPriceType;
 double? CreditLimit;
 String? LocationLink;
 double? LocationLatitude;
 double? LocationLongitude;
 String? LocationImage;

Dealing_Clients({
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
 		this.IDPriceType,
 		this.CreditLimit,
 		this.LocationLink,
 		this.LocationLatitude,
 		this.LocationLongitude,
 		this.LocationImage,
});


//**************************** general function ****************************

Dealing_Clients.fromJson(Map<String, dynamic> json) {
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
		 IDPriceType = json['IDPriceType'];
		 CreditLimit = json['CreditLimit'];
		 LocationLink = json['LocationLink'].toString();
		 LocationLatitude = json['LocationLatitude'];
		 LocationLongitude = json['LocationLongitude'];
		 LocationImage = json['LocationImage'].toString();
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
	 'IDPriceType' : IDPriceType,
	 'CreditLimit' : CreditLimit,
	 'LocationLink' : LocationLink,
	 'LocationLatitude' : LocationLatitude,
	 'LocationLongitude' : LocationLongitude,
	 'LocationImage' : LocationImage,
		};
}

static List<dynamic> getColumnAsList(List<Dealing_Clients> lstDealing_Clients, enTable_Dealing_Clients enTable)
	{
	if (enTable == enTable_Dealing_Clients.ID) {
		return lstDealing_Clients.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Dealing_Clients.IDBranch) {
		return lstDealing_Clients.map((col) => col.IDBranch).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Dealing_Clients.Code) {
		return lstDealing_Clients.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Dealing_Clients.Name) {
		return lstDealing_Clients.map((col) => col.Name).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Dealing_Clients.IsActive) {
		return lstDealing_Clients.map((col) => col.IsActive).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Dealing_Clients.CurrentBalance) {
		return lstDealing_Clients.map((col) => col.CurrentBalance).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Dealing_Clients.BalanceType) {
		return lstDealing_Clients.map((col) => col.BalanceType).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Dealing_Clients.Mobile) {
		return lstDealing_Clients.map((col) => col.Mobile).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Dealing_Clients.Phone) {
		return lstDealing_Clients.map((col) => col.Phone).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Dealing_Clients.Address) {
		return lstDealing_Clients.map((col) => col.Address).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Dealing_Clients.Note) {
		return lstDealing_Clients.map((col) => col.Note).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Dealing_Clients.IDPriceType) {
		return lstDealing_Clients.map((col) => col.IDPriceType).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Dealing_Clients.CreditLimit) {
		return lstDealing_Clients.map((col) => col.CreditLimit).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Dealing_Clients.LocationLink) {
		return lstDealing_Clients.map((col) => col.LocationLink).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Dealing_Clients.LocationLatitude) {
		return lstDealing_Clients.map((col) => col.LocationLatitude).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Dealing_Clients.LocationLongitude) {
		return lstDealing_Clients.map((col) => col.LocationLongitude).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Dealing_Clients.LocationImage) {
		return lstDealing_Clients.map((col) => col.LocationImage).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Dealing_Clients> lstDealing_Clients, enTable_Dealing_Clients enTable)
	{
	if (enTable == enTable_Dealing_Clients.ID) {
		return lstDealing_Clients.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Clients.IDBranch) {
		return lstDealing_Clients.map((col) => col.IDBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Clients.Code) {
		return lstDealing_Clients.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Clients.Name) {
		return lstDealing_Clients.map((col) => col.Name.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Clients.IsActive) {
		return lstDealing_Clients.map((col) => col.IsActive.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Clients.CurrentBalance) {
		return lstDealing_Clients.map((col) => col.CurrentBalance.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Clients.BalanceType) {
		return lstDealing_Clients.map((col) => col.BalanceType.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Clients.Mobile) {
		return lstDealing_Clients.map((col) => col.Mobile.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Clients.Phone) {
		return lstDealing_Clients.map((col) => col.Phone.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Clients.Address) {
		return lstDealing_Clients.map((col) => col.Address.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Clients.Note) {
		return lstDealing_Clients.map((col) => col.Note.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Clients.IDPriceType) {
		return lstDealing_Clients.map((col) => col.IDPriceType.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Clients.CreditLimit) {
		return lstDealing_Clients.map((col) => col.CreditLimit.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Clients.LocationLink) {
		return lstDealing_Clients.map((col) => col.LocationLink.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Clients.LocationLatitude) {
		return lstDealing_Clients.map((col) => col.LocationLatitude.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Clients.LocationLongitude) {
		return lstDealing_Clients.map((col) => col.LocationLongitude.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Clients.LocationImage) {
		return lstDealing_Clients.map((col) => col.LocationImage.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

