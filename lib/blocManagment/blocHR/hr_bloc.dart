import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/bll/bllFirebase/ManageBLL.dart';
import 'package:vigil_erp/bll/bllFirebase/bllHR_Withdrwals.dart';
import 'package:vigil_erp/bll/classModel/HR_Bonus.dart';
import 'package:vigil_erp/bll/classModel/HR_Withdrwals.dart';
import '../../bll/bllFirebase/bllHR_Bonus.dart';
import '../../bll/bllFirebase/bllHR_Discount.dart';
import '../../bll/classModel/HR_Discount.dart';
import '../../bll/classModel/HR_Withdrwals.dart';
import '../../componants/ctr_DropDowenList.dart';
import '../blocDealing/dealing_bloc.dart';
import '../blocDefinition/definition_bloc.dart';
part 'hr_event.dart';

part 'hr_state.dart';

class bonus_bloc extends Bloc<hr_event, hr_state> {
  static late bonus_bloc instance;

  static bonus_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<bonus_bloc>(context);
    return instance;
  }

  List<HR_Bonus> filterdLst_Bonus = [];
  List<DropDowenDataSource> LstBonusAsDataSource = [];

  Future getList_Bonus({List<BLLCondions>? conditions}) async {
    try {
      filterdLst_Bonus = await bllHR_Bonus.fire_getListWithConditions(conditions: conditions);
    } catch (error) {
      print(error.toString());
    }
  }

  filterAny_Bonus({String? filterData}) {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_Bonus();
    }
    filterdLst_Bonus = bllHR_Bonus.lstHR_Bonus.where((item) {
      String branchName = company_bloc.instance.getNameByID(item.IDBranch);
      String employeeName = employee_bloc.instance.getNameByID(item.IDEmployee);
      String jobName = job_bloc.instance.getNameByID(item.IDJob);
      String departmentName = sections_bloc.instance.getNameByID(item.IDDepartment);
      String bonusTypeName = sections_bloc.instance.getNameByID(item.BounsType);

      return (item.Code == null ? false : item.Code!.toString().toLowerCase().contains(filterData!.toLowerCase())) ||
          (branchName.isEmpty ? false : branchName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (employeeName.isEmpty ? false : employeeName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (jobName.isEmpty ? false : jobName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (departmentName.isEmpty ? false : departmentName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (bonusTypeName.isEmpty ? false : bonusTypeName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Time == null ? false : item.Time!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.BounsValue == null ? false : item.BounsValue.toString().contains(filterData!.toLowerCase())) ||
          (item.Date == null ? false : item.Date!.toLowerCase().contains(filterData!.toLowerCase()))
      ;
    }).toList();
  }

  Future resetFilter_Bonus() async {
    filterdLst_Bonus.clear();
    filterdLst_Bonus = bllHR_Bonus.lstHR_Bonus;
  }

  bonus_bloc() : super(hr_StateInitial()) {
    on<hr_event>((event, emit) async {
      if (event is getListBonus_Event) {
        await getList_Bonus(conditions: event.conditions);
        emit(getListBonus_StateDataChanged(filterdLst_Bonus: filterdLst_Bonus));
      }
      // else if (event is getListBonusAsDataSource_Event) {
      //   await getList_BonusAsDataSource();
      //   emit(getListBonusAsDataSource_StateDataChanged(filterdLst_BonusAsDataSource: LstBonusAsDataSource));
      // }
      else if (event is filterAnyBonus_Event) {
        await filterAny_Bonus(filterData: event.filterData);
        emit(getListBonus_StateDataChanged(filterdLst_Bonus: filterdLst_Bonus));
      } else if (event is resetFilterBonus_Event) {
        await resetFilter_Bonus();
        emit(getListBonus_StateDataChanged(filterdLst_Bonus: filterdLst_Bonus));
      }
    });
  }
}

class discount_bloc extends Bloc<hr_event, hr_state> {
  static late discount_bloc instance;

  static discount_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<discount_bloc>(context);
    return instance;
  }

  List<HR_Discount> filterdLst_Discount = [];
  List<DropDowenDataSource> LstDiscountAsDataSource = [];

  Future getList_Discount({List<BLLCondions>? conditions}) async {
    try {
      filterdLst_Discount = await bllHR_Discount.fire_getListWithConditions(conditions: conditions);
    } catch (error) {
      print(error.toString());
    }
  }

  filterAny_Discount({String? filterData}) {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_Discount();
    }
    filterdLst_Discount = bllHR_Discount.lstHR_Discount.where((item) {

      String branchName = company_bloc.instance.getNameByID(item.IDBranch);
      String employeeName = employee_bloc.instance.getNameByID(item.IDEmployee);
      String jobName = job_bloc.instance.getNameByID(item.IDJob);
      String departmentName = sections_bloc.instance.getNameByID(item.IDDepartment);
      String discountTypeName = sections_bloc.instance.getNameByID(item.DiscountType);

      return (item.Code == null ? false : item.Code!.toString().toLowerCase().contains(filterData!.toLowerCase())) ||
          (branchName.isEmpty ? false : branchName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (employeeName.isEmpty ? false : employeeName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (jobName.isEmpty ? false : jobName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (departmentName.isEmpty ? false : departmentName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (discountTypeName.isEmpty ? false : discountTypeName.toLowerCase().contains(filterData!.toLowerCase())) ||
      (item.Time == null ? false : item.Time!.toLowerCase().contains(filterData!.toLowerCase())) ||
      (item.DiscountValue == null ? false : item.DiscountValue.toString().contains(filterData!.toLowerCase())) ||
      (item.Date == null ? false : item.Date!.toLowerCase().contains(filterData!.toLowerCase()))
          ;
    }).toList();
  }

  Future resetFilter_Discount() async {
    filterdLst_Discount.clear();
    filterdLst_Discount = bllHR_Discount.lstHR_Discount;
  }

  discount_bloc() : super(hr_StateInitial()) {
    on<hr_event>((event, emit) async {
      if (event is getListDiscount_Event) {
        await getList_Discount(conditions: event.conditions);
        emit(getListDiscount_StateDataChanged(filterdLst_Discount: filterdLst_Discount));
      }
      else if (event is filterAnyDiscount_Event) {
        await filterAny_Discount(filterData: event.filterData);
        emit(getListDiscount_StateDataChanged(filterdLst_Discount: filterdLst_Discount));
      } else if (event is resetFilterDiscount_Event) {
        await resetFilter_Discount();
        emit(getListDiscount_StateDataChanged(filterdLst_Discount: filterdLst_Discount));
      }
    });
  }
}

class withdrwals_bloc extends Bloc<hr_event, hr_state> {
  static late withdrwals_bloc instance;

  static withdrwals_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<withdrwals_bloc>(context);
    return instance;
  }

  List<HR_Withdrwals> filterdLst_withdrwals = [];
  List<DropDowenDataSource> LstwithdrwalsAsDataSource = [];

  Future getList_withdrwals({List<BLLCondions>? conditions}) async {
    try {
      filterdLst_withdrwals = await bllHR_Withdrwals.fire_getListWithConditions(conditions: conditions);
    } catch (error) {
      print(error.toString());
    }
  }

  filterAny_withdrwals({String? filterData}) {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_withdrwals();
    }
    filterdLst_withdrwals = bllHR_Withdrwals.lstHR_Withdrwals.where((item) {

      String branchName = company_bloc.instance.getNameByID(item.IDBranch);
      String employeeName = employee_bloc.instance.getNameByID(item.IDEmployee);
      String jobName = job_bloc.instance.getNameByID(item.IDJob);
      String departmentName = sections_bloc.instance.getNameByID(item.IDDepartment);

      return (item.Code == null ? false : item.Code!.toString().toLowerCase().contains(filterData!.toLowerCase())) ||
          (branchName.isEmpty ? false : branchName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (employeeName.isEmpty ? false : employeeName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (jobName.isEmpty ? false : jobName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (departmentName.isEmpty ? false : departmentName.toLowerCase().contains(filterData!.toLowerCase())) ||
         (item.Time == null ? false : item.Time!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Value == null ? false : item.Value.toString().contains(filterData!.toLowerCase())) ||
          (item.Date == null ? false : item.Date!.toLowerCase().contains(filterData!.toLowerCase()))
      ;
    }).toList();
  }

  Future resetFilter_withdrwals() async {
    filterdLst_withdrwals.clear();
    filterdLst_withdrwals = bllHR_Withdrwals.lstHR_Withdrwals;
  }

  withdrwals_bloc() : super(hr_StateInitial()) {
    on<hr_event>((event, emit) async {
      if (event is getListWithdrwals_Event) {
        await getList_withdrwals(conditions: event.conditions);
        emit(getListWithdrwals_StateDataChanged(filterdLst_Withdrwals: filterdLst_withdrwals));
      }
      else if (event is filterAnyWithdrwals_Event) {
        await filterAny_withdrwals(filterData: event.filterData);
        emit(getListWithdrwals_StateDataChanged(filterdLst_Withdrwals: filterdLst_withdrwals));
      } else if (event is resetFilterWithdrwals_Event) {
        await resetFilter_withdrwals();
        emit(getListWithdrwals_StateDataChanged(filterdLst_Withdrwals: filterdLst_withdrwals));
      }
    });
  }
}
