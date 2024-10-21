

enum enTable_HR_Advances{ ID, IDBranch, Code, Date, Time, IDEmployee, IDJob, IDDepartment, EmployeeSalaryMonth, EmployeeSalaryWeek, EmployeeSalaryDay, EmployeeSalaryHour, Value, InstallmentValue, InstallmentCount, InstallmentDateStart, Reson, IDCalcSalary, UID, IsClosed }

class HR_Advances
	{
		static List<String> ColumnsName = enTable_HR_Advances.values.map((item) => item.name).toList();

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
 double? InstallmentValue;
 double? InstallmentCount;
 String? InstallmentDateStart;
 String? Reson;
 int? IDCalcSalary;
 String? UID;
 bool? IsClosed;

HR_Advances({
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
 		this.InstallmentValue,
 		this.InstallmentCount,
 		this.InstallmentDateStart,
 		this.Reson,
 		this.IDCalcSalary,
 		this.UID,
 		this.IsClosed,
});


//**************************** general function ****************************

HR_Advances.fromJson(Map<String, dynamic> json) {
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
		 InstallmentValue = json['InstallmentValue'];
		 InstallmentCount = json['InstallmentCount'];
		 InstallmentDateStart = json['InstallmentDateStart'].toString();
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
	 'InstallmentValue' : InstallmentValue,
	 'InstallmentCount' : InstallmentCount,
	 'InstallmentDateStart' : InstallmentDateStart,
	 'Reson' : Reson,
	 'IDCalcSalary' : IDCalcSalary,
	 'UID' : UID,
	 'IsClosed' : IsClosed,
		};
}

static List<dynamic> getColumnAsList(List<HR_Advances> lstHR_Advances, enTable_HR_Advances enTable)
	{
	if (enTable == enTable_HR_Advances.ID) {
		return lstHR_Advances.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Advances.IDBranch) {
		return lstHR_Advances.map((col) => col.IDBranch).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Advances.Code) {
		return lstHR_Advances.map((col) => col.Code).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Advances.Date) {
		return lstHR_Advances.map((col) => col.Date).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_HR_Advances.Time) {
		return lstHR_Advances.map((col) => col.Time).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_HR_Advances.IDEmployee) {
		return lstHR_Advances.map((col) => col.IDEmployee).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Advances.IDJob) {
		return lstHR_Advances.map((col) => col.IDJob).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Advances.IDDepartment) {
		return lstHR_Advances.map((col) => col.IDDepartment).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Advances.EmployeeSalaryMonth) {
		return lstHR_Advances.map((col) => col.EmployeeSalaryMonth).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Advances.EmployeeSalaryWeek) {
		return lstHR_Advances.map((col) => col.EmployeeSalaryWeek).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Advances.EmployeeSalaryDay) {
		return lstHR_Advances.map((col) => col.EmployeeSalaryDay).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Advances.EmployeeSalaryHour) {
		return lstHR_Advances.map((col) => col.EmployeeSalaryHour).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Advances.Value) {
		return lstHR_Advances.map((col) => col.Value).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Advances.InstallmentValue) {
		return lstHR_Advances.map((col) => col.InstallmentValue).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Advances.InstallmentCount) {
		return lstHR_Advances.map((col) => col.InstallmentCount).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_HR_Advances.InstallmentDateStart) {
		return lstHR_Advances.map((col) => col.InstallmentDateStart).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_HR_Advances.Reson) {
		return lstHR_Advances.map((col) => col.Reson).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_HR_Advances.IDCalcSalary) {
		return lstHR_Advances.map((col) => col.IDCalcSalary).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_HR_Advances.UID) {
		return lstHR_Advances.map((col) => col.UID).toSet().toList() as List<String>;
	}
	else if (enTable == enTable_HR_Advances.IsClosed) {
		return lstHR_Advances.map((col) => col.IsClosed).toSet().toList() as List<bool>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<HR_Advances> lstHR_Advances, enTable_HR_Advances enTable)
	{
	if (enTable == enTable_HR_Advances.ID) {
		return lstHR_Advances.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.IDBranch) {
		return lstHR_Advances.map((col) => col.IDBranch.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.Code) {
		return lstHR_Advances.map((col) => col.Code.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.Date) {
		return lstHR_Advances.map((col) => col.Date.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.Time) {
		return lstHR_Advances.map((col) => col.Time.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.IDEmployee) {
		return lstHR_Advances.map((col) => col.IDEmployee.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.IDJob) {
		return lstHR_Advances.map((col) => col.IDJob.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.IDDepartment) {
		return lstHR_Advances.map((col) => col.IDDepartment.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.EmployeeSalaryMonth) {
		return lstHR_Advances.map((col) => col.EmployeeSalaryMonth.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.EmployeeSalaryWeek) {
		return lstHR_Advances.map((col) => col.EmployeeSalaryWeek.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.EmployeeSalaryDay) {
		return lstHR_Advances.map((col) => col.EmployeeSalaryDay.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.EmployeeSalaryHour) {
		return lstHR_Advances.map((col) => col.EmployeeSalaryHour.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.Value) {
		return lstHR_Advances.map((col) => col.Value.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.InstallmentValue) {
		return lstHR_Advances.map((col) => col.InstallmentValue.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.InstallmentCount) {
		return lstHR_Advances.map((col) => col.InstallmentCount.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.InstallmentDateStart) {
		return lstHR_Advances.map((col) => col.InstallmentDateStart.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.Reson) {
		return lstHR_Advances.map((col) => col.Reson.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.IDCalcSalary) {
		return lstHR_Advances.map((col) => col.IDCalcSalary.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.UID) {
		return lstHR_Advances.map((col) => col.UID.toString()).toSet().toList();
	}
	else if (enTable == enTable_HR_Advances.IsClosed) {
		return lstHR_Advances.map((col) => col.IsClosed.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

