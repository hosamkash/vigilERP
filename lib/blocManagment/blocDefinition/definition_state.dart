part of 'definition_bloc.dart';

@immutable
sealed class definition_state {}

final class companyInitial extends definition_state {}
final class getListCompany_StateInitial extends definition_state {}
final class getListCompany_StateDataChanged extends definition_state {
  final List<Def_CompanyStructure> filterdLst_Company;
  getListCompany_StateDataChanged({required this.filterdLst_Company});
}

//*************************** Units *******************************
final class unit_StateInitial extends definition_state {}
final class getListUnit_StateDataChanged extends definition_state {
  final List<Def_Units> filterdLst_Unit;
  getListUnit_StateDataChanged({required this.filterdLst_Unit});
}

//*************************** ProductionComs *******************************
final class productionCom_StateInitial  extends definition_state {}
final class getListProductionCom_StateDataChanged extends definition_state {
  final List<Def_ProductionCompanies> filterdLst_ProductionCom;
  getListProductionCom_StateDataChanged({required this.filterdLst_ProductionCom});
}

//*************************** Categoriess *******************************
final class categories_StateInitial  extends definition_state {}
final class getListCategories_StateDataChanged extends definition_state {
  final List<Def_Categories> filterdLst_Categories;
  getListCategories_StateDataChanged({required this.filterdLst_Categories});
}

//*************************** Jobs *******************************
final class jobs_StateInitial  extends definition_state {}
final class getListJobs_StateDataChanged extends definition_state {
  final List<Def_Jobs> filterdLst_Jobs;
  getListJobs_StateDataChanged({required this.filterdLst_Jobs});
}

//*************************** FinancialCluses *******************************
final class financialCluses_StateInitial  extends definition_state {}
final class getListFinancialCluses_StateDataChanged extends definition_state {
  final List<Def_FinancialCluses> filterdLst_FinancialCluses;
  getListFinancialCluses_StateDataChanged({required this.filterdLst_FinancialCluses});
}

//*************************** Sections *******************************
final class sections_StateInitial  extends definition_state {}
final class getListSections_StateDataChanged extends definition_state {
  final List<Def_Sections> filterdLst_Sections;
  getListSections_StateDataChanged({required this.filterdLst_Sections});
}

//*************************** Stock *******************************
final class stock_StateInitial  extends definition_state {}
final class getListStock_StateDataChanged extends definition_state {
  final List<Def_Stocks> filterdLst_Stock;
  getListStock_StateDataChanged({required this.filterdLst_Stock});
}
final class getLstStocksAsDataSource_State  extends definition_state {
  List<DropDowenDataSource> LstStocksAsDataSource = [];
  getLstStocksAsDataSource_State({required this.LstStocksAsDataSource});
}
// final class getStocksByBranchID_State extends definition_state {
//   final List<DropDowenDataSource> LstStocksFilteredByBranchID;
//   getStocksByBranchID_State({required this.LstStocksFilteredByBranchID});
// }

//*************************** Treasure *******************************
final class treasure_StateInitial  extends definition_state {}
final class getListTreasure_StateDataChanged extends definition_state {
  final List<Def_Treasures> filterdLst_Treasure;
  getListTreasure_StateDataChanged({required this.filterdLst_Treasure});
}

//*************************** Product *******************************
final class product_StateInitial  extends definition_state {}
final class getListProduct_StateDataChanged extends definition_state {
  final List<Def_ProductStructure> filterdLst_Product;
  getListProduct_StateDataChanged({required this.filterdLst_Product});
}

//*************************** requestStatus *******************************
final class requestStatus_StateInitial  extends definition_state {}
final class getListRequestStatus_StateDataChanged extends definition_state {
  final List<Fix_RequestStatus> filterdLst_RequestStatus;
  getListRequestStatus_StateDataChanged({required this.filterdLst_RequestStatus});
}