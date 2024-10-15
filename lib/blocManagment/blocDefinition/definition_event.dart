part of 'definition_bloc.dart';

@immutable
sealed class definition_event {}
class getListCompany_Event extends definition_event {
  List<BLLCondions>? condions  ;
  getListCompany_Event(this.condions);
}
class resetFilterCompany_Event extends definition_event {}
class filterAnyCompany_Event extends definition_event {
  final String? filterData;
  filterAnyCompany_Event({ this.filterData});
}

//*************************** Unit *******************************
class getListUnit_Event extends definition_event {
  List<BLLCondions>? condions  ;
  getListUnit_Event(this.condions);
}
class resetFilterUnit_Event extends definition_event {}
class filterAnyUnit_Event extends definition_event {
  final String? filterData;
  filterAnyUnit_Event({ this.filterData});
}

//*************************** ProductionCom *******************************
class getListProductionCom_Event extends definition_event {
  List<BLLCondions>? condions  ;
  getListProductionCom_Event(this.condions);
}
class resetFilterProductionCom_Event extends definition_event {}
class filterAnyProductionCom_Event extends definition_event {
  final String? filterData;
  filterAnyProductionCom_Event({ this.filterData});
}

//*************************** Categories *******************************
class getListCategories_Event extends definition_event {
  List<BLLCondions>? condions  ;
  getListCategories_Event(this.condions);
}
class resetFilterCategories_Event extends definition_event {}
class filterAnyCategories_Event extends definition_event {
  final String? filterData;
  filterAnyCategories_Event({ this.filterData});
}

//*************************** Jobs *******************************
class getListJobs_Event extends definition_event {
  List<BLLCondions>? condions  ;
  getListJobs_Event(this.condions);
}
class resetFilterJobs_Event extends definition_event {}
class filterAnyJobs_Event extends definition_event {
  final String? filterData;
  filterAnyJobs_Event({ this.filterData});
}

//*************************** FinancialCluses *******************************
class getListFinancialCluses_Event extends definition_event {
  List<BLLCondions>? condions  ;
  getListFinancialCluses_Event(this.condions);
}
class resetFilterFinancialCluses_Event extends definition_event {}
class filterAnyFinancialCluses_Event extends definition_event {
  final String? filterData;
  filterAnyFinancialCluses_Event({ this.filterData});
}

//*************************** sections *******************************
class getListSections_Event extends definition_event {
  List<BLLCondions>? condions  ;
  getListSections_Event(this.condions);
}
class resetFilterSections_Event extends definition_event {}
class filterAnySections_Event extends definition_event {
  final String? filterData;
  filterAnySections_Event({ this.filterData});
}

//*************************** Stock *******************************
class getListStock_Event extends definition_event {
  List<BLLCondions>? condions  ;
  getListStock_Event(this.condions);
}
class resetFilterStock_Event extends definition_event {}
class filterAnyStock_Event extends definition_event {
  final String? filterData;
  filterAnyStock_Event({ this.filterData});
}
class getLstStocksAsDataSource_Event extends definition_event {
  List<BLLCondions>? condions  ;
  int? branchID ;
  getLstStocksAsDataSource_Event({this.branchID  ,this.condions});
}

// class getStocksByBranchID_Event extends definition_event {
//   final int? branchID;
//   getStocksByBranchID_Event({ this.branchID});
// }

//*************************** Treasure *******************************
class getListTreasure_Event extends definition_event {
  List<BLLCondions>? condions  ;
  getListTreasure_Event(this.condions);
}
class resetFilterTreasure_Event extends definition_event {}
class filterAnyTreasure_Event extends definition_event {
  final String? filterData;
  filterAnyTreasure_Event({ this.filterData});
}

//*************************** Product *******************************
class getListProduct_Event extends definition_event {
  List<BLLCondions>? condions  ;
  getListProduct_Event(this.condions);
}
class resetFilterProduct_Event extends definition_event {}
class filterAnyProduct_Event extends definition_event {
  final String? filterData;
  final int? categoryID ;
  filterAnyProduct_Event({ this.filterData , this.categoryID});
}
class refreshProduct_Event extends definition_event {}



