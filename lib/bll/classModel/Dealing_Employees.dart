enum enTable_Dealing_Employees {
  ID,
  IDBranch,
  Code,
  Name,
  IsActive,
  Phone,
  Mobile,
  Address,
  NationalID,
  BirthDate,
  Age,
  IDMaritalStatus,
  ChildrenCount,
  IDReligions,
  IDGender,
  IDMilitaryStatus,
  Qualification,
  IDJob,
  IDDepartment,
  DateHiring,
  TimeWorkFrom,
  TimeWorkTo,
  TimeTotalWorkHour,
  MonthlyVacationDays,
  ExpiryDateJob,
  LeavingReson,
  SalaryMonthValue,
  SalaryWeekValue,
  SalaryDayValue,
  SalaryHourValue,
  MonthlyTarget,
  MonthlyCommissionExecute,
  MonthlyCommissionNotExecute,
  DailyTarget,
  DailyCommissionExecute,
  DailyCommissionNotExecute,
  CommissionSales1,
  CommissionSalesReturned1,
  CommissionSales2,
  CommissionSalesReturned2,
  CommissionSales3,
  CommissionSalesReturned3,
  CommissionSales4,
  CommissionSalesReturned4,
  CommissionSales5,
  CommissionSalesReturned5,
  RelativeName1,
  RelativeMobile1,
  RelativeType1,
  RelativeName2,
  RelativeMobile2,
  RelativeType2,
  RelativeName3,
  RelativeMobile3,
  RelativeType3,
  RelativeName4,
  RelativeMobile4,
  RelativeType4,
  ImageName,
  ImageURL
}

class Dealing_Employees {
  static List<String> ColumnsName = enTable_Dealing_Employees.values.map((item) => item.name).toList();

  int? ID;
  int? IDBranch;
  int? Code;
  String? Name;
  bool? IsActive;
  String? Phone;
  String? Mobile;
  String? Address;
  String? NationalID;
  String? BirthDate;
  double? Age;
  int? IDMaritalStatus;
  int? ChildrenCount;
  int? IDReligions;
  int? IDGender;
  int? IDMilitaryStatus;
  String? Qualification;
  int? IDJob;
  int? IDDepartment;
  String? DateHiring;
  String? TimeWorkFrom;
  String? TimeWorkTo;
  double? TimeTotalWorkHour;
  int? MonthlyVacationDays;
  String? ExpiryDateJob;
  String? LeavingReson;
  double? SalaryMonthValue;
  double? SalaryWeekValue;
  double? SalaryDayValue;
  double? SalaryHourValue;
  double? MonthlyTarget;
  double? MonthlyCommissionExecute;
  double? MonthlyCommissionNotExecute;
  double? DailyTarget;
  double? DailyCommissionExecute;
  double? DailyCommissionNotExecute;
  double? CommissionSales1;
  double? CommissionSalesReturned1;
  double? CommissionSales2;
  double? CommissionSalesReturned2;
  double? CommissionSales3;
  double? CommissionSalesReturned3;
  double? CommissionSales4;
  double? CommissionSalesReturned4;
  double? CommissionSales5;
  double? CommissionSalesReturned5;
  String? RelativeName1;
  String? RelativeMobile1;
  String? RelativeType1;
  String? RelativeName2;
  String? RelativeMobile2;
  String? RelativeType2;
  String? RelativeName3;
  String? RelativeMobile3;
  String? RelativeType3;
  String? RelativeName4;
  String? RelativeMobile4;
  String? RelativeType4;
  String? ImageName;
  String? ImageURL;

  Dealing_Employees({
    this.ID,
    this.IDBranch,
    this.Code,
    this.Name,
    this.IsActive,
    this.Phone,
    this.Mobile,
    this.Address,
    this.NationalID,
    this.BirthDate,
    this.Age,
    this.IDMaritalStatus,
    this.ChildrenCount,
    this.IDReligions,
    this.IDGender,
    this.IDMilitaryStatus,
    this.Qualification,
    this.IDJob,
    this.IDDepartment,
    this.DateHiring,
    this.TimeWorkFrom,
    this.TimeWorkTo,
    this.TimeTotalWorkHour,
    this.MonthlyVacationDays,
    this.ExpiryDateJob,
    this.LeavingReson,
    this.SalaryMonthValue,
    this.SalaryWeekValue,
    this.SalaryDayValue,
    this.SalaryHourValue,
    this.MonthlyTarget,
    this.MonthlyCommissionExecute,
    this.MonthlyCommissionNotExecute,
    this.DailyTarget,
    this.DailyCommissionExecute,
    this.DailyCommissionNotExecute,
    this.CommissionSales1,
    this.CommissionSalesReturned1,
    this.CommissionSales2,
    this.CommissionSalesReturned2,
    this.CommissionSales3,
    this.CommissionSalesReturned3,
    this.CommissionSales4,
    this.CommissionSalesReturned4,
    this.CommissionSales5,
    this.CommissionSalesReturned5,
    this.RelativeName1,
    this.RelativeMobile1,
    this.RelativeType1,
    this.RelativeName2,
    this.RelativeMobile2,
    this.RelativeType2,
    this.RelativeName3,
    this.RelativeMobile3,
    this.RelativeType3,
    this.RelativeName4,
    this.RelativeMobile4,
    this.RelativeType4,
    this.ImageName,
    this.ImageURL,
  });

//**************************** general function ****************************

  Dealing_Employees.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    IDBranch = json['IDBranch'];
    Code = json['Code'];
    Name = json['Name'].toString();
    IsActive = json['IsActive'];
    Phone = json['Phone'].toString();
    Mobile = json['Mobile'].toString();
    Address = json['Address'].toString();
    NationalID = json['NationalID'].toString();
    BirthDate = json['BirthDate'].toString();
    Age = json['Age'];
    IDMaritalStatus = json['IDMaritalStatus'];
    ChildrenCount = json['ChildrenCount'];
    IDReligions = json['IDReligions'];
    IDGender = json['IDGender'];
    IDMilitaryStatus = json['IDMilitaryStatus'];
    Qualification = json['Qualification'].toString();
    IDJob = json['IDJob'];
    IDDepartment = json['IDDepartment'];
    DateHiring = json['DateHiring'].toString();
    TimeWorkFrom = json['TimeWorkFrom'].toString();
    TimeWorkTo = json['TimeWorkTo'].toString();
    TimeTotalWorkHour = json['TimeTotalWorkHour'];
    MonthlyVacationDays = json['MonthlyVacationDays'];
    ExpiryDateJob = json['ExpiryDateJob'].toString();
    LeavingReson = json['LeavingReson'].toString();
    SalaryMonthValue = json['SalaryMonthValue'];
    SalaryWeekValue = json['SalaryWeekValue'];
    SalaryDayValue = json['SalaryDayValue'];
    SalaryHourValue = json['SalaryHourValue'];
    MonthlyTarget = json['MonthlyTarget'];
    MonthlyCommissionExecute = json['MonthlyCommissionExecute'];
    MonthlyCommissionNotExecute = json['MonthlyCommissionNotExecute'];
    DailyTarget = json['DailyTarget'];
    DailyCommissionExecute = json['DailyCommissionExecute'];
    DailyCommissionNotExecute = json['DailyCommissionNotExecute'];
    CommissionSales1 = json['CommissionSales1'];
    CommissionSalesReturned1 = json['CommissionSalesReturned1'];
    CommissionSales2 = json['CommissionSales2'];
    CommissionSalesReturned2 = json['CommissionSalesReturned2'];
    CommissionSales3 = json['CommissionSales3'];
    CommissionSalesReturned3 = json['CommissionSalesReturned3'];
    CommissionSales4 = json['CommissionSales4'];
    CommissionSalesReturned4 = json['CommissionSalesReturned4'];
    CommissionSales5 = json['CommissionSales5'];
    CommissionSalesReturned5 = json['CommissionSalesReturned5'];
    RelativeName1 = json['RelativeName1'].toString();
    RelativeMobile1 = json['RelativeMobile1'].toString();
    RelativeType1 = json['RelativeType1'].toString();
    RelativeName2 = json['RelativeName2'].toString();
    RelativeMobile2 = json['RelativeMobile2'].toString();
    RelativeType2 = json['RelativeType2'].toString();
    RelativeName3 = json['RelativeName3'].toString();
    RelativeMobile3 = json['RelativeMobile3'].toString();
    RelativeType3 = json['RelativeType3'].toString();
    RelativeName4 = json['RelativeName4'].toString();
    RelativeMobile4 = json['RelativeMobile4'].toString();
    RelativeType4 = json['RelativeType4'].toString();
    ImageName = json['ImageName'].toString();
    ImageURL = json['ImageURL'].toString();
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'IDBranch': IDBranch,
      'Code': Code,
      'Name': Name,
      'IsActive': IsActive,
      'Phone': Phone,
      'Mobile': Mobile,
      'Address': Address,
      'NationalID': NationalID,
      'BirthDate': BirthDate,
      'Age': Age,
      'IDMaritalStatus': IDMaritalStatus,
      'ChildrenCount': ChildrenCount,
      'IDReligions': IDReligions,
      'IDGender': IDGender,
      'IDMilitaryStatus': IDMilitaryStatus,
      'Qualification': Qualification,
      'IDJob': IDJob,
      'IDDepartment': IDDepartment,
      'DateHiring': DateHiring,
      'TimeWorkFrom': TimeWorkFrom,
      'TimeWorkTo': TimeWorkTo,
      'TimeTotalWorkHour': TimeTotalWorkHour,
      'MonthlyVacationDays': MonthlyVacationDays,
      'ExpiryDateJob': ExpiryDateJob,
      'LeavingReson': LeavingReson,
      'SalaryMonthValue': SalaryMonthValue,
      'SalaryWeekValue': SalaryWeekValue,
      'SalaryDayValue': SalaryDayValue,
      'SalaryHourValue': SalaryHourValue,
      'MonthlyTarget': MonthlyTarget,
      'MonthlyCommissionExecute': MonthlyCommissionExecute,
      'MonthlyCommissionNotExecute': MonthlyCommissionNotExecute,
      'DailyTarget': DailyTarget,
      'DailyCommissionExecute': DailyCommissionExecute,
      'DailyCommissionNotExecute': DailyCommissionNotExecute,
      'CommissionSales1': CommissionSales1,
      'CommissionSalesReturned1': CommissionSalesReturned1,
      'CommissionSales2': CommissionSales2,
      'CommissionSalesReturned2': CommissionSalesReturned2,
      'CommissionSales3': CommissionSales3,
      'CommissionSalesReturned3': CommissionSalesReturned3,
      'CommissionSales4': CommissionSales4,
      'CommissionSalesReturned4': CommissionSalesReturned4,
      'CommissionSales5': CommissionSales5,
      'CommissionSalesReturned5': CommissionSalesReturned5,
      'RelativeName1': RelativeName1,
      'RelativeMobile1': RelativeMobile1,
      'RelativeType1': RelativeType1,
      'RelativeName2': RelativeName2,
      'RelativeMobile2': RelativeMobile2,
      'RelativeType2': RelativeType2,
      'RelativeName3': RelativeName3,
      'RelativeMobile3': RelativeMobile3,
      'RelativeType3': RelativeType3,
      'RelativeName4': RelativeName4,
      'RelativeMobile4': RelativeMobile4,
      'RelativeType4': RelativeType4,
      'ImageName': ImageName,
      'ImageURL': ImageURL,
    };
  }

  static List<dynamic> getColumnAsList(List<Dealing_Employees> lstDealing_Employees, enTable_Dealing_Employees enTable) {
    if (enTable == enTable_Dealing_Employees.ID) {
      return lstDealing_Employees.map((col) => col.ID).toSet().toList() as List<int>;
    } else if (enTable == enTable_Dealing_Employees.IDBranch) {
      return lstDealing_Employees.map((col) => col.IDBranch).toSet().toList() as List<int>;
    } else if (enTable == enTable_Dealing_Employees.Code) {
      return lstDealing_Employees.map((col) => col.Code).toSet().toList() as List<int>;
    } else if (enTable == enTable_Dealing_Employees.Name) {
      return lstDealing_Employees.map((col) => col.Name).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.IsActive) {
      return lstDealing_Employees.map((col) => col.IsActive).toSet().toList() as List<bool>;
    } else if (enTable == enTable_Dealing_Employees.Phone) {
      return lstDealing_Employees.map((col) => col.Phone).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.Mobile) {
      return lstDealing_Employees.map((col) => col.Mobile).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.Address) {
      return lstDealing_Employees.map((col) => col.Address).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.NationalID) {
      return lstDealing_Employees.map((col) => col.NationalID).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.BirthDate) {
      return lstDealing_Employees.map((col) => col.BirthDate).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.Age) {
      return lstDealing_Employees.map((col) => col.Age).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.IDMaritalStatus) {
      return lstDealing_Employees.map((col) => col.IDMaritalStatus).toSet().toList() as List<int>;
    } else if (enTable == enTable_Dealing_Employees.ChildrenCount) {
      return lstDealing_Employees.map((col) => col.ChildrenCount).toSet().toList() as List<int>;
    } else if (enTable == enTable_Dealing_Employees.IDReligions) {
      return lstDealing_Employees.map((col) => col.IDReligions).toSet().toList() as List<int>;
    } else if (enTable == enTable_Dealing_Employees.IDGender) {
      return lstDealing_Employees.map((col) => col.IDGender).toSet().toList() as List<int>;
    } else if (enTable == enTable_Dealing_Employees.IDMilitaryStatus) {
      return lstDealing_Employees.map((col) => col.IDMilitaryStatus).toSet().toList() as List<int>;
    } else if (enTable == enTable_Dealing_Employees.Qualification) {
      return lstDealing_Employees.map((col) => col.Qualification).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.IDJob) {
      return lstDealing_Employees.map((col) => col.IDJob).toSet().toList() as List<int>;
    } else if (enTable == enTable_Dealing_Employees.IDDepartment) {
      return lstDealing_Employees.map((col) => col.IDDepartment).toSet().toList() as List<int>;
    } else if (enTable == enTable_Dealing_Employees.DateHiring) {
      return lstDealing_Employees.map((col) => col.DateHiring).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.TimeWorkFrom) {
      return lstDealing_Employees.map((col) => col.TimeWorkFrom).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.TimeWorkTo) {
      return lstDealing_Employees.map((col) => col.TimeWorkTo).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.TimeTotalWorkHour) {
      return lstDealing_Employees.map((col) => col.TimeTotalWorkHour).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.MonthlyVacationDays) {
      return lstDealing_Employees.map((col) => col.MonthlyVacationDays).toSet().toList() as List<int>;
    } else if (enTable == enTable_Dealing_Employees.ExpiryDateJob) {
      return lstDealing_Employees.map((col) => col.ExpiryDateJob).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.LeavingReson) {
      return lstDealing_Employees.map((col) => col.LeavingReson).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.SalaryMonthValue) {
      return lstDealing_Employees.map((col) => col.SalaryMonthValue).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.SalaryWeekValue) {
      return lstDealing_Employees.map((col) => col.SalaryWeekValue).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.SalaryDayValue) {
      return lstDealing_Employees.map((col) => col.SalaryDayValue).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.SalaryHourValue) {
      return lstDealing_Employees.map((col) => col.SalaryHourValue).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.MonthlyTarget) {
      return lstDealing_Employees.map((col) => col.MonthlyTarget).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.MonthlyCommissionExecute) {
      return lstDealing_Employees.map((col) => col.MonthlyCommissionExecute).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.MonthlyCommissionNotExecute) {
      return lstDealing_Employees.map((col) => col.MonthlyCommissionNotExecute).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.DailyTarget) {
      return lstDealing_Employees.map((col) => col.DailyTarget).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.DailyCommissionExecute) {
      return lstDealing_Employees.map((col) => col.DailyCommissionExecute).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.DailyCommissionNotExecute) {
      return lstDealing_Employees.map((col) => col.DailyCommissionNotExecute).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.CommissionSales1) {
      return lstDealing_Employees.map((col) => col.CommissionSales1).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.CommissionSalesReturned1) {
      return lstDealing_Employees.map((col) => col.CommissionSalesReturned1).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.CommissionSales2) {
      return lstDealing_Employees.map((col) => col.CommissionSales2).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.CommissionSalesReturned2) {
      return lstDealing_Employees.map((col) => col.CommissionSalesReturned2).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.CommissionSales3) {
      return lstDealing_Employees.map((col) => col.CommissionSales3).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.CommissionSalesReturned3) {
      return lstDealing_Employees.map((col) => col.CommissionSalesReturned3).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.CommissionSales4) {
      return lstDealing_Employees.map((col) => col.CommissionSales4).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.CommissionSalesReturned4) {
      return lstDealing_Employees.map((col) => col.CommissionSalesReturned4).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.CommissionSales5) {
      return lstDealing_Employees.map((col) => col.CommissionSales5).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.CommissionSalesReturned5) {
      return lstDealing_Employees.map((col) => col.CommissionSalesReturned5).toSet().toList() as List<double>;
    } else if (enTable == enTable_Dealing_Employees.RelativeName1) {
      return lstDealing_Employees.map((col) => col.RelativeName1).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.RelativeMobile1) {
      return lstDealing_Employees.map((col) => col.RelativeMobile1).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.RelativeType1) {
      return lstDealing_Employees.map((col) => col.RelativeType1).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.RelativeName2) {
      return lstDealing_Employees.map((col) => col.RelativeName2).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.RelativeMobile2) {
      return lstDealing_Employees.map((col) => col.RelativeMobile2).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.RelativeType2) {
      return lstDealing_Employees.map((col) => col.RelativeType2).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.RelativeName3) {
      return lstDealing_Employees.map((col) => col.RelativeName3).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.RelativeMobile3) {
      return lstDealing_Employees.map((col) => col.RelativeMobile3).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.RelativeType3) {
      return lstDealing_Employees.map((col) => col.RelativeType3).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.RelativeName4) {
      return lstDealing_Employees.map((col) => col.RelativeName4).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.RelativeMobile4) {
      return lstDealing_Employees.map((col) => col.RelativeMobile4).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.RelativeType4) {
      return lstDealing_Employees.map((col) => col.RelativeType4).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.ImageName) {
      return lstDealing_Employees.map((col) => col.ImageName).toSet().toList() as List<String>;
    } else if (enTable == enTable_Dealing_Employees.ImageURL) {
      return lstDealing_Employees.map((col) => col.ImageURL).toSet().toList() as List<String>;
    } else {
      return Null as List<dynamic>;
    }
  }

  static List<String> getColumnAsListString(List<Dealing_Employees> lstDealing_Employees, enTable_Dealing_Employees enTable) {
    if (enTable == enTable_Dealing_Employees.ID) {
      return lstDealing_Employees.map((col) => col.ID.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.IDBranch) {
      return lstDealing_Employees.map((col) => col.IDBranch.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.Code) {
      return lstDealing_Employees.map((col) => col.Code.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.Name) {
      return lstDealing_Employees.map((col) => col.Name.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.IsActive) {
      return lstDealing_Employees.map((col) => col.IsActive.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.Phone) {
      return lstDealing_Employees.map((col) => col.Phone.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.Mobile) {
      return lstDealing_Employees.map((col) => col.Mobile.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.Address) {
      return lstDealing_Employees.map((col) => col.Address.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.NationalID) {
      return lstDealing_Employees.map((col) => col.NationalID.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.BirthDate) {
      return lstDealing_Employees.map((col) => col.BirthDate.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.Age) {
      return lstDealing_Employees.map((col) => col.Age.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.IDMaritalStatus) {
      return lstDealing_Employees.map((col) => col.IDMaritalStatus.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.ChildrenCount) {
      return lstDealing_Employees.map((col) => col.ChildrenCount.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.IDReligions) {
      return lstDealing_Employees.map((col) => col.IDReligions.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.IDGender) {
      return lstDealing_Employees.map((col) => col.IDGender.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.IDMilitaryStatus) {
      return lstDealing_Employees.map((col) => col.IDMilitaryStatus.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.Qualification) {
      return lstDealing_Employees.map((col) => col.Qualification.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.IDJob) {
      return lstDealing_Employees.map((col) => col.IDJob.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.IDDepartment) {
      return lstDealing_Employees.map((col) => col.IDDepartment.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.DateHiring) {
      return lstDealing_Employees.map((col) => col.DateHiring.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.TimeWorkFrom) {
      return lstDealing_Employees.map((col) => col.TimeWorkFrom.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.TimeWorkTo) {
      return lstDealing_Employees.map((col) => col.TimeWorkTo.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.TimeTotalWorkHour) {
      return lstDealing_Employees.map((col) => col.TimeTotalWorkHour.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.MonthlyVacationDays) {
      return lstDealing_Employees.map((col) => col.MonthlyVacationDays.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.ExpiryDateJob) {
      return lstDealing_Employees.map((col) => col.ExpiryDateJob.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.LeavingReson) {
      return lstDealing_Employees.map((col) => col.LeavingReson.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.SalaryMonthValue) {
      return lstDealing_Employees.map((col) => col.SalaryMonthValue.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.SalaryWeekValue) {
      return lstDealing_Employees.map((col) => col.SalaryWeekValue.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.SalaryDayValue) {
      return lstDealing_Employees.map((col) => col.SalaryDayValue.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.SalaryHourValue) {
      return lstDealing_Employees.map((col) => col.SalaryHourValue.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.MonthlyTarget) {
      return lstDealing_Employees.map((col) => col.MonthlyTarget.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.MonthlyCommissionExecute) {
      return lstDealing_Employees.map((col) => col.MonthlyCommissionExecute.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.MonthlyCommissionNotExecute) {
      return lstDealing_Employees.map((col) => col.MonthlyCommissionNotExecute.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.DailyTarget) {
      return lstDealing_Employees.map((col) => col.DailyTarget.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.DailyCommissionExecute) {
      return lstDealing_Employees.map((col) => col.DailyCommissionExecute.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.DailyCommissionNotExecute) {
      return lstDealing_Employees.map((col) => col.DailyCommissionNotExecute.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.CommissionSales1) {
      return lstDealing_Employees.map((col) => col.CommissionSales1.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.CommissionSalesReturned1) {
      return lstDealing_Employees.map((col) => col.CommissionSalesReturned1.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.CommissionSales2) {
      return lstDealing_Employees.map((col) => col.CommissionSales2.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.CommissionSalesReturned2) {
      return lstDealing_Employees.map((col) => col.CommissionSalesReturned2.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.CommissionSales3) {
      return lstDealing_Employees.map((col) => col.CommissionSales3.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.CommissionSalesReturned3) {
      return lstDealing_Employees.map((col) => col.CommissionSalesReturned3.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.CommissionSales4) {
      return lstDealing_Employees.map((col) => col.CommissionSales4.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.CommissionSalesReturned4) {
      return lstDealing_Employees.map((col) => col.CommissionSalesReturned4.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.CommissionSales5) {
      return lstDealing_Employees.map((col) => col.CommissionSales5.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.CommissionSalesReturned5) {
      return lstDealing_Employees.map((col) => col.CommissionSalesReturned5.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.RelativeName1) {
      return lstDealing_Employees.map((col) => col.RelativeName1.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.RelativeMobile1) {
      return lstDealing_Employees.map((col) => col.RelativeMobile1.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.RelativeType1) {
      return lstDealing_Employees.map((col) => col.RelativeType1.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.RelativeName2) {
      return lstDealing_Employees.map((col) => col.RelativeName2.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.RelativeMobile2) {
      return lstDealing_Employees.map((col) => col.RelativeMobile2.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.RelativeType2) {
      return lstDealing_Employees.map((col) => col.RelativeType2.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.RelativeName3) {
      return lstDealing_Employees.map((col) => col.RelativeName3.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.RelativeMobile3) {
      return lstDealing_Employees.map((col) => col.RelativeMobile3.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.RelativeType3) {
      return lstDealing_Employees.map((col) => col.RelativeType3.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.RelativeName4) {
      return lstDealing_Employees.map((col) => col.RelativeName4.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.RelativeMobile4) {
      return lstDealing_Employees.map((col) => col.RelativeMobile4.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.RelativeType4) {
      return lstDealing_Employees.map((col) => col.RelativeType4.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.ImageName) {
      return lstDealing_Employees.map((col) => col.ImageName.toString()).toSet().toList();
    } else if (enTable == enTable_Dealing_Employees.ImageURL) {
      return lstDealing_Employees.map((col) => col.ImageURL.toString()).toSet().toList();
    } else {
      return '' as List<String>;
    }
  }
}
