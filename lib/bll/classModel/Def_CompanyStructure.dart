

enum enTable_Def_CompanyStructure{ ID, Code, Name, DateCreate, Adress, Phone, Mobile, Logo, isActive, isOwner, defaultStock, defaultTreasure, defaultEmployee }

class Def_CompanyStructure
	{
		static List<String> ColumnsName = enTable_Def_CompanyStructure.values.map((item) => item.name).toList();

 int? ID;
 int? Code;
 String? Name;
 String? DateCreate;
 String? Adress;
 String? Phone;
 String? Mobile;
 String? Logo;
 bool? isActive;
 bool? isOwner;
 String? defaultStock;
 String? defaultTreasure;
 String? defaultEmployee;

Def_CompanyStructure({
 		this.ID,
 		this.Code,
 		this.Name,
 		this.DateCreate,
 		this.Adress,
 		this.Phone,
 		this.Mobile,
 		this.Logo,
 		this.isActive,
 		this.isOwner,
 		this.defaultStock,
 		this.defaultTreasure,
 		this.defaultEmployee,
});


//**************************** general function ****************************

Def_CompanyStructure.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 Code = json['Code'];
		 Name = json['Name'].toString();
		 DateCreate = json['DateCreate'].toString();
		 Adress = json['Adress'].toString();
		 Phone = json['Phone'].toString();
		 Mobile = json['Mobile'].toString();
		 Logo = json['Logo'].toString();
		 isActive = json['isActive'];
		 isOwner = json['isOwner'];
		 defaultStock = json['defaultStock'].toString();
		 defaultTreasure = json['defaultTreasure'].toString();
		 defaultEmployee = json['defaultEmployee'].toString();
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'Code' : Code,
	 'Name' : Name,
	 'DateCreate' : DateCreate,
	 'Adress' : Adress,
	 'Phone' : Phone,
	 'Mobile' : Mobile,
	 'Logo' : Logo,
	 'isActive' : isActive,
	 'isOwner' : isOwner,
	 'defaultStock' : defaultStock,
	 'defaultTreasure' : defaultTreasure,
	 'defaultEmployee' : defaultEmployee,
		};
}

static List<dynamic> getColumnAsList(List<Def_CompanyStructure> lstDef_CompanyStructure, enTable_Def_CompanyStructure enTable)
	{
	if (enTable == enTable_Def_CompanyStructure.ID) {
		return lstDef_CompanyStructure.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Def_CompanyStructure.Code) {
		return lstDef_CompanyStructure.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Def_CompanyStructure.Name) {
		return lstDef_CompanyStructure.map((col) => col.Name).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Def_CompanyStructure.DateCreate) {
		return lstDef_CompanyStructure.map((col) => col.DateCreate).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Def_CompanyStructure.Adress) {
		return lstDef_CompanyStructure.map((col) => col.Adress).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Def_CompanyStructure.Phone) {
		return lstDef_CompanyStructure.map((col) => col.Phone).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Def_CompanyStructure.Mobile) {
		return lstDef_CompanyStructure.map((col) => col.Mobile).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Def_CompanyStructure.Logo) {
		return lstDef_CompanyStructure.map((col) => col.Logo).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Def_CompanyStructure.isActive) {
		return lstDef_CompanyStructure.map((col) => col.isActive).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Def_CompanyStructure.isOwner) {
		return lstDef_CompanyStructure.map((col) => col.isOwner).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Def_CompanyStructure.defaultStock) {
		return lstDef_CompanyStructure.map((col) => col.defaultStock).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Def_CompanyStructure.defaultTreasure) {
		return lstDef_CompanyStructure.map((col) => col.defaultTreasure).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_Def_CompanyStructure.defaultEmployee) {
		return lstDef_CompanyStructure.map((col) => col.defaultEmployee).toSet().toList() as List<String>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Def_CompanyStructure> lstDef_CompanyStructure, enTable_Def_CompanyStructure enTable)
	{
	if (enTable == enTable_Def_CompanyStructure.ID) {
		return lstDef_CompanyStructure.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_CompanyStructure.Code) {
		return lstDef_CompanyStructure.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_CompanyStructure.Name) {
		return lstDef_CompanyStructure.map((col) => col.Name.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_CompanyStructure.DateCreate) {
		return lstDef_CompanyStructure.map((col) => col.DateCreate.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_CompanyStructure.Adress) {
		return lstDef_CompanyStructure.map((col) => col.Adress.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_CompanyStructure.Phone) {
		return lstDef_CompanyStructure.map((col) => col.Phone.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_CompanyStructure.Mobile) {
		return lstDef_CompanyStructure.map((col) => col.Mobile.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_CompanyStructure.Logo) {
		return lstDef_CompanyStructure.map((col) => col.Logo.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_CompanyStructure.isActive) {
		return lstDef_CompanyStructure.map((col) => col.isActive.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_CompanyStructure.isOwner) {
		return lstDef_CompanyStructure.map((col) => col.isOwner.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_CompanyStructure.defaultStock) {
		return lstDef_CompanyStructure.map((col) => col.defaultStock.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_CompanyStructure.defaultTreasure) {
		return lstDef_CompanyStructure.map((col) => col.defaultTreasure.toString()).toSet().toList();
	}
	else if (enTable == enTable_Def_CompanyStructure.defaultEmployee) {
		return lstDef_CompanyStructure.map((col) => col.defaultEmployee.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

