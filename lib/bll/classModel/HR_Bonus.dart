

enum enTable_HR_Bonus{ ID, IDBranch, Code, Date, Time, IDEmployee, IDJob, IDDepartment, EmployeeSalaryMonth, EmployeeSalaryWeek, EmployeeSalaryDay, EmployeeSalaryHour, BounsType, BounsDays, BounsValue, BounsReson, IDCalcSalary, UID, IsClosed }

class HR_Bonus
	{
		static List<String> ColumnsName = enTable_HR_Bonus.values.map((item) => item.name).toList();

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
 int? BounsType;
 double? BounsDays;
 double? BounsValue;
 String? BounsReson;
 int? IDCalcSalary;
 String? UID;
 bool? IsClosed;

HR_Bonus({
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
 		this.BounsType,
 		this.BounsDays,
 		this.BounsValue,
 		this.BounsReson,
 		this.IDCalcSalary,
 		this.UID,
 		this.IsClosed,
});


//**************************** general function ****************************

HR_Bonus.fromJson(Map<String, dynamic> json) {
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
		 BounsType = json['BounsType'];
		 BounsDays = json['BounsDays'];
		 BounsValue = json['BounsValue'];
		 BounsReson = json['BounsReson'].toString();
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
	 'BounsType' : BounsType,
	 'BounsDays' : BounsDays,
	 'BounsValue' : BounsValue,
	 'BounsReson' : BounsReson,
	 'IDCalcSalary' : IDCalcSalary,
	 'UID' : UID,
	 'IsClosed' : IsClosed,
		};
}

static List<dynamic> getColumnAsList(List<HR_Bonus> lstHR_Bonus, enTable_HR_Bonus enTable)
	{
	if (enTable == enTable_HR_Bonus.ID) {
		return lstHR_Bonus.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Bonus.IDBranch) {
		return lstHR_Bonus.map((col) => col.IDBranch).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Bonus.Code) {
		return lstHR_Bonus.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Bonus.Date) {
		return lstHR_Bonus.map((col) => col.Date).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_HR_Bonus.Time) {
		return lstHR_Bonus.map((col) => col.Time).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_HR_Bonus.IDEmployee) {
		return lstHR_Bonus.map((col) => col.IDEmployee).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Bonus.IDJob) {
		return lstHR_Bonus.map((col) => col.IDJob).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Bonus.IDDepartment) {
		return lstHR_Bonus.map((col) => col.IDDepartment).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Bonus.EmployeeSalaryMonth) {
		return lstHR_Bonus.map((col) => col.EmployeeSalaryMonth).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Bonus.EmployeeSalaryWeek) {
		return lstHR_Bonus.map((col) => col.EmployeeSalaryWeek).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Bonus.EmployeeSalaryDay) {
		return lstHR_Bonus.map((col) => col.EmployeeSalaryDay).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Bonus.EmployeeSalaryHour) {
		return lstHR_Bonus.map((col) => col.EmployeeSalaryHour).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Bonus.BounsType) {
		return lstHR_Bonus.map((col) => col.BounsType).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Bonus.BounsDays) {
		return lstHR_Bonus.map((col) => col.BounsDays).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Bonus.BounsValue) {
		return lstHR_Bonus.map((col) => col.BounsValue).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Bonus.BounsReson) {
		return lstHR_Bonus.map((col) => col.BounsReson).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_HR_Bonus.IDCalcSalary) {
		return lstHR_Bonus.map((col) => col.IDCalcSalary).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Bonus.UID) {
		return lstHR_Bonus.map((col) => col.UID).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_HR_Bonus.IsClosed) {
		return lstHR_Bonus.map((col) => col.IsClosed).toSet().toList() as List<bool>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<HR_Bonus> lstHR_Bonus, enTable_HR_Bonus enTable)
	{
	if (enTable == enTable_HR_Bonus.ID) {
		return lstHR_Bonus.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Bonus.IDBranch) {
		return lstHR_Bonus.map((col) => col.IDBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Bonus.Code) {
		return lstHR_Bonus.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Bonus.Date) {
		return lstHR_Bonus.map((col) => col.Date.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Bonus.Time) {
		return lstHR_Bonus.map((col) => col.Time.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Bonus.IDEmployee) {
		return lstHR_Bonus.map((col) => col.IDEmployee.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Bonus.IDJob) {
		return lstHR_Bonus.map((col) => col.IDJob.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Bonus.IDDepartment) {
		return lstHR_Bonus.map((col) => col.IDDepartment.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Bonus.EmployeeSalaryMonth) {
		return lstHR_Bonus.map((col) => col.EmployeeSalaryMonth.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Bonus.EmployeeSalaryWeek) {
		return lstHR_Bonus.map((col) => col.EmployeeSalaryWeek.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Bonus.EmployeeSalaryDay) {
		return lstHR_Bonus.map((col) => col.EmployeeSalaryDay.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Bonus.EmployeeSalaryHour) {
		return lstHR_Bonus.map((col) => col.EmployeeSalaryHour.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Bonus.BounsType) {
		return lstHR_Bonus.map((col) => col.BounsType.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Bonus.BounsDays) {
		return lstHR_Bonus.map((col) => col.BounsDays.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Bonus.BounsValue) {
		return lstHR_Bonus.map((col) => col.BounsValue.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Bonus.BounsReson) {
		return lstHR_Bonus.map((col) => col.BounsReson.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Bonus.IDCalcSalary) {
		return lstHR_Bonus.map((col) => col.IDCalcSalary.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Bonus.UID) {
		return lstHR_Bonus.map((col) => col.UID.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Bonus.IsClosed) {
		return lstHR_Bonus.map((col) => col.IsClosed.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

