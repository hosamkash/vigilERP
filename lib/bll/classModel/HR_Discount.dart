

enum enTable_HR_Discount{ ID, IDBranch, Code, Date, Time, IDEmployee, IDJob, IDDepartment, EmployeeSalaryMonth, EmployeeSalaryWeek, EmployeeSalaryDay, EmployeeSalaryHour, DiscountType, DiscountDays, DiscountValue, DiscountReson, IDCalcSalary, UID, IsClosed }

class HR_Discount
	{
		static List<String> ColumnsName = enTable_HR_Discount.values.map((item) => item.name).toList();

 int? ID;
 int? IDBranch;
 int? Code;
 String? Date;
 String? Time;
 int? IDEmployee;
 int? IDJob;
 int? IDDepartment;
 double? EmployeeSalaryMonth;
 double? EmployeeSalaryWeek;
 double? EmployeeSalaryDay;
 double? EmployeeSalaryHour;
 int? DiscountType;
 double? DiscountDays;
 double? DiscountValue;
 String? DiscountReson;
 int? IDCalcSalary;
 String? UID;
 bool? IsClosed;

HR_Discount({
 		this.ID,
 		this.IDBranch,
 		this.Code,
 		this.Date,
 		this.Time,
 		this.IDEmployee,
 		this.IDJob,
 		this.IDDepartment,
 		this.EmployeeSalaryMonth,
 		this.EmployeeSalaryWeek,
 		this.EmployeeSalaryDay,
 		this.EmployeeSalaryHour,
 		this.DiscountType,
 		this.DiscountDays,
 		this.DiscountValue,
 		this.DiscountReson,
 		this.IDCalcSalary,
 		this.UID,
 		this.IsClosed,
});


//**************************** general function ****************************

HR_Discount.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 IDBranch = json['IDBranch'];
		 Code = json['Code'];
		 Date = json['Date'].toString();
		 Time = json['Time'].toString();
		 IDEmployee = json['IDEmployee'];
		 IDJob = json['IDJob'];
		 IDDepartment = json['IDDepartment'];
		 EmployeeSalaryMonth = json['EmployeeSalaryMonth'];
		 EmployeeSalaryWeek = json['EmployeeSalaryWeek'];
		 EmployeeSalaryDay = json['EmployeeSalaryDay'];
		 EmployeeSalaryHour = json['EmployeeSalaryHour'];
		 DiscountType = json['DiscountType'];
		 DiscountDays = json['DiscountDays'];
		 DiscountValue = json['DiscountValue'];
		 DiscountReson = json['DiscountReson'].toString();
		 IDCalcSalary = json['IDCalcSalary'];
		 UID = json['UID'].toString();
		 IsClosed = json['IsClosed'];
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'IDBranch' : IDBranch,
	 'Code' : Code,
	 'Date' : Date,
	 'Time' : Time,
	 'IDEmployee' : IDEmployee,
	 'IDJob' : IDJob,
	 'IDDepartment' : IDDepartment,
	 'EmployeeSalaryMonth' : EmployeeSalaryMonth,
	 'EmployeeSalaryWeek' : EmployeeSalaryWeek,
	 'EmployeeSalaryDay' : EmployeeSalaryDay,
	 'EmployeeSalaryHour' : EmployeeSalaryHour,
	 'DiscountType' : DiscountType,
	 'DiscountDays' : DiscountDays,
	 'DiscountValue' : DiscountValue,
	 'DiscountReson' : DiscountReson,
	 'IDCalcSalary' : IDCalcSalary,
	 'UID' : UID,
	 'IsClosed' : IsClosed,
		};
}

static List<dynamic> getColumnAsList(List<HR_Discount> lstHR_Discount, enTable_HR_Discount enTable)
	{
	if (enTable == enTable_HR_Discount.ID) {
		return lstHR_Discount.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Discount.IDBranch) {
		return lstHR_Discount.map((col) => col.IDBranch).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Discount.Code) {
		return lstHR_Discount.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Discount.Date) {
		return lstHR_Discount.map((col) => col.Date).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_HR_Discount.Time) {
		return lstHR_Discount.map((col) => col.Time).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_HR_Discount.IDEmployee) {
		return lstHR_Discount.map((col) => col.IDEmployee).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Discount.IDJob) {
		return lstHR_Discount.map((col) => col.IDJob).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Discount.IDDepartment) {
		return lstHR_Discount.map((col) => col.IDDepartment).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Discount.EmployeeSalaryMonth) {
		return lstHR_Discount.map((col) => col.EmployeeSalaryMonth).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Discount.EmployeeSalaryWeek) {
		return lstHR_Discount.map((col) => col.EmployeeSalaryWeek).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Discount.EmployeeSalaryDay) {
		return lstHR_Discount.map((col) => col.EmployeeSalaryDay).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Discount.EmployeeSalaryHour) {
		return lstHR_Discount.map((col) => col.EmployeeSalaryHour).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Discount.DiscountType) {
		return lstHR_Discount.map((col) => col.DiscountType).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Discount.DiscountDays) {
		return lstHR_Discount.map((col) => col.DiscountDays).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Discount.DiscountValue) {
		return lstHR_Discount.map((col) => col.DiscountValue).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Discount.DiscountReson) {
		return lstHR_Discount.map((col) => col.DiscountReson).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_HR_Discount.IDCalcSalary) {
		return lstHR_Discount.map((col) => col.IDCalcSalary).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Discount.UID) {
		return lstHR_Discount.map((col) => col.UID).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_HR_Discount.IsClosed) {
		return lstHR_Discount.map((col) => col.IsClosed).toSet().toList() as List<bool>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<HR_Discount> lstHR_Discount, enTable_HR_Discount enTable)
	{
	if (enTable == enTable_HR_Discount.ID) {
		return lstHR_Discount.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Discount.IDBranch) {
		return lstHR_Discount.map((col) => col.IDBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Discount.Code) {
		return lstHR_Discount.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Discount.Date) {
		return lstHR_Discount.map((col) => col.Date.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Discount.Time) {
		return lstHR_Discount.map((col) => col.Time.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Discount.IDEmployee) {
		return lstHR_Discount.map((col) => col.IDEmployee.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Discount.IDJob) {
		return lstHR_Discount.map((col) => col.IDJob.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Discount.IDDepartment) {
		return lstHR_Discount.map((col) => col.IDDepartment.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Discount.EmployeeSalaryMonth) {
		return lstHR_Discount.map((col) => col.EmployeeSalaryMonth.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Discount.EmployeeSalaryWeek) {
		return lstHR_Discount.map((col) => col.EmployeeSalaryWeek.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Discount.EmployeeSalaryDay) {
		return lstHR_Discount.map((col) => col.EmployeeSalaryDay.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Discount.EmployeeSalaryHour) {
		return lstHR_Discount.map((col) => col.EmployeeSalaryHour.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Discount.DiscountType) {
		return lstHR_Discount.map((col) => col.DiscountType.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Discount.DiscountDays) {
		return lstHR_Discount.map((col) => col.DiscountDays.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Discount.DiscountValue) {
		return lstHR_Discount.map((col) => col.DiscountValue.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Discount.DiscountReson) {
		return lstHR_Discount.map((col) => col.DiscountReson.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Discount.IDCalcSalary) {
		return lstHR_Discount.map((col) => col.IDCalcSalary.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Discount.UID) {
		return lstHR_Discount.map((col) => col.UID.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Discount.IsClosed) {
		return lstHR_Discount.map((col) => col.IsClosed.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

