part of 'dealing_bloc.dart';

@immutable
sealed class dealing_state {}

//*************************** Employee *******************************
final class employee_StateInitial extends dealing_state {}
final class getListEmployee_StateDataChanged extends dealing_state {
  final List<Dealing_Employees> filterdLst_Employee;
  getListEmployee_StateDataChanged({required this.filterdLst_Employee});
}

//*************************** Client *******************************
final class client_StateInitial extends dealing_state {}
final class getListClient_StateDataChanged extends dealing_state {
  final List<Dealing_Clients> filterdLst_Client;
  getListClient_StateDataChanged({required this.filterdLst_Client});
}

//*************************** Vendor *******************************
final class vendor_StateInitial extends dealing_state {}
final class getListVendor_StateDataChanged extends dealing_state {
  final List<Dealing_Vendors> filterdLst_Vendor;
  getListVendor_StateDataChanged({required this.filterdLst_Vendor});
}

//*************************** User *******************************
final class user_StateInitial extends dealing_state {}
final class getListUser_StateDataChanged extends dealing_state {
  final List<Dealing_Users> filterdLst_User;
  getListUser_StateDataChanged({required this.filterdLst_User});
}

