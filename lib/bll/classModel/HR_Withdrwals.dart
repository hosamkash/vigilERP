

enum enTable_HR_Withdrwals{ ID, IDBranch, Code, Date, Time, IDEmployee, IDJob, IDDepartment, EmployeeSalaryMonth, EmployeeSalaryWeek, EmployeeSalaryDay, EmployeeSalaryHour, Value, Reson, IDCalcSalary, UID, IsClosed }

class HR_Withdrwals
	{
		static List<String> ColumnsName = enTable_HR_Withdrwals.values.map((item) => item.name).toList();

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
 double? Value;
 String? Reson;
 int? IDCalcSalary;
 String? UID;
 bool? IsClosed;

HR_Withdrwals({
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
 		this.Value,
 		this.Reson,
 		this.IDCalcSalary,
 		this.UID,
 		this.IsClosed,
});


//**************************** general function ****************************

HR_Withdrwals.fromJson(Map<String, dynamic> json) {
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
		 Value = json['Value'];
		 Reson = json['Reson'].toString();
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
	 'Value' : Value,
	 'Reson' : Reson,
	 'IDCalcSalary' : IDCalcSalary,
	 'UID' : UID,
	 'IsClosed' : IsClosed,
		};
}

static List<dynamic> getColumnAsList(List<HR_Withdrwals> lstHR_Withdrwals, enTable_HR_Withdrwals enTable)
	{
	if (enTable == enTable_HR_Withdrwals.ID) {
		return lstHR_Withdrwals.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Withdrwals.IDBranch) {
		return lstHR_Withdrwals.map((col) => col.IDBranch).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Withdrwals.Code) {
		return lstHR_Withdrwals.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Withdrwals.Date) {
		return lstHR_Withdrwals.map((col) => col.Date).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_HR_Withdrwals.Time) {
		return lstHR_Withdrwals.map((col) => col.Time).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_HR_Withdrwals.IDEmployee) {
		return lstHR_Withdrwals.map((col) => col.IDEmployee).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Withdrwals.IDJob) {
		return lstHR_Withdrwals.map((col) => col.IDJob).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Withdrwals.IDDepartment) {
		return lstHR_Withdrwals.map((col) => col.IDDepartment).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Withdrwals.EmployeeSalaryMonth) {
		return lstHR_Withdrwals.map((col) => col.EmployeeSalaryMonth).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Withdrwals.EmployeeSalaryWeek) {
		return lstHR_Withdrwals.map((col) => col.EmployeeSalaryWeek).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Withdrwals.EmployeeSalaryDay) {
		return lstHR_Withdrwals.map((col) => col.EmployeeSalaryDay).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Withdrwals.EmployeeSalaryHour) {
		return lstHR_Withdrwals.map((col) => col.EmployeeSalaryHour).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Withdrwals.Value) {
		return lstHR_Withdrwals.map((col) => col.Value).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Withdrwals.Reson) {
		return lstHR_Withdrwals.map((col) => col.Reson).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_HR_Withdrwals.IDCalcSalary) {
		return lstHR_Withdrwals.map((col) => col.IDCalcSalary).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Withdrwals.UID) {
		return lstHR_Withdrwals.map((col) => col.UID).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_HR_Withdrwals.IsClosed) {
		return lstHR_Withdrwals.map((col) => col.IsClosed).toSet().toList() as List<bool>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<HR_Withdrwals> lstHR_Withdrwals, enTable_HR_Withdrwals enTable)
	{
	if (enTable == enTable_HR_Withdrwals.ID) {
		return lstHR_Withdrwals.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Withdrwals.IDBranch) {
		return lstHR_Withdrwals.map((col) => col.IDBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Withdrwals.Code) {
		return lstHR_Withdrwals.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Withdrwals.Date) {
		return lstHR_Withdrwals.map((col) => col.Date.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Withdrwals.Time) {
		return lstHR_Withdrwals.map((col) => col.Time.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Withdrwals.IDEmployee) {
		return lstHR_Withdrwals.map((col) => col.IDEmployee.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Withdrwals.IDJob) {
		return lstHR_Withdrwals.map((col) => col.IDJob.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Withdrwals.IDDepartment) {
		return lstHR_Withdrwals.map((col) => col.IDDepartment.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Withdrwals.EmployeeSalaryMonth) {
		return lstHR_Withdrwals.map((col) => col.EmployeeSalaryMonth.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Withdrwals.EmployeeSalaryWeek) {
		return lstHR_Withdrwals.map((col) => col.EmployeeSalaryWeek.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Withdrwals.EmployeeSalaryDay) {
		return lstHR_Withdrwals.map((col) => col.EmployeeSalaryDay.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Withdrwals.EmployeeSalaryHour) {
		return lstHR_Withdrwals.map((col) => col.EmployeeSalaryHour.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Withdrwals.Value) {
		return lstHR_Withdrwals.map((col) => col.Value.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Withdrwals.Reson) {
		return lstHR_Withdrwals.map((col) => col.Reson.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Withdrwals.IDCalcSalary) {
		return lstHR_Withdrwals.map((col) => col.IDCalcSalary.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Withdrwals.UID) {
		return lstHR_Withdrwals.map((col) => col.UID.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Withdrwals.IsClosed) {
		return lstHR_Withdrwals.map((col) => col.IsClosed.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

