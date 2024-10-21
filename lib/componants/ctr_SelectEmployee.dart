import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bll/classModel/Dealing_Employees.dart';
import '../blocManagment/blocDealing/dealing_bloc.dart';
import '../blocManagment/blocDefinition/definition_bloc.dart';

class TextEditingController_Employee extends TextEditingController {
  Dealing_Employees? selectEmployee;

  TextEditingController_Employee({this.selectEmployee});
}

class ctr_SelectEmployee extends StatefulWidget {
  List<Dealing_Employees> lstEmployee = [];
  static int? branchID;

  @override
  _ctr_SelectEmployeeState createState() => _ctr_SelectEmployeeState();

  TextEditingController_Employee? Controller = TextEditingController_Employee();
  TextEditingController filterController = TextEditingController();
  double? widthControl;
  EdgeInsets? padding;
  Icon? suffixIcon;
  Icon? prefixIcon;
  String? labelText;
  TextStyle? labelStyle;
  late bool isOpenSelectorOnTap;
  Color?  colorBorder;
  // double? height;
  final void Function(Dealing_Employees) onSelectEmployee;
  late String? Function(String?)? OnValidate;

  ctr_SelectEmployee({
    this.Controller,
    this.widthControl,
    this.padding,
    this.suffixIcon,
    this.prefixIcon,
    this.labelText,
    this.labelStyle,
    this.colorBorder,
    this.isOpenSelectorOnTap = false,
    // this.height = 50,
    required this.onSelectEmployee,
    this.OnValidate,
  });
}

class _ctr_SelectEmployeeState extends State<ctr_SelectEmployee> {
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
                    border:  OutlineInputBorder(),
                    enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: widget.colorBorder ?? Colors.black)),
                    focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: widget.colorBorder ?? Colors.black)),
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
                        });
                      },
                      icon: widget.suffixIcon ?? const Icon(Icons.clear),
                      color: Colors.black,
                    ),
                  ),
                  validator: widget.OnValidate,
                  // validator: (val) {
                  //   setState(() {
                  //     if (val == null) {
                  //       widget.height = widget.height! + 15;
                  //     } else
                  //       widget.height = 50;
                  //   });
                  //   return widget.OnValidate != null ? widget.OnValidate!(val) : null;
                  // },

                  onTap: widget.isOpenSelectorOnTap ? showDialogEmployeesFilter : null,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialogEmployeesFilter();
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

  buildListViewItem(Dealing_Employees item) {
    return InkWell(
      onTap: () {
        widget.onSelectEmployee(item);
        widget.Controller!.text = item.Name!;
        widget.Controller?.selectEmployee = item;
        Navigator.of(context).pop();
      },
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Text('${item.Code} - ', style: const TextStyle(fontSize: 17)),
                const SizedBox(width: 10),
                Text(
                  item.Name.toString(),
                  style: const TextStyle(fontSize: 17),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Row(
              children: [
                Text(job_bloc.instance.getNameByID(item.IDJob), style: const TextStyle(fontSize: 17)),
                const SizedBox(width: 10),
                Text(company_bloc.instance.getNameByID(item.IDBranch), style: const TextStyle(fontSize: 17)),
                // Text(cubitDefinitions.objCubit.getNameCompanyByID(item.IDBranch), style: const TextStyle(fontSize: 17)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showDialogEmployeesFilter() async {
    if (employee_bloc.instance.filterdLst_Employee.length == 0) {
      employee_bloc.instance.add(getListEmployee_Event());
    }

    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Text('البحث فى الموظفين'),
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
                    employee_bloc.instance.add(resetFilterEmployee_Event());
                  },
                  icon: widget.prefixIcon ?? const Icon(Icons.clear),
                  color: Colors.black,
                ),
              ),
              onChanged: (value) {
                employee_bloc.instance.add(filterAnyEmployee_Event(filterData: value.trim()));
              },
            ),
            SizedBox(
              height: 400,
              child: BlocBuilder<employee_bloc, dealing_state>(
                builder: (context, state) {
                  if (state is getListEmployee_StateDataChanged) {
                    // فلتر الموظفين بالفرع الحالى وابقاء أصل اللسته كما هي واستخدام نتيجة الفلتر فقط
                    widget.lstEmployee = state.filterdLst_Employee.where((item) {
                      return item.IDBranch == ctr_SelectEmployee.branchID;
                    }).toList();

                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildListViewItem(widget.lstEmployee[index]);
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 1),
                      itemCount: widget.lstEmployee.length,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
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

    // if (employee_bloc.instance.filterdLst_Employee.length == 0) {
    //   employee_bloc.instance.add(getListEmployee_Event());
    // }
  }
}
