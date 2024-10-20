part of 'dealing_bloc.dart';

@immutable
sealed class dealing_state {}

//*************************** Employee *******************************
final class employee_StateInitial extends dealing_state {}
final class getListEmployee_StateDataChanged extends dealing_state {
  final List<Dealing_Employees> filterdLst_Employee;
  getListEmployee_StateDataChanged({required this.filterdLst_Employee});
}
final class getListEmployeeAsDataSource_StateDataChanged extends dealing_state {
  final List<DropDowenDataSource> filterdLst_EmployeeAsDataSource;
  getListEmployeeAsDataSource_StateDataChanged({required this.filterdLst_EmployeeAsDataSource});
}

//*************************** Client *******************************
final class client_StateInitial extends dealing_state {}
final class getListClient_StateDataChanged extends dealing_state {
  final List<Dealing_Clients> filterdLst_Client;
  getListClient_StateDataChanged({required this.filterdLst_Client});
}
final class getListClientAsDataSource_StateDataChanged extends dealing_state {
  final List<DropDowenDataSource> filterdLst_ClientAsDataSource;
  getListClientAsDataSource_StateDataChanged({required this.filterdLst_ClientAsDataSource});
}

//*************************** Vendor *******************************
final class vendor_StateInitial extends dealing_state {}
final class getListVendor_StateDataChanged extends dealing_state {
  final List<Dealing_Vendors> filterdLst_Vendor;
  getListVendor_StateDataChanged({required this.filterdLst_Vendor});
}
final class getListVendorAsDataSource_StateDataChanged extends dealing_state {
  final List<DropDowenDataSource> filterdLst_VendorAsDataSource;
  getListVendorAsDataSource_StateDataChanged({required this.filterdLst_VendorAsDataSource});
}

//*************************** User *******************************
final class user_StateInitial extends dealing_state {}
final class getListUser_StateDataChanged extends dealing_state {
  final List<Dealing_Users> filterdLst_User;
  getListUser_StateDataChanged({required this.filterdLst_User});
}
final class getListUserAsDataSource_StateDataChanged extends dealing_state {
  final List<DropDowenDataSource > filterdLst_UserAsDataSource;
  getListUserAsDataSource_StateDataChanged({required this.filterdLst_UserAsDataSource});
}

