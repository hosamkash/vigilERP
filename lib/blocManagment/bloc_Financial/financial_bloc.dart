import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/bll/classModel/Fina_ClosedTreasure.dart';
import 'package:vigil_erp/blocManagment/blocFixTables/fix_table_bloc.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import '../../bll/bllFirebase/ManageBLL.dart';
import '../../bll/bllFirebase/bllFina_ClosedTreasure.dart';
import '../../bll/bllFirebase/bllFina_Exchange.dart';
import '../../bll/bllFirebase/bllFina_Supplay.dart';
import '../../bll/bllFirebase/bllFina_Transfere.dart';
import '../../bll/classModel/Fina_Exchange.dart';
import '../../bll/classModel/Fina_Supplay.dart';
import '../../bll/classModel/Fina_Transfere.dart';
import '../../bll/classModel/Fina_TreasuryMovementFull.dart';
import '../../componants/ctr_DropDowenList.dart';
import '../blocDealing/dealing_bloc.dart';
import '../blocDefinition/definition_bloc.dart';

part 'financial_event.dart';

part 'financial_state.dart';

class exchange_bloc extends Bloc<financial_event, financial_state> {
  static late exchange_bloc instance;

  static exchange_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<exchange_bloc>(context);
    return instance;
  }

  List<Fina_Exchange> filterdLst_Exchange = [];
  List<DropDowenDataSource> LstExchangeAsDataSource = [];

  Future getList_Exchange({List<BLLCondions>? conditions}) async {
    try {
      filterdLst_Exchange = await bllFina_Exchange.fire_getListWithConditions(conditions: conditions);
    } catch (error) {
      print(error.toString());
    }
  }

  filterAny_Exchange({String? filterData}) {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_Exchange();
    }
    filterdLst_Exchange = bllFina_Exchange.lstFina_Exchange.where((item) {
      String branchName = company_bloc.instance.getNameByID(item.IDBranch);
      String treasurName = treasure_bloc.instance.getNameByID(item.IDTreasur);
      String dealingTypeName = dealingType_bloc.instance.getNameByID(item.DealingTypeID);
      String financialClusesName = financialCluses_bloc.instance.getNameByID(item.IDFinancialCluses);

      String dealingName = '';
      if (item.DealingTypeID == en_DealingType.Cliens.value)
        dealingName = client_bloc.instance.getNameByID(item.DealingID);
      else if (item.DealingTypeID == en_DealingType.Vendors.value)
        dealingName = vendor_bloc.instance.getNameByID(item.DealingID);
      else if (item.DealingTypeID == en_DealingType.Employees.value) dealingName = employee_bloc.instance.getNameByID(item.DealingID);

      return (item.Code == null ? false : item.Code!.toString().toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Serial == null ? false : item.Serial.toString().contains(filterData!.toLowerCase())) ||
          (item.Date == null ? false : item.Date!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Time == null ? false : item.Time!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Value == null ? false : item.Value!.toString().contains(filterData!.toLowerCase())) ||
          (item.Note == null ? false : item.Note!.toString().contains(filterData!.toLowerCase())) ||
          (branchName.isEmpty ? false : branchName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (treasurName.isEmpty ? false : treasurName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (dealingTypeName.isEmpty ? false : dealingTypeName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (dealingName.isEmpty ? false : dealingName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (financialClusesName.isEmpty ? false : financialClusesName.toLowerCase().contains(filterData!.toLowerCase()));
    }).toList();
  }

  Future resetFilter_Exchange() async {
    filterdLst_Exchange.clear();
    filterdLst_Exchange = bllFina_Exchange.lstFina_Exchange;
  }

  exchange_bloc() : super(financialnitial()) {
    on<financial_event>((event, emit) async {
      if (event is getListExchange_Event) {
        await getList_Exchange(conditions: event.conditions);
        emit(getListExchange_StateDataChanged(filterdLst_Exchange: filterdLst_Exchange));
      } else if (event is filterAnyExchange_Event) {
        await filterAny_Exchange(filterData: event.filterData);
        emit(getListExchange_StateDataChanged(filterdLst_Exchange: filterdLst_Exchange));
      } else if (event is resetFilterExchange_Event) {
        await resetFilter_Exchange();
        emit(getListExchange_StateDataChanged(filterdLst_Exchange: filterdLst_Exchange));
      }
    });
  }
}

class supplay_bloc extends Bloc<financial_event, financial_state> {
  static late supplay_bloc instance;

  static supplay_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<supplay_bloc>(context);
    return instance;
  }

  List<Fina_Supplay> filterdLst_Supplay = [];
  List<DropDowenDataSource> LstSupplayAsDataSource = [];

  Future getList_Supplay({List<BLLCondions>? conditions}) async {
    try {
      filterdLst_Supplay = await bllFina_Supplay.fire_getListWithConditions(conditions: conditions);
    } catch (error) {
      print(error.toString());
    }
  }

  filterAny_Supplay({String? filterData}) {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_Supplay();
    }
    filterdLst_Supplay = bllFina_Supplay.lstFina_Supplay.where((item) {
      String branchName = company_bloc.instance.getNameByID(item.IDBranch);
      String treasurName = treasure_bloc.instance.getNameByID(item.IDTreasur);
      String dealingTypeName = dealingType_bloc.instance.getNameByID(item.DealingTypeID);
      String financialClusesName = financialCluses_bloc.instance.getNameByID(item.IDFinancialCluses);

      String dealingName = '';
      if (item.DealingTypeID == en_DealingType.Cliens.value)
        dealingName = client_bloc.instance.getNameByID(item.DealingID);
      else if (item.DealingTypeID == en_DealingType.Vendors.value)
        dealingName = vendor_bloc.instance.getNameByID(item.DealingID);
      else if (item.DealingTypeID == en_DealingType.Employees.value) dealingName = employee_bloc.instance.getNameByID(item.DealingID);

      return (item.Code == null ? false : item.Code!.toString().toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Serial == null ? false : item.Serial.toString().contains(filterData!.toLowerCase())) ||
          (item.Date == null ? false : item.Date!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Time == null ? false : item.Time!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Value == null ? false : item.Value!.toString().contains(filterData!.toLowerCase())) ||
          (item.Note == null ? false : item.Note!.toString().contains(filterData!.toLowerCase())) ||
          (branchName.isEmpty ? false : branchName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (treasurName.isEmpty ? false : treasurName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (dealingTypeName.isEmpty ? false : dealingTypeName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (dealingName.isEmpty ? false : dealingName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (financialClusesName.isEmpty ? false : financialClusesName.toLowerCase().contains(filterData!.toLowerCase()));
    }).toList();
  }

  Future resetFilter_Supplay() async {
    filterdLst_Supplay.clear();
    filterdLst_Supplay = bllFina_Supplay.lstFina_Supplay;
  }

  supplay_bloc() : super(financialnitial()) {
    on<financial_event>((event, emit) async {
      if (event is getListSupplay_Event) {
        await getList_Supplay(conditions: event.conditions);
        emit(getListSupplay_StateDataChanged(filterdLst_Supplay: filterdLst_Supplay));
      } else if (event is filterAnySupplay_Event) {
        await filterAny_Supplay(filterData: event.filterData);
        emit(getListSupplay_StateDataChanged(filterdLst_Supplay: filterdLst_Supplay));
      } else if (event is resetFilterSupplay_Event) {
        await resetFilter_Supplay();
        emit(getListSupplay_StateDataChanged(filterdLst_Supplay: filterdLst_Supplay));
      }
    });
  }
}

class transfereMony_bloc extends Bloc<financial_event, financial_state> {
  static late transfereMony_bloc instance;

  static transfereMony_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<transfereMony_bloc>(context);
    return instance;
  }

  List<Fina_Transfere> filterdLst_Transfere = [];
  List<DropDowenDataSource> LstTransfereAsDataSource = [];

  Future getList_Transfere({List<BLLCondions>? conditions}) async {
    try {
      filterdLst_Transfere = await bllFina_Transfere.fire_getListWithConditions(conditions: conditions);
    } catch (error) {
      print(error.toString());
    }
  }

  filterAny_Transfere({String? filterData}) {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_Transfere();
    }
    filterdLst_Transfere = bllFina_Transfere.lstFina_Transfere.where((item) {
      String branchFromName = company_bloc.instance.getNameByID(item.IDBranchFrom);
      String treasurFromName = treasure_bloc.instance.getNameByID(item.IDTreasurFrom);
      String branchToName = company_bloc.instance.getNameByID(item.IDBranchTo);
      String treasurToName = treasure_bloc.instance.getNameByID(item.IDTreasurTo);
      String dealingName = employee_bloc.instance.getNameByID(item.IDEmployee);

      return (item.Code == null ? false : item.Code!.toString().toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Date == null ? false : item.Date!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Time == null ? false : item.Time!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Value == null ? false : item.Value!.toString().contains(filterData!.toLowerCase())) ||
          (item.Note == null ? false : item.Note!.toString().contains(filterData!.toLowerCase())) ||
          (branchFromName.isEmpty ? false : branchFromName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (treasurFromName.isEmpty ? false : treasurFromName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (branchToName.isEmpty ? false : branchToName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (treasurToName.isEmpty ? false : treasurToName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (dealingName.isEmpty ? false : dealingName.toLowerCase().contains(filterData!.toLowerCase()));
    }).toList();
  }

  Future resetFilter_Transfere() async {
    filterdLst_Transfere.clear();
    filterdLst_Transfere = bllFina_Transfere.lstFina_Transfere;
  }

  transfereMony_bloc() : super(financialnitial()) {
    on<financial_event>((event, emit) async {
      if (event is getListTransfereMony_Event) {
        await getList_Transfere(conditions: event.conditions);
        emit(getListTransfere_StateDataChanged(filterdLst_Transfere: filterdLst_Transfere));
      } else if (event is filterAnyTransfereMony_Event) {
        await filterAny_Transfere(filterData: event.filterData);
        emit(getListTransfere_StateDataChanged(filterdLst_Transfere: filterdLst_Transfere));
      } else if (event is resetFilterTransfereMony_Event) {
        await resetFilter_Transfere();
        emit(getListTransfere_StateDataChanged(filterdLst_Transfere: filterdLst_Transfere));
      }
    });
  }
}

class treasurMovement_bloc extends Bloc<financial_event, financial_state> {
  static late treasurMovement_bloc instance;

  static treasurMovement_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<treasurMovement_bloc>(context);
    return instance;
  }

  List<Fina_Exchange> filterdLst_Exchange = [];
  List<Fina_Supplay> filterdLst_Supplay = [];
  List<Fina_TreasuryMovementFull> lst_TreasuryMovement = [];
  List<Fina_TreasuryMovementFull> filterdLst_TreasuryMovementFull = [];

  Future getList_TreasuryMovement({List<BLLCondions>? conditions}) async {
    try {
      lst_TreasuryMovement.clear();

      // سندات الدفع
      filterdLst_Exchange = await bllFina_Exchange.fire_getListWithConditions(conditions: conditions);
      filterdLst_Exchange.forEach((elm) {
        lst_TreasuryMovement.add(Fina_TreasuryMovementFull(
          ID: elm.ID,
          Code: elm.Code,
          Serial: elm.Serial,
          Date: elm.Date,
          Time: elm.Time,
          IDTreasur: elm.IDTreasur,
          TreasurName: treasure_bloc.instance.getNameByID(elm.IDTreasur),
          DealingTypeID: elm.DealingTypeID,
          DealingTypeName: dealingType_bloc.instance.getNameByID(elm.DealingTypeID),
          DealingID: elm.DealingID,
          DealingName: getDealingNameByID(elm.DealingTypeID, elm.DealingID),
          BalanceBefor: elm.BalanceBefor,
          Value: elm.Value,
          BalanceAfter: elm.BalanceAfter,
          IDFinancialCluses: elm.IDFinancialCluses,
          FinancialClusesName: financialCluses_bloc.instance.getNameByID(elm.IDFinancialCluses),
          Note: elm.Note,
          IsBindeDocument: elm.IsBindeDocument,
          BindeDocumentTypeID: elm.BindeDocumentTypeID,
          BindeDocumentID: elm.BindeDocumentID,
          BindeDocumentText: elm.BindeDocumentText,
          BindeDocumentCode: elm.BindeDocumentCode,
          IsAccountedByRepresent: elm.IsAccountedByRepresent,
          IDUser: elm.IDUser,
          IDBranch: elm.IDBranch,
          BranchName: company_bloc.instance.getNameByID(elm.IDBranch),
          IsTransfere: elm.IsClosedTreasure,
          IDTransfere: elm.IDClosedTreasure,
          IsClosedEdit: elm.IsClosedEdit,
          IDCalcSalary: elm.IDCalcSalary,
          FinacialTypeID: en_finacialType.finacialTypeExchange.value,
          FinacialTypeName: 'دفع',
        ));
      });

      // سندات القبض
      filterdLst_Supplay = await bllFina_Supplay.fire_getListWithConditions(conditions: conditions);
      filterdLst_Supplay.forEach((elm) {
        lst_TreasuryMovement.add(Fina_TreasuryMovementFull(
          ID: elm.ID,
          Code: elm.Code,
          Serial: elm.Serial,
          Date: elm.Date,
          Time: elm.Time,
          IDTreasur: elm.IDTreasur,
          TreasurName: treasure_bloc.instance.getNameByID(elm.IDTreasur),
          DealingTypeID: elm.DealingTypeID,
          DealingTypeName: dealingType_bloc.instance.getNameByID(elm.DealingTypeID),
          DealingID: elm.DealingID,
          DealingName: getDealingNameByID(elm.DealingTypeID, elm.DealingID),
          BalanceBefor: elm.BalanceBefor,
          Value: elm.Value,
          BalanceAfter: elm.BalanceAfter,
          IDFinancialCluses: elm.IDFinancialCluses,
          FinancialClusesName: financialCluses_bloc.instance.getNameByID(elm.IDFinancialCluses),
          Note: elm.Note,
          IsBindeDocument: elm.IsBindeDocument,
          BindeDocumentTypeID: elm.BindeDocumentTypeID,
          BindeDocumentID: elm.BindeDocumentID,
          BindeDocumentText: elm.BindeDocumentText,
          BindeDocumentCode: elm.BindeDocumentCode,
          IsAccountedByRepresent: elm.IsAccountedByRepresent,
          IDUser: elm.IDUser,
          IDBranch: elm.IDBranch,
          BranchName: company_bloc.instance.getNameByID(elm.IDBranch),
          IsTransfere: elm.IsClosedTreasure,
          IDTransfere: elm.IDClosedTreasure,
          IsClosedEdit: elm.IsClosedEdit,
          IDCalcSalary: elm.IDCalcSalary,
          FinacialTypeID: en_finacialType.finacialTypeSupplay.value,
          FinacialTypeName: 'قبض',
        ));
      });

      filterdLst_TreasuryMovementFull.clear();
      filterdLst_TreasuryMovementFull.addAll(lst_TreasuryMovement);
    } catch (error) {
      print(error.toString());
    }
  }

  filterAny_TreasuryMovement({String? filterData}) {
    if (filterData == null || filterData.isEmpty) {
      // resetFilter_TreasuryMovement();
    }
    filterdLst_TreasuryMovementFull = lst_TreasuryMovement.where((item) {
      String branchName = company_bloc.instance.getNameByID(item.IDBranch);
      String treasurName = treasure_bloc.instance.getNameByID(item.IDTreasur);
      String dealingTypeName = dealingType_bloc.instance.getNameByID(item.DealingTypeID);
      // String financialClusesName = financialCluses_bloc.instance.getNameByID(item.IDFinancialCluses);

      String dealingName = '';
      if (item.DealingTypeID == en_DealingType.Cliens.value)
        dealingName = client_bloc.instance.getNameByID(item.DealingID);
      else if (item.DealingTypeID == en_DealingType.Vendors.value)
        dealingName = vendor_bloc.instance.getNameByID(item.DealingID);
      else if (item.DealingTypeID == en_DealingType.Employees.value) dealingName = employee_bloc.instance.getNameByID(item.DealingID);

      return (item.Code == null ? false : item.Code!.toString().toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Serial == null ? false : item.Serial.toString().contains(filterData!.toLowerCase())) ||
          (item.Date == null ? false : item.Date!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Time == null ? false : item.Time!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Value == null ? false : item.Value!.toString().contains(filterData!.toLowerCase())) ||
          (item.Note == null ? false : item.Note!.toString().contains(filterData!.toLowerCase())) ||
          (branchName.isEmpty ? false : branchName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (treasurName.isEmpty ? false : treasurName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (dealingTypeName.isEmpty ? false : dealingTypeName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (dealingName.isEmpty ? false : dealingName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.FinacialTypeName == null ? false : item.FinacialTypeName!.toLowerCase().contains(filterData!.toLowerCase()));
    }).toList();
  }

  Future resetFilter_TreasuryMovement() async {
    filterdLst_TreasuryMovementFull.clear();
    filterdLst_TreasuryMovementFull.addAll(lst_TreasuryMovement);
  }

  Future updateReciptsIsTransfereDone(Fina_ClosedTreasure itemClosedTreasure) async {

    List<Fina_Exchange> tempExchange = [];
    List<Fina_Supplay> tempSupplay = [];
    Fina_Exchange itemExchange;
    Fina_Supplay itemSupplay;
    treasurMovement_bloc.instance.filterdLst_TreasuryMovementFull.where((elm) => elm.IsTransfere == false)
        .forEach((elm) {
      if (elm.FinacialTypeID == en_finacialType.finacialTypeExchange.value) {
        itemExchange = filterdLst_Exchange.where((ex) => ex.ID == elm.ID && ex.IsClosedTreasure == false).first;
        itemExchange.IsClosedTreasure =  itemExchange.IsClosedEdit =  true;
        itemExchange.IDClosedTreasure = itemClosedTreasure.ID ;
        tempExchange.add(itemExchange);
      } else if (elm.FinacialTypeID == en_finacialType.finacialTypeSupplay.value) {
        itemSupplay = filterdLst_Supplay.where((ex) => ex.ID == elm.ID && ex.IsClosedTreasure == false).first;
        itemSupplay.IsClosedTreasure =   itemSupplay.IsClosedEdit =  true;
        itemSupplay.IDClosedTreasure = itemClosedTreasure.ID ;
        tempSupplay.add(itemSupplay);
      }
    });

    bllFina_Exchange.fire_setListMaster(lstFina_Exchange: tempExchange);
    bllFina_Supplay.fire_setListMaster(lstFina_Supplay: tempSupplay);
  }

  String getDealingNameByID(int? dealingTypeID, int? dealingID) {
    if (dealingTypeID == en_DealingType.Cliens.value)
      return client_bloc.instance.getNameByID(dealingID);
    else if (dealingTypeID == en_DealingType.Vendors.value)
      return vendor_bloc.instance.getNameByID(dealingID);
    else if (dealingTypeID == en_DealingType.Employees.value)
      return employee_bloc.instance.getNameByID(dealingID);
    else
      return '';
  }

  treasurMovement_bloc() : super(financialnitial()) {
    on<financial_event>((event, emit) async {
      if (event is getListTreasuryMovementMony_Event) {
        await getList_TreasuryMovement(conditions: event.conditions);
        emit(getListTreasuryMovement_StateDataChanged(filterdLst_TreasuryMovement: filterdLst_TreasuryMovementFull));
      } else if (event is filterAnyTreasuryMovementMony_Event) {
        await filterAny_TreasuryMovement(filterData: event.filterData);
        emit(getListTreasuryMovement_StateDataChanged(filterdLst_TreasuryMovement: filterdLst_TreasuryMovementFull));
      } else if (event is resetFilterTreasuryMovementMony_Event) {
        await resetFilter_TreasuryMovement();
        emit(getListTreasuryMovement_StateDataChanged(filterdLst_TreasuryMovement: filterdLst_TreasuryMovementFull));
      }
    });
  }
}

class closedTreasure_bloc extends Bloc<financial_event, financial_state> {
  static late closedTreasure_bloc instance;

  static closedTreasure_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<closedTreasure_bloc>(context);
    return instance;
  }

  List<Fina_ClosedTreasure> filterdLst_ClosedTreasure = [];
  List<DropDowenDataSource> LstClosedTreasureAsDataSource = [];

  Future getList_ClosedTreasure({List<BLLCondions>? conditions}) async {
    try {
      filterdLst_ClosedTreasure = await bllFina_ClosedTreasure.fire_getListWithConditions(conditions: conditions);
    } catch (error) {
      print(error.toString());
    }
  }

  filterAny_ClosedTreasure({String? filterData}) {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_ClosedTreasure();
    }
    filterdLst_ClosedTreasure = bllFina_ClosedTreasure.lstFina_ClosedTreasure.where((item) {
      String branchFromName = company_bloc.instance.getNameByID(item.IDBranchFrom);
      String treasurFromName = treasure_bloc.instance.getNameByID(item.IDTreasurFrom);
      String branchToName = company_bloc.instance.getNameByID(item.IDBranchTo);
      String treasurToName = treasure_bloc.instance.getNameByID(item.IDTreasurTo);
      String dealingName = employee_bloc.instance.getNameByID(item.IDEmployee);

      return (item.Code == null ? false : item.Code!.toString().toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Date == null ? false : item.Date!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Time == null ? false : item.Time!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Value == null ? false : item.Value!.toString().contains(filterData!.toLowerCase())) ||
          (item.Note == null ? false : item.Note!.toString().contains(filterData!.toLowerCase())) ||
          (branchFromName.isEmpty ? false : branchFromName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (treasurFromName.isEmpty ? false : treasurFromName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (branchToName.isEmpty ? false : branchToName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (treasurToName.isEmpty ? false : treasurToName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (dealingName.isEmpty ? false : dealingName.toLowerCase().contains(filterData!.toLowerCase()));
    }).toList();
  }

  Future resetFilter_ClosedTreasure() async {
    filterdLst_ClosedTreasure.clear();
    filterdLst_ClosedTreasure = bllFina_ClosedTreasure.lstFina_ClosedTreasure;
  }

  closedTreasure_bloc() : super(financialnitial()) {
    on<financial_event>((event, emit) async {
      if (event is getListClosedTreasure_Event) {
        await getList_ClosedTreasure(conditions: event.conditions);
        emit(getListClosedTreasure_StateDataChanged(filterdLst_ClosedTreasure: filterdLst_ClosedTreasure));
      } else if (event is filterAnyClosedTreasure_Event) {
        await filterAny_ClosedTreasure(filterData: event.filterData);
        emit(getListClosedTreasure_StateDataChanged(filterdLst_ClosedTreasure: filterdLst_ClosedTreasure));
      } else if (event is resetFilterClosedTreasure_Event) {
        await resetFilter_ClosedTreasure();
        emit(getListClosedTreasure_StateDataChanged(filterdLst_ClosedTreasure: filterdLst_ClosedTreasure));
      }
    });
  }
}
