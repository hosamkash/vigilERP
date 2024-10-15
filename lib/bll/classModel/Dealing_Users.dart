

enum enTable_Dealing_Users{ ID, UID, IDBranch, Code, Name, EMail, IsActive, IsAdminAccount, IDEmployeeBind, Mobile, Phone, Address, Note, ImageName, ImageURL }

class Dealing_Users
	{
		static List<String> ColumnsName = enTable_Dealing_Users.values.map((item) => item.name).toList();

 int? ID;
 String? UID;
 int? IDBranch;
 int? Code;
 String? Name;
 String? EMail;
 bool? IsActive;
 bool? IsAdminAccount;
 int? IDEmployeeBind;
 String? Mobile;
 String? Phone;
 String? Address;
 String? Note;
 String? ImageName;
 String? ImageURL;

Dealing_Users({
 		this.ID,
 		this.UID,
 		this.IDBranch,
 		this.Code,
 		this.Name,
 		this.EMail,
 		this.IsActive,
 		this.IsAdminAccount,
 		this.IDEmployeeBind,
 		this.Mobile,
 		this.Phone,
 		this.Address,
 		this.Note,
 		this.ImageName,
 		this.ImageURL,
});


//**************************** general function ****************************

Dealing_Users.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 UID = json['UID'].toString();
		 IDBranch = json['IDBranch'];
		 Code = json['Code'];
		 Name = json['Name'].toString();
		 EMail = json['EMail'].toString();
		 IsActive = json['IsActive'];
		 IsAdminAccount = json['IsAdminAccount'];
		 IDEmployeeBind = json['IDEmployeeBind'];
		 Mobile = json['Mobile'].toString();
		 Phone = json['Phone'].toString();
		 Address = json['Address'].toString();
		 Note = json['Note'].toString();
		 ImageName = json['ImageName'].toString();
		 ImageURL = json['ImageURL'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'UID' : UID,
	 'IDBranch' : IDBranch,
	 'Code' : Code,
	 'Name' : Name,
	 'EMail' : EMail,
	 'IsActive' : IsActive,
	 'IsAdminAccount' : IsAdminAccount,
	 'IDEmployeeBind' : IDEmployeeBind,
	 'Mobile' : Mobile,
	 'Phone' : Phone,
	 'Address' : Address,
	 'Note' : Note,
	 'ImageName' : ImageName,
	 'ImageURL' : ImageURL,
		};
}

static List<dynamic> getColumnAsList(List<Dealing_Users> lstDealing_Users, enTable_Dealing_Users enTable)
	{
	if (enTable == enTable_Dealing_Users.ID) {
		return lstDealing_Users.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Dealing_Users.UID) {
		return lstDealing_Users.map((col) => col.UID).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Dealing_Users.IDBranch) {
		return lstDealing_Users.map((col) => col.IDBranch).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Dealing_Users.Code) {
		return lstDealing_Users.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Dealing_Users.Name) {
		return lstDealing_Users.map((col) => col.Name).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Dealing_Users.EMail) {
		return lstDealing_Users.map((col) => col.EMail).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Dealing_Users.IsActive) {
		return lstDealing_Users.map((col) => col.IsActive).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Dealing_Users.IsAdminAccount) {
		return lstDealing_Users.map((col) => col.IsAdminAccount).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Dealing_Users.IDEmployeeBind) {
		return lstDealing_Users.map((col) => col.IDEmployeeBind).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Dealing_Users.Mobile) {
		return lstDealing_Users.map((col) => col.Mobile).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Dealing_Users.Phone) {
		return lstDealing_Users.map((col) => col.Phone).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Dealing_Users.Address) {
		return lstDealing_Users.map((col) => col.Address).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Dealing_Users.Note) {
		return lstDealing_Users.map((col) => col.Note).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Dealing_Users.ImageName) {
		return lstDealing_Users.map((col) => col.ImageName).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Dealing_Users.ImageURL) {
		return lstDealing_Users.map((col) => col.ImageURL).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Dealing_Users> lstDealing_Users, enTable_Dealing_Users enTable)
	{
	if (enTable == enTable_Dealing_Users.ID) {
		return lstDealing_Users.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Users.UID) {
		return lstDealing_Users.map((col) => col.UID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Users.IDBranch) {
		return lstDealing_Users.map((col) => col.IDBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Users.Code) {
		return lstDealing_Users.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Users.Name) {
		return lstDealing_Users.map((col) => col.Name.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Users.EMail) {
		return lstDealing_Users.map((col) => col.EMail.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Users.IsActive) {
		return lstDealing_Users.map((col) => col.IsActive.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Users.IsAdminAccount) {
		return lstDealing_Users.map((col) => col.IsAdminAccount.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Users.IDEmployeeBind) {
		return lstDealing_Users.map((col) => col.IDEmployeeBind.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Users.Mobile) {
		return lstDealing_Users.map((col) => col.Mobile.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Users.Phone) {
		return lstDealing_Users.map((col) => col.Phone.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Users.Address) {
		return lstDealing_Users.map((col) => col.Address.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Users.Note) {
		return lstDealing_Users.map((col) => col.Note.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Users.ImageName) {
		return lstDealing_Users.map((col) => col.ImageName.toString()).toSet().toList();
	}
	else if (enTable == enTable_Dealing_Users.ImageURL) {
		return lstDealing_Users.map((col) => col.ImageURL.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

