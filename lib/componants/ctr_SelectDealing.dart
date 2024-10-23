import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/bll/classModel/Dealing_Clients.dart';
import 'package:vigil_erp/bll/classModel/Dealing_Vendors.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/shared_controls.dart';
import '../bll/classModel/Dealing_Employees.dart';
import '../blocManagment/blocDealing/dealing_bloc.dart';

class TextEditingController_Dealing extends TextEditingController {
  Dealing_Clients? selectClient;
  Dealing_Vendors? selectVendor;
  Dealing_Employees? selectEmployee;
  String? dalingName;
  int? dalingID;
  int? branch;

  TextEditingController_Dealing({this.selectEmployee, this.selectClient, this.selectVendor, this.dalingName, this.dalingID , this.branch});
}

class ctr_SelectDealing extends StatefulWidget {
  List<Dealing_Clients> lstClients = [];
  List<Dealing_Vendors> lstVendors = [];
  List<Dealing_Employees> lstEmployees = [];

  @override
  _ctr_SelectDealingState createState() => _ctr_SelectDealingState();

  TextEditingController_Dealing? Controller = TextEditingController_Dealing();
  TextEditingController filterController = TextEditingController();
  double? widthControl;
  EdgeInsets? padding;
  Icon? suffixIcon;
  Icon? prefixIcon;
  String? labelText;
  TextStyle? labelStyle;
  late bool isOpenSelectorOnTap;
  Color? colorBorder;
  en_DealingType? dealingType;
  int? currentBranchID;

  final void Function(dynamic dealing)? onSelectDealing;
  late Function()? OnTap;
  late String? Function(String?)? OnValidate;

  ctr_SelectDealing({
    this.Controller,
    this.widthControl,
    this.padding,
    this.suffixIcon,
    this.prefixIcon,
    this.labelText,
    this.labelStyle,
    this.colorBorder,
    this.dealingType,
    this.currentBranchID,
    this.isOpenSelectorOnTap = false,
    // this.height = 50,
    this.onSelectDealing,
    this.OnValidate,
    this.OnTap,
  });
}

class _ctr_SelectDealingState extends State<ctr_SelectDealing> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: widget.padding ?? EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5),
        // height: widget.height ,
        child: SizedBox(
          width: widget.widthControl ?? double.infinity,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: widget.Controller,
                  readOnly: true,
                  style: const TextStyle(fontSize: 17, color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: widget.colorBorder ?? Colors.black)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: widget.colorBorder ?? Colors.black)),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: widget.labelText,
                    labelStyle: widget.labelStyle ?? const TextStyle(fontSize: 17, color: Colors.grey),
                    prefixIcon: widget.prefixIcon,
                    contentPadding: EdgeInsets.symmetric(vertical: 0.3, horizontal: 2),
                    // حشوة داخلية ثابتة
                    disabledBorder: const OutlineInputBorder(),
                    focusColor: Colors.black,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.Controller!.clear();
                          fireEventsToFilterAnyDealings('');
                        });
                      },
                      icon: widget.suffixIcon ?? const Icon(Icons.clear),
                      color: Colors.black,
                    ),
                  ),
                  validator: widget.OnValidate,
                  onTap: () {
                    if (widget.dealingType == null) {
                      sharedControls.toastNotification('لابد من إختيار نوع الجهة والفرع أولاً', false);
                      return;
                    }
                    widget.isOpenSelectorOnTap ? showDialogDealingFilter() : null;
                    return widget.OnTap != null ? widget.OnTap!() : null;
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialogDealingFilter();
                },
                icon: const Icon(Icons.search),
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildListViewItem(dynamic item) {
    return InkWell(
      onTap: () {
        widget.Controller = TextEditingController_Dealing();
        widget.Controller!.text = item.Name!;
        widget.Controller!.dalingName = item.Name!;
        widget.Controller!.dalingID = item.ID!;
        widget.Controller!.branch = item.IDBranch;

        if (widget.dealingType == en_DealingType.Cliens) {
          widget.Controller!.selectClient = item as Dealing_Clients;
          widget.onSelectDealing!(item as Dealing_Clients);
        } else if (widget.dealingType == en_DealingType.Vendors) {
          widget.Controller?.selectVendor = item as Dealing_Vendors;
          widget.onSelectDealing!(item as Dealing_Vendors);
        } else if (widget.dealingType == en_DealingType.Employees) {
          widget.Controller?.selectEmployee = item as Dealing_Employees;
          widget.onSelectDealing!(item as Dealing_Employees);
        }
        Navigator.of(context).pop();
      },
      child: Column(
        children: [
          Divider(endIndent: 0, indent: 0, thickness: 1, color: Colors.grey),
          Row(
            children: [
              Text(
                item.Name.toString(),
                style: const TextStyle(fontSize: 15),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              // const SizedBox(width: 5),
              Spacer(),
              Text(' - ${item.Code}', style: const TextStyle(fontSize: 15)),
              //
              // Text(company_bloc.instance.getNameByID(item.IDBranch), style: const TextStyle(fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }

  void showDialogDealingFilter() async {
    fireEventsToPopulateDealings();

    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Text('البحث فى ' + getDalingTypeName()),
          IconButton(
            onPressed: () {
              // employee_bloc.instance.add(getListEmployee_Event());
            },
            icon: const Icon(Icons.cloud_download_rounded),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      elevation: 3,
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: widget.filterController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: widget.labelText,
                labelStyle: widget.labelStyle ?? const TextStyle(fontSize: 17, color: Colors.grey),
                prefixIcon: widget.suffixIcon,
                suffixIcon: IconButton(
                  onPressed: () {
                    widget.filterController.clear();
                    fireEventsToFilterAnyDealings('');
                    // populateListViewByDealings();
                  },
                  icon: widget.prefixIcon ?? const Icon(Icons.clear),
                  color: Colors.black,
                ),
              ),
              onChanged: (value) {
                fireEventsToFilterAnyDealings(value);
              },
            ),
            SizedBox(
              height: 400,
              child: populateListViewByDealings(),
            ),
          ],
        ),
      ),
    );

    // عرض الـ AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  String getDalingTypeName() {
    if (widget.dealingType == en_DealingType.Cliens)
      return 'العملاء';
    else if (widget.dealingType == en_DealingType.Vendors)
      return 'الموردين';
    else if (widget.dealingType == en_DealingType.Employees)
      return 'الموظفين';
    else
      return '';
  }

  void fireEventsToPopulateDealings() {
    if (widget.dealingType == en_DealingType.Cliens) {
      client_bloc.instance.add(getListClientsOffline_Event(branchID: widget.currentBranchID, filterData: widget.filterController.text.trim()));
    } else if (widget.dealingType == en_DealingType.Vendors) {
      vendor_bloc.instance.add(getListVendorsOffline_Event(branchID: widget.currentBranchID, filterData: widget.filterController.text.trim()));
    } else if (widget.dealingType == en_DealingType.Employees) {
      employee_bloc.instance.add(getListEmployeesOffline_Event(branchID: widget.currentBranchID, filterData: widget.filterController.text.trim()));
    }
  }

  void fireEventsToFilterAnyDealings(String value) {
    if (widget.dealingType == en_DealingType.Cliens) {
      client_bloc.instance.add(getListClientsOffline_Event(branchID: widget.currentBranchID, filterData: widget.filterController.text.trim()));
    } else if (widget.dealingType == en_DealingType.Vendors) {
      vendor_bloc.instance.add(getListVendorsOffline_Event(branchID: widget.currentBranchID, filterData: widget.filterController.text.trim()));
    } else if (widget.dealingType == en_DealingType.Employees) {
      employee_bloc.instance.add(getListClientsOffline_Event(branchID: widget.currentBranchID, filterData: widget.filterController.text.trim()));
    }
  }

  populateListViewByDealings() {
    if (widget.dealingType == en_DealingType.Cliens) {
      return BlocBuilder<client_bloc, dealing_state>(
        builder: (context, state) {
          if (state is getListClientsOffline_State) {
            widget.lstClients = state.listClientsOffline ?? [];
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return buildListViewItem(widget.lstClients[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 1),
              itemCount: widget.lstClients.length,
            );
          } else {
            return Container();
          }
        },
      );
    } else if (widget.dealingType == en_DealingType.Vendors) {
      return BlocBuilder<vendor_bloc, dealing_state>(
        builder: (context, state) {
          if (state is getListVendorsOffline_State) {
            widget.lstVendors = state.listVendorsOffline ?? [];
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return buildListViewItem(widget.lstVendors[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 1),
              itemCount: widget.lstVendors.length,
            );
          } else {
            return Container();
          }
        },
      );
    } else if (widget.dealingType == en_DealingType.Employees) {
      return BlocBuilder<employee_bloc, dealing_state>(
        builder: (context, state) {
          if (state is getListEmployeesOffline_State) {
            widget.lstEmployees = state.listEmployeesOffline ?? [];

            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return buildListViewItem(widget.lstEmployees[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 1),
              itemCount: widget.lstEmployees.length,
            );
          } else {
            return Container();
          }
        },
      );
    } else
      return SizedBox();
  }
}
