import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/blocManagment/blocFixTables/fix_table_bloc.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import '../../bll/bllFirebase/ManageBLL.dart';
import '../../bll/bllFirebase/bllFina_Exchange.dart';
import '../../bll/bllFirebase/bllFina_Supplay.dart';
import '../../bll/classModel/Fina_Exchange.dart';
import '../../bll/classModel/Fina_Supplay.dart';
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
