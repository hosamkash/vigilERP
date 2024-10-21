import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../bll/bllFirebase/ManageBLL.dart';
import '../../bll/bllFirebase/bllDef_Categories.dart';
import '../../bll/bllFirebase/bllDef_CompanyStructure.dart';
import '../../bll/bllFirebase/bllDef_FinancialCluses.dart';
import '../../bll/bllFirebase/bllDef_Jobs.dart';
import '../../bll/bllFirebase/bllDef_ProductStructure.dart';
import '../../bll/bllFirebase/bllDef_ProductionCompanies.dart';
import '../../bll/bllFirebase/bllDef_Sections.dart';
import '../../bll/bllFirebase/bllDef_Stocks.dart';
import '../../bll/bllFirebase/bllDef_Treasures.dart';
import '../../bll/bllFirebase/bllDef_Units.dart';
import '../../bll/bllFirebase/bllFix_FinacialType.dart';
import '../../bll/classModel/Def_Categories.dart';
import '../../bll/classModel/Def_CompanyStructure.dart';
import '../../bll/classModel/Def_FinancialCluses.dart';
import '../../bll/classModel/Def_Jobs.dart';
import '../../bll/classModel/Def_ProductStructure.dart';
import '../../bll/classModel/Def_ProductionCompanies.dart';
import '../../bll/classModel/Def_Sections.dart';
import '../../bll/classModel/Def_Stocks.dart';
import '../../bll/classModel/Def_Treasures.dart';
import '../../bll/classModel/Def_Units.dart';
import '../../bll/classModel/Fix_RequestStatus.dart';
import '../../componants/ctr_DropDowenList.dart';
import '../../managment/manage_Images.dart';
import '../../shared/enumerators.dart';

part 'definition_event.dart';

part 'definition_state.dart';

class company_bloc extends Bloc<definition_event, definition_state> {
  // ***************************** General *********************************
  static late company_bloc instance;

  static company_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<company_bloc>(context);
    return instance;
  }

  //  ===============================================================================
  List<Def_CompanyStructure> filterdLst_Company = [];
  List<DropDowenDataSource> LstBranchesAsDataSource = [];

  Future getList_Company({List<BLLCondions>? condions}) async {
    try {
      resetFilter_Company();
      await bllDef_CompanyStructure.fire_getListWithConditions(conditions: condions).then((val) {
        filterdLst_Company = val;
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future getLstBranchesAsDataSource({List<BLLCondions>? condions}) async {
    LstBranchesAsDataSource.clear();
    if (bllDef_CompanyStructure.lstDef_CompanyStructure.length == 0) {
      await getList_Company(condions: condions);
    }
    for (var item in bllDef_CompanyStructure.lstDef_CompanyStructure) {
      LstBranchesAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? CompanyID) {
    String ret = '';
    if (bllDef_CompanyStructure.lstDef_CompanyStructure.isNotEmpty && CompanyID != null) {
      ret = bllDef_CompanyStructure.lstDef_CompanyStructure.firstWhere((elm) {
        return elm.ID == CompanyID;
      }).Name!;
    }
    return ret;
  }

  resetFilter_Company() {
    filterdLst_Company.clear();
    filterdLst_Company = bllDef_CompanyStructure.lstDef_CompanyStructure;
  }

  filterAny_Company({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_Company();
    }
    filterdLst_Company = await bllDef_CompanyStructure.lstDef_CompanyStructure.where((item) {
      return (item.Code == null ? false : item.Code!.toString().contains(filterData!)) ||
          (item.Name == null ? false : item.Name!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.DateCreate == null ? false : item.DateCreate!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Adress == null ? false : item.Adress!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Phone == null ? false : item.Phone!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Mobile == null ? false : item.Mobile!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Logo == null ? false : item.Logo!.toLowerCase().contains(filterData!.toLowerCase()));
    }).toList();
  }

  company_bloc() : super(companyInitial()) {
    on<definition_event>((event, emit) async {
      if (event is getListCompany_Event) {
        await getList_Company();
        await getLstBranchesAsDataSource();
        emit(getListCompany_StateDataChanged(filterdLst_Company: filterdLst_Company));
      } else if (event is resetFilterCompany_Event) {
        await resetFilter_Company();
        emit(getListCompany_StateDataChanged(filterdLst_Company: filterdLst_Company));
      } else if (event is filterAnyCompany_Event) {
        await filterAny_Company(filterData: event.filterData);
        emit(getListCompany_StateDataChanged(filterdLst_Company: filterdLst_Company));
      }
    });
  }
}

class unit_bloc extends Bloc<definition_event, definition_state> {
  static late unit_bloc instance;

  static unit_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<unit_bloc>(context);
    return instance;
  }

  List<Def_Units> filterdLst_Unit = [];
  List<DropDowenDataSource> LstUnitsAsDataSource = [];

  Future getLstUnitsAsDataSource({List<BLLCondions>? condions}) async {
    LstUnitsAsDataSource.clear();
    if (bllDef_Units.lstDef_Units.length == 0) {
      await getList_Units(condions: condions);
    }
    for (var item in bllDef_Units.lstDef_Units) {
      LstUnitsAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? UnitID) {
    String ret = '';
    if (bllDef_Units.lstDef_Units.isNotEmpty && UnitID != null) {
      ret = bllDef_Units.lstDef_Units.firstWhere((elm) {
        return elm.ID == UnitID;
      }).Name!;
    }
    return ret;
  }

  Future getList_Units({List<BLLCondions>? condions}) async {
    try {
      resetFilter_Units();
      await bllDef_Units.fire_getListWithConditions(conditions: condions).then((val) {
        filterdLst_Unit = val;
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future resetFilter_Units() async {
    filterdLst_Unit.clear();
    filterdLst_Unit = await bllDef_Units.lstDef_Units;
  }

  Future filterAny_Units({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_Units();
    }
    filterdLst_Unit = await bllDef_Units.lstDef_Units.where((item) {
      return (item.Name == null ? false : item.Name!.toLowerCase().contains(filterData!.toLowerCase()));
    }).toList();
  }

  unit_bloc() : super(unit_StateInitial()) {
    on<definition_event>((event, emit) async {
      if (event is getListUnit_Event) {
        await getList_Units();
        emit(getListUnit_StateDataChanged(filterdLst_Unit: filterdLst_Unit));
      } else if (event is filterAnyUnit_Event) {
        await filterAny_Units(filterData: event.filterData);
        emit(getListUnit_StateDataChanged(filterdLst_Unit: filterdLst_Unit));
      } else if (event is resetFilterUnit_Event) {
        await resetFilter_Units();
        emit(getListUnit_StateDataChanged(filterdLst_Unit: filterdLst_Unit));
      }
    });
  }
}

class productionCom_bloc extends Bloc<definition_event, definition_state> {
  static late productionCom_bloc instance;

  static productionCom_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<productionCom_bloc>(context);
    return instance;
  }

  List<Def_ProductionCompanies> filterdLst_ProductionCom = [];
  List<DropDowenDataSource> LstProductionComAsDataSource = [];

  Future getList_ProductionCom({List<BLLCondions>? condions}) async {
    try {
      resetFilter_ProductionCom();
      await bllDef_ProductionCompanies.fire_getListWithConditions(conditions: condions).then((val) {
        filterdLst_ProductionCom = val;
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Future filterAny_ProductionCom({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_ProductionCom();
    }
    filterdLst_ProductionCom = await bllDef_ProductionCompanies.lstDef_ProductionCompanies.where((item) {
      return (item.Name == null ? false : item.Name!.toLowerCase().contains(filterData!.toLowerCase()));
    }).toList();
  }

  Future resetFilter_ProductionCom() async {
    filterdLst_ProductionCom.clear();
    filterdLst_ProductionCom = await bllDef_ProductionCompanies.lstDef_ProductionCompanies;
  }

  Future getLstProductionComAsDataSource({List<BLLCondions>? condions}) async {
    LstProductionComAsDataSource.clear();
    if (bllDef_ProductionCompanies.lstDef_ProductionCompanies.length == 0) {
      await getList_ProductionCom(condions: condions);
    }
    for (var item in bllDef_ProductionCompanies.lstDef_ProductionCompanies) {
      LstProductionComAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? ID) {
    String ret = '';
    if (bllDef_ProductionCompanies.lstDef_ProductionCompanies.isNotEmpty && ID != null) {
      ret = bllDef_ProductionCompanies.lstDef_ProductionCompanies.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }

  productionCom_bloc() : super(productionCom_StateInitial()) {
    on<definition_event>((event, emit) async {
      if (event is getListProductionCom_Event) {
        await getList_ProductionCom();
        emit(getListProductionCom_StateDataChanged(filterdLst_ProductionCom: filterdLst_ProductionCom));
      } else if (event is filterAnyProductionCom_Event) {
        await filterAny_ProductionCom(filterData: event.filterData);
        emit(getListProductionCom_StateDataChanged(filterdLst_ProductionCom: filterdLst_ProductionCom));
      } else if (event is resetFilterProductionCom_Event) {
        await resetFilter_ProductionCom();
        emit(getListProductionCom_StateDataChanged(filterdLst_ProductionCom: filterdLst_ProductionCom));
      }
    });
  }
}

class categories_bloc extends Bloc<definition_event, definition_state> {
  static late categories_bloc instance;

  static categories_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<categories_bloc>(context);
    return instance;
  }

  List<Def_Categories> filterdLst_Category = [];
  List<DropDowenDataSource> LstCategoriesAsDataSource = [];

  Future getList_Category(List<BLLCondions>? condions) async {
    try {
      await bllDef_Categories.fire_getListWithConditions(conditions: condions).then((val) {
        filterdLst_Category = val;
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Future filterAny_Category({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_Category();
    }
    filterdLst_Category = await bllDef_Categories.lstDef_Categories.where((item) {
      return (item.Name == null ? false : item.Name!.toLowerCase().contains(filterData!.toLowerCase()));
    }).toList();
  }

  Future resetFilter_Category() async {
    filterdLst_Category.clear();
    filterdLst_Category = await bllDef_Categories.lstDef_Categories;
  }

  Future getList_CategoryAsDataSource({List<BLLCondions>? condions}) async {
    LstCategoriesAsDataSource.clear();
    if (bllDef_Categories.lstDef_Categories.length == 0) {
      await getList_Category(condions);
    }
    for (var item in bllDef_Categories.lstDef_Categories) {
      LstCategoriesAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? CategoryID) {
    String ret = '';
    if (bllDef_Categories.lstDef_Categories.isNotEmpty && CategoryID != null) {
      ret = bllDef_Categories.lstDef_Categories.firstWhere((elm) {
        return elm.ID == CategoryID;
      }).Name!;
    }
    return ret;
  }

  categories_bloc() : super(categories_StateInitial()) {
    on<definition_event>((event, emit) async {
      if (event is getListCategories_Event) {
        await getList_Category(event.condions);
        emit(getListCategories_StateDataChanged(filterdLst_Categories: filterdLst_Category));
      } else if (event is filterAnyCategories_Event) {
        await filterAny_Category(filterData: event.filterData);
        emit(getListCategories_StateDataChanged(filterdLst_Categories: filterdLst_Category));
      } else if (event is resetFilterCategories_Event) {
        await resetFilter_Category();
        emit(getListCategories_StateDataChanged(filterdLst_Categories: filterdLst_Category));
      }
    });
  }
}

class job_bloc extends Bloc<definition_event, definition_state> {
  static late job_bloc instance;

  static job_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<job_bloc>(context);
    return instance;
  }

  List<Def_Jobs> filterdLst_Job = [];
  List<DropDowenDataSource> LstJobsAsDataSource = [];

  Future getList_Job({List<BLLCondions>? condions}) async {
    try {
      await bllDef_Jobs.fire_getListWithConditions(conditions: condions).then((val) {
        filterdLst_Job = val;
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Future filterAny_Job({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_Job();
    }
    filterdLst_Job = await bllDef_Jobs.lstDef_Jobs.where((item) {
      return (item.Name == null ? false : item.Name!.toLowerCase().contains(filterData!.toLowerCase()));
    }).toList();
  }

  Future resetFilter_Job() async {
    filterdLst_Job.clear();
    filterdLst_Job = await bllDef_Jobs.lstDef_Jobs;
  }

  Future getLstJobsAsDataSource({List<BLLCondions>? condions}) async {
    LstJobsAsDataSource.clear();
    if (bllDef_Jobs.lstDef_Jobs.length == 0) {
      await getList_Job(condions: condions);
    }
    for (var item in bllDef_Jobs.lstDef_Jobs) {
      LstJobsAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? JobID) {
    String ret = '';
    if (bllDef_Jobs.lstDef_Jobs.isNotEmpty && JobID != null) {
      ret = bllDef_Jobs.lstDef_Jobs.firstWhere((elm) {
        return elm.ID == JobID;
      }).Name!;
    }
    return ret;
  }

  job_bloc() : super(jobs_StateInitial()) {
    on<definition_event>((event, emit) async {
      if (event is getListJobs_Event) {
        await getList_Job();
        emit(getListJobs_StateDataChanged(filterdLst_Jobs: filterdLst_Job));
      }
      else if (event is getListJobsAsDataSource_Event) {
        await getLstJobsAsDataSource(condions: event.condions);
        emit(getListJobsAsDataSource_StateDataChanged(lst_JobsAsDataSource: LstJobsAsDataSource));
      }
      else if (event is filterAnyJobs_Event) {
        await filterAny_Job(filterData: event.filterData);
        emit(getListJobs_StateDataChanged(filterdLst_Jobs: filterdLst_Job));
      } else if (event is resetFilterJobs_Event) {
        await resetFilter_Job();
        emit(getListJobs_StateDataChanged(filterdLst_Jobs: filterdLst_Job));
      }
    });
  }
}

class financialCluses_bloc extends Bloc<definition_event, definition_state> {
  static late financialCluses_bloc instance;

  static financialCluses_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<financialCluses_bloc>(context);
    return instance;
  }

  List<Def_FinancialCluses> filterdLst_FinancialCluses = [];
  List<DropDowenDataSource> LstFinancialClusesAsDataSource = [];
  List<DropDowenDataSource> LstFinacialType = [];

  Future getList_FinancialCluses({List<BLLCondions>? condions}) async {
    try {
      await bllDef_FinancialCluses.fire_getListWithConditions(conditions: condions).then((val) {
        filterdLst_FinancialCluses = val;
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Future filterAny_FinancialCluses({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_FinancialCluses();
    }
    filterdLst_FinancialCluses = await bllDef_FinancialCluses.lstDef_FinancialCluses.where((item) {
      return (item.Code == null ? false : item.Code!.toString().toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Name == null ? false : item.Name!.toLowerCase().contains(filterData!.toLowerCase()));
    }).toList();
  }

  Future resetFilter_FinancialCluses() async {
    filterdLst_FinancialCluses.clear();
    filterdLst_FinancialCluses = await bllDef_FinancialCluses.lstDef_FinancialCluses;
  }

  Future getLstFinancialAsDataSource({List<BLLCondions>? condions}) async {
    LstFinancialClusesAsDataSource.clear();
    if (bllDef_FinancialCluses.lstDef_FinancialCluses.length == 0) {
      await getList_FinancialCluses(condions: condions);
    }
    for (var item in bllDef_FinancialCluses.lstDef_FinancialCluses) {
      LstFinancialClusesAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
    ;
  }

  Future getLstFinacialTypeAsDataSource() async {
    LstFinacialType.clear();
    if (bllFix_FinacialType.lstFix_FinacialType.length == 0) await bllFix_FinacialType.fire_getList();
    for (var item in bllFix_FinacialType.lstFix_FinacialType) {
      LstFinacialType.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? ID) {
    String ret = '';
    if (bllDef_FinancialCluses.lstDef_FinancialCluses.isNotEmpty && ID != null) {
      ret = bllDef_FinancialCluses.lstDef_FinancialCluses.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }

  financialCluses_bloc() : super(financialCluses_StateInitial()) {
    on<definition_event>((event, emit) async {
      if (event is getListFinancialCluses_Event) {
        await getList_FinancialCluses();
        emit(getListFinancialCluses_StateDataChanged(filterdLst_FinancialCluses: filterdLst_FinancialCluses));
      } else if (event is filterAnyFinancialCluses_Event) {
        await filterAny_FinancialCluses(filterData: event.filterData);
        emit(getListFinancialCluses_StateDataChanged(filterdLst_FinancialCluses: filterdLst_FinancialCluses));
      } else if (event is resetFilterFinancialCluses_Event) {
        await resetFilter_FinancialCluses();
        emit(getListFinancialCluses_StateDataChanged(filterdLst_FinancialCluses: filterdLst_FinancialCluses));
      }
    });
  }
}

class sections_bloc extends Bloc<definition_event, definition_state> {
  static late sections_bloc instance;

  static sections_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<sections_bloc>(context);
    return instance;
  }

  List<Def_Sections> filterdLst_Section = [];
  List<DropDowenDataSource> LstSectionAsDataSource = [];

  Future getList_Section({List<BLLCondions>? condions}) async {
    try {
      await bllDef_Sections.fire_getListWithConditions(conditions: condions).then((val) {
        filterdLst_Section = val;
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Future filterAny_Section({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_Section();
    }
    filterdLst_Section = await bllDef_Sections.lstDef_Sections.where((item) {
      return (item.Name == null ? false : item.Name!.toLowerCase().contains(filterData!.toLowerCase()));
    }).toList();
  }

  Future resetFilter_Section() async {
    filterdLst_Section.clear();
    filterdLst_Section = await bllDef_Sections.lstDef_Sections;
  }

  Future getLstSectionAsDataSource({List<BLLCondions>? condions}) async {
    LstSectionAsDataSource.clear();
    if (bllDef_Sections.lstDef_Sections.length == 0) {
      await getList_Section(condions: condions);
    }
    for (var item in bllDef_Sections.lstDef_Sections) {
      LstSectionAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? ID) {
    String ret = '';
    if (bllDef_Sections.lstDef_Sections.isNotEmpty && ID != null) {
      ret = bllDef_Sections.lstDef_Sections.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }

  sections_bloc() : super(sections_StateInitial()) {
    on<definition_event>((event, emit) async {
      if (event is getListSections_Event) {
        await getList_Section();
        emit(getListSections_StateDataChanged(filterdLst_Sections: filterdLst_Section));
      } else if (event is filterAnySections_Event) {
        await filterAny_Section(filterData: event.filterData);
        emit(getListSections_StateDataChanged(filterdLst_Sections: filterdLst_Section));
      } else if (event is resetFilterSections_Event) {
        await resetFilter_Section();
        emit(getListSections_StateDataChanged(filterdLst_Sections: filterdLst_Section));
      }
    });
  }
}

class stock_bloc extends Bloc<definition_event, definition_state> {
  static late stock_bloc instance;

  static stock_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<stock_bloc>(context);
    return instance;
  }

  List<Def_Stocks> filterdLst_Stock = [];
  List<DropDowenDataSource> LstStocksAsDataSource = [];
  List<DropDowenDataSource> LstStocksAsDataSource2 = [];

  Future getList_Stock({List<BLLCondions>? condions}) async {
    try {
      filterdLst_Stock.clear();
      await bllDef_Stocks.fire_getListWithConditions(conditions: condions).then((val) {
        filterdLst_Stock = val;
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Future filterAny_Stock({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_Stock();
    }
    filterdLst_Stock = await bllDef_Stocks.lstDef_Stocks.where((item) {
      return (item.Code == null ? false : item.Code!.toString().toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Name == null ? false : item.Name!.toLowerCase().contains(filterData!.toLowerCase()));
    }).toList();
  }

  Future resetFilter_Stock() async {
    filterdLst_Stock.clear();
    LstStocksAsDataSource.clear();
    LstStocksAsDataSource2.clear();
    filterdLst_Stock = await bllDef_Stocks.lstDef_Stocks;
  }

  String getNameByID(int? ID) {
    String ret = '';
    if (LstStocksAsDataSource.isNotEmpty && ID != null) {
      ret = LstStocksAsDataSource.firstWhere((elm) {
        return elm.valueMember == ID;
      }).displayMember;
    }
    return ret;
  }

  String getNameByIDOther(int? ID) {
    String ret = '';
    if (LstStocksAsDataSource2.length > 0 && LstStocksAsDataSource2.isNotEmpty && ID != null) {
      var lst2 = LstStocksAsDataSource2.where((elm) {
        return elm.valueMember == ID;
      });

      ret = lst2.length > 0 ? lst2.first.displayMember : '';
    }
    return ret;
  }

  Future getLstStockAsDataSource({int? branchID, int? branchID2, List<BLLCondions>? condions}) async {
    if (bllDef_Stocks.lstDef_Stocks.length == 0) {
      await getList_Stock(condions: condions);
    }
    LstStocksAsDataSource.clear();
    LstStocksAsDataSource2.clear();
    if (branchID != null) {
      for (var item in bllDef_Stocks.lstDef_Stocks.where((elm) => elm.IDBranch == branchID).toList()) {
        LstStocksAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!, branchID: item.IDBranch));
      }
      //*************
      for (var item2 in bllDef_Stocks.lstDef_Stocks.where((elm) => elm.IDBranch == branchID2).toList()) {
        LstStocksAsDataSource2.add(DropDowenDataSource(valueMember: item2.ID!, displayMember: item2.Name!, branchID: item2.IDBranch));
      }
    } else {
      for (var item in bllDef_Stocks.lstDef_Stocks) {
        LstStocksAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!, branchID: item.IDBranch));
      }
      //*************
      for (var item2 in bllDef_Stocks.lstDef_Stocks) {
        LstStocksAsDataSource2.add(DropDowenDataSource(valueMember: item2.ID!, displayMember: item2.Name!, branchID: item2.IDBranch));
      }
    }
  }

  Future getLstStockAsDataSourceAllData() async {
    if (bllDef_Stocks.lstDef_Stocks.length == 0) {
      await getList_Stock();
    }
    LstStocksAsDataSource.clear();

    for (var item in bllDef_Stocks.lstDef_Stocks) {
      LstStocksAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!, branchID: item.IDBranch));
    }
    //*************
    LstStocksAsDataSource2.clear();
    for (var item2 in bllDef_Stocks.lstDef_Stocks) {
      LstStocksAsDataSource2.add(DropDowenDataSource(valueMember: item2.ID!, displayMember: item2.Name!, branchID: item2.IDBranch));
    }
  }

  stock_bloc() : super(stock_StateInitial()) {
    on<definition_event>((event, emit) async {
      if (event is getListStock_Event) {
        await getList_Stock(condions: event.condions);
        emit(getListStock_StateDataChanged(filterdLst_Stock: filterdLst_Stock));
      } else if (event is filterAnyStock_Event) {
        await filterAny_Stock(filterData: event.filterData);
        emit(getListStock_StateDataChanged(filterdLst_Stock: filterdLst_Stock));
      } else if (event is resetFilterStock_Event) {
        await resetFilter_Stock();
        emit(getListStock_StateDataChanged(filterdLst_Stock: filterdLst_Stock));
      } else if (event is getLstStocksAsDataSource_Event) {
        await getLstStockAsDataSource(branchID: event.branchID, branchID2: event.branchID2, condions: event.condions);
        emit(getLstStocksAsDataSource_State(LstStocksAsDataSource: LstStocksAsDataSource, LstStocksAsDataSource2: LstStocksAsDataSource2));
      }
      // else if (event is getLstStocksOtherAsDataSource_Event) {
      //   await getLstStockOtherAsDataSource(branchID: event.branchID, condions: event.condions);
      //   emit(getLstStocksOtherAsDataSource_State(LstStocksOtherAsDataSource: LstStocksOtherAsDataSource));
      // }
    });
  }
}

class treasure_bloc extends Bloc<definition_event, definition_state> {
  static late treasure_bloc instance;

  static treasure_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<treasure_bloc>(context);
    return instance;
  }

  List<Def_Treasures> filterdLst_Treasure = [];
  List<DropDowenDataSource> LstTreasuresAsDataSource = [];

  Future getList_Treasure({List<BLLCondions>? condions}) async {
    try {
      await bllDef_Treasures.fire_getListWithConditions(conditions: condions).then((val) {
        filterdLst_Treasure = val;
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Future filterAny_Treasure({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_Treasure();
    }
    filterdLst_Treasure = await bllDef_Treasures.lstDef_Treasures.where((item) {
      return (item.Code == null ? false : item.Code!.toString().toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Name == null ? false : item.Name!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Balance == null ? false : item.Balance.toString().toLowerCase().contains(filterData!.toLowerCase()));
    }).toList();
  }

  Future resetFilter_Treasure() async {
    filterdLst_Treasure.clear();
    filterdLst_Treasure = await bllDef_Treasures.lstDef_Treasures;
  }

  Future getLstTreasureAsDataSource({List<BLLCondions>? condions}) async {
    LstTreasuresAsDataSource.clear();
    if (bllDef_Treasures.lstDef_Treasures.length == 0) {
      await getList_Treasure(condions: condions);
    }
    for (var item in bllDef_Treasures.lstDef_Treasures) {
      LstTreasuresAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? ID) {
    String ret = '';
    if (filterdLst_Treasure.isNotEmpty && ID != null) {
      ret = filterdLst_Treasure.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }

  treasure_bloc() : super(treasure_StateInitial()) {
    on<definition_event>((event, emit) async {
      if (event is getListTreasure_Event) {
        await getList_Treasure();
        emit(getListTreasure_StateDataChanged(filterdLst_Treasure: filterdLst_Treasure));
      } else if (event is filterAnyTreasure_Event) {
        await filterAnyTreasure_Event(filterData: event.filterData);
        emit(getListTreasure_StateDataChanged(filterdLst_Treasure: filterdLst_Treasure));
      } else if (event is resetFilterTreasure_Event) {
        await resetFilter_Treasure();
        emit(getListTreasure_StateDataChanged(filterdLst_Treasure: filterdLst_Treasure));
      }
    });
  }
}

class product_bloc extends Bloc<definition_event, definition_state> {
  static late product_bloc instance;

  static product_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<product_bloc>(context);
    return instance;
  }

  List<Def_ProductStructure> filterdLst_Product = [];
  List<DropDowenDataSource> LstProductsAsDataSource = [];

  Future getList_Product({List<BLLCondions>? condions}) async {
    try {
      await bllDef_ProductStructure.fire_getListWithConditions(conditions: condions).then((val) {
        filterdLst_Product = val;
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Future filterAny_Product({String? filterData, int? categoryID}) async {
    if (categoryID != null) {
      filterdLst_Product = await bllDef_ProductStructure.lstDef_ProductStructure.where((item) {
        return item.IDCategory == categoryID;
      }).toList();
    }

// البحث باي معلومة حسب المرسل فى البارااميتر
    if (filterData != null && filterData.isNotEmpty) {
      filterdLst_Product = await filterdLst_Product.where((item) {
        String categortName = categories_bloc.instance.getNameByID(item.IDCategory);
        String unitSmallName = unit_bloc.instance.getNameByID(item.UnitSmall_ID);
        String unitBigName = unit_bloc.instance.getNameByID(item.UnitBig_ID);

        return (item.BarCode == null ? false : item.BarCode!.toString().toLowerCase().contains(filterData.toLowerCase())) ||
            (item.Name == null ? false : item.Name!.toLowerCase().contains(filterData.toLowerCase())) ||
            (categortName.isEmpty ? false : categortName.toLowerCase().contains(filterData.toLowerCase())) ||
            (unitSmallName.isEmpty ? false : unitSmallName.toLowerCase().contains(filterData.toLowerCase())) ||
            (unitBigName.isEmpty ? false : unitBigName.toLowerCase().contains(filterData.toLowerCase())) ||
            (item.UnitBig_PurchasePrice == null ? false : item.UnitBig_PurchasePrice.toString().contains(filterData.toLowerCase())) ||
            (item.UnitBig_Sales1 == null ? false : item.UnitBig_Sales1.toString().contains(filterData.toLowerCase())) ||
            (item.UnitBig_Sales2 == null ? false : item.UnitBig_Sales2.toString().contains(filterData.toLowerCase())) ||
            (item.UnitBig_Sales3 == null ? false : item.UnitBig_Sales3.toString().contains(filterData.toLowerCase())) ||
            (item.UnitBig_Sales4 == null ? false : item.UnitBig_Sales4.toString().contains(filterData.toLowerCase())) ||
            (item.UnitBig_Sales5 == null ? false : item.UnitBig_Sales5.toString().contains(filterData.toLowerCase())) ||
            (item.UnitSmall_PurchasePrice == null ? false : item.UnitSmall_PurchasePrice.toString().contains(filterData.toLowerCase())) ||
            (item.UnitSmall_Sales1 == null ? false : item.UnitSmall_Sales1.toString().contains(filterData.toLowerCase())) ||
            (item.UnitSmall_Sales2 == null ? false : item.UnitSmall_Sales2.toString().contains(filterData.toLowerCase())) ||
            (item.UnitSmall_Sales3 == null ? false : item.UnitSmall_Sales3.toString().contains(filterData.toLowerCase())) ||
            (item.UnitSmall_Sales4 == null ? false : item.UnitSmall_Sales4.toString().contains(filterData.toLowerCase())) ||
            (item.UnitSmall_Sales5 == null ? false : item.UnitSmall_Sales5.toString().contains(filterData.toLowerCase()));
      }).toList();
    }

    // لو مفيش شروط بحث يرجع كل البيانات
    if ((filterData == null || filterData.isEmpty) && categoryID == null) {
      resetFilter_Product();
    }
  }

  Future resetFilter_Product() async {
    filterdLst_Product.clear();
    filterdLst_Product = await bllDef_ProductStructure.lstDef_ProductStructure;
  }

  Future getLstProductsAsDataSource({List<BLLCondions>? condions}) async {
    if (bllDef_ProductStructure.lstDef_ProductStructure.length == 0) {
      await getList_Product(condions: condions);
    }
    for (var item in bllDef_ProductStructure.lstDef_ProductStructure) {
      LstProductsAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? ID) {
    String ret = '';
    if (bllDef_ProductStructure.lstDef_ProductStructure.isNotEmpty && ID != null) {
      ret = bllDef_ProductStructure.lstDef_ProductStructure.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }

  Future<double> getPriceByTypeID(int productID, int? priceTypeID) async {
    if (priceTypeID == null) return 0;

    double ret = 0;

    if (product_bloc.instance.LstProductsAsDataSource.length == 0) await product_bloc.instance.getLstProductsAsDataSource();

    var prod = await product_bloc.instance.filterdLst_Product.where((elm) => elm.ID == productID).first;
    // await bllDef_ProductStructure.fire_getItem(productID.toString());
    if (priceTypeID == en_PriceType.purchasePrice.value) {
      ret = prod.UnitSmall_PurchasePrice!;
    } else if (priceTypeID == en_PriceType.salesPrice1.value) {
      ret = prod.UnitSmall_Sales1!;
    } else if (priceTypeID == en_PriceType.salesPrice2.value) {
      ret = prod.UnitSmall_Sales2!;
    } else if (priceTypeID == en_PriceType.salesPrice3.value) {
      ret = prod.UnitSmall_Sales3!;
    } else if (priceTypeID == en_PriceType.salesPrice4.value) {
      ret = prod.UnitSmall_Sales4!;
    } else if (priceTypeID == en_PriceType.salesPrice5.value) {
      ret = prod.UnitSmall_Sales5!;
    }
    return ret;
  }

  late imageTemplet productImageTemp = imageTemplet();

  Future takeImageProduct() async {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      productImageTemp.imagepath = value!.path;
      productImageTemp.imageName = Uri.file(value.path).pathSegments.last;
      productImageTemp.imageFile = File(value.path);
      productImageTemp.image = Image.file(productImageTemp.imageFile!).image;
    }).catchError((error) {
      throw error;
    });
    // return productImage!;
  }

  product_bloc() : super(product_StateInitial()) {
    on<definition_event>((event, emit) async {
      if (event is getListProduct_Event) {
        await getList_Product();
        filterdLst_Product.sort((a, b) => a.BarCode!.compareTo(b.BarCode!));
        emit(getListProduct_StateDataChanged(filterdLst_Product: filterdLst_Product));
      } else if (event is filterAnyProduct_Event) {
        await filterAny_Product(filterData: event.filterData, categoryID: event.categoryID);
        filterdLst_Product.sort((a, b) => a.BarCode!.compareTo(b.BarCode!));
        emit(getListProduct_StateDataChanged(filterdLst_Product: filterdLst_Product));
      } else if (event is resetFilterProduct_Event) {
        await resetFilter_Product();
        filterdLst_Product.sort((a, b) => a.BarCode!.compareTo(b.BarCode!));
        emit(getListProduct_StateDataChanged(filterdLst_Product: filterdLst_Product));
      } else if (event is refreshProduct_Event) {
        filterdLst_Product.sort((a, b) => a.BarCode!.compareTo(b.BarCode!));
        emit(getListProduct_StateDataChanged(filterdLst_Product: filterdLst_Product));
      }
    });
  }
}
