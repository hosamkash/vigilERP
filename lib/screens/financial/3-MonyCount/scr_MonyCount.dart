import 'package:flutter/material.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/componants/ctr_DropDowenList.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/shared/sharedFunctions.dart';
import 'package:vigil_erp/shared/shared_controls.dart';
import '../../../componants/ctr_Date.dart';
import '../../../componants/ctr_SelectEmployee.dart';
import '../../../componants/ctr_Time.dart';

class scr_MonyCount extends StatefulWidget {
  scr_MonyCount({super.key});

  @override
  State<scr_MonyCount> createState() => _scr_MonyCountState();
}

class _scr_MonyCountState extends State<scr_MonyCount> {
  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  int? branchID;
  TextEditingController contDate = TextEditingController();
  TextEditingController contTime = TextEditingController();
  TimeOfDay? timeWorkFrom;
  TextEditingController contBalanceTreasure = TextEditingController();
  TextEditingController contSumm = TextEditingController();
  TextEditingController contNetValue = TextEditingController();
  TextEditingController cont200 = TextEditingController();
  TextEditingController cont200TotalValue = TextEditingController();
  TextEditingController cont100 = TextEditingController();
  TextEditingController cont100TotalValue = TextEditingController();
  TextEditingController cont50 = TextEditingController();
  TextEditingController cont50TotalValue = TextEditingController();
  TextEditingController cont20 = TextEditingController();
  TextEditingController cont20TotalValue = TextEditingController();
  TextEditingController cont10 = TextEditingController();
  TextEditingController cont10TotalValue = TextEditingController();
  TextEditingController cont5 = TextEditingController();
  TextEditingController cont5TotalValue = TextEditingController();
  TextEditingController cont1 = TextEditingController();
  TextEditingController cont1TotalValue = TextEditingController();
  var frmKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: buildCustomBar(),
        titleSpacing: 20,
        actions: [
          // const SizedBox(width: 210),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_forward),
          ),
          // const SizedBox(width: 100),
        ],
      ),
      drawer: sharedControls.buildMainMenu(context),
      body: Container(
        color: Colors.white,
        child: buildPageContent(),
      ),
    );
  }

  Widget buildPageContent() {
    return Form(
      key: frmKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ctr_TextHeaderPage(
              text: 'عد ومطابقة النقدية',
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ctr_DropDowenList(
                    hintLable: 'الفرع',
                    padding: EdgeInsets.only(right: 5, left: 5),
                    lstDataSource: company_bloc.instance.LstBranchesAsDataSource,
                    hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                    itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                    menuMaxHeightValue: 300,
                    showClearIcon: true,
                    selectedValue: branchID,
                    OnChanged: (returnID) {
                      branchID = returnID;
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ctr_Date(
                    text: 'التاريخ',
                    dtController: contDate,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    isReadOnly: true,
                    isOpenSelectorOnTap: true,
                    OnChanged: (val) {
                      return val;
                    },
                  ),
                ),
                Expanded(
                  child: ctr_Time(
                    text: 'الساعة',
                    dtController: contTime,
                    padding: EdgeInsets.only(right: 0, left: 5),
                    isReadOnly: true,
                    isVisibleSearchIcon: false,
                    isOpenSelectorOnTap: true,
                    selectedTime: timeWorkFrom,
                    OnChanged: (val) {
                      timeWorkFrom = val;
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: cont200,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    Lable: 'عدد فئة 200',
                    TextType: const TextInputType.numberWithOptions(decimal: false),
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    isdigitsOnly: true,
                    OnChanged: (val) {
                      cont200TotalValue.text = (val == null || val.isEmpty) ? '0' : val;
                      cont200TotalValue.text = (double.parse(cont200TotalValue.text) * 200).toStringAsFixed(2);
                      calcSummion();
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: cont200TotalValue,
                    padding: EdgeInsets.only(right: 0, left: 5),
                    Lable: 'الإجمالى',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: cont100,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    Lable: 'عدد فئة 100',
                    TextType: const TextInputType.numberWithOptions(decimal: false),
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    isdigitsOnly: true,
                    OnChanged: (val) {
                      cont100TotalValue.text = (val == null || val.isEmpty) ? '0' : val;
                      cont100TotalValue.text = (double.parse(cont100TotalValue.text) * 100).toStringAsFixed(2);
                      calcSummion();
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: cont100TotalValue,
                    padding: EdgeInsets.only(right: 0, left: 5),
                    Lable: 'الإجمالى',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: cont50,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    Lable: 'عدد فئة 50',
                    TextType: const TextInputType.numberWithOptions(decimal: false),
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    isdigitsOnly: true,
                    OnChanged: (val) {
                      cont50TotalValue.text = (val == null || val.isEmpty) ? '0' : val;
                      cont50TotalValue.text = (double.parse(cont50TotalValue.text) * 50).toStringAsFixed(2);
                      calcSummion();
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: cont50TotalValue,
                    padding: EdgeInsets.only(right: 0, left: 5),
                    Lable: 'الإجمالى',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: cont20,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    Lable: 'عدد فئة 20',
                    TextType: const TextInputType.numberWithOptions(decimal: false),
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    isdigitsOnly: true,
                    OnChanged: (val) {
                      cont20TotalValue.text = (val == null || val.isEmpty) ? '0' : val;
                      cont20TotalValue.text = (double.parse(cont20TotalValue.text) * 20).toStringAsFixed(2);
                      calcSummion();
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: cont20TotalValue,
                    padding: EdgeInsets.only(right: 0, left: 5),
                    Lable: 'الإجمالى',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: cont10,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    Lable: 'عدد فئة 10',
                    TextType: const TextInputType.numberWithOptions(decimal: false),
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    isdigitsOnly: true,
                    OnChanged: (val) {
                      cont10TotalValue.text = (val == null || val.isEmpty) ? '0' : val;
                      cont10TotalValue.text = (double.parse(cont10TotalValue.text) * 10).toStringAsFixed(2);
                      calcSummion();
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: cont10TotalValue,
                    padding: EdgeInsets.only(right: 0, left: 5),
                    Lable: 'الإجمالى',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: cont5,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    Lable: 'عدد فئة 5',
                    TextType: const TextInputType.numberWithOptions(decimal: false),
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    isdigitsOnly: true,
                    OnChanged: (val) {
                      cont5TotalValue.text = (val == null || val.isEmpty) ? '0' : val;
                      cont5TotalValue.text = (double.parse(cont5TotalValue.text) * 5).toStringAsFixed(2);
                      calcSummion();
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: cont5TotalValue,
                    padding: EdgeInsets.only(right: 0, left: 5),
                    Lable: 'الإجمالى',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: cont1,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    Lable: 'عدد فئة 1',
                    TextType: const TextInputType.numberWithOptions(decimal: false),
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    isdigitsOnly: true,
                    OnChanged: (val) {
                      cont1TotalValue.text = (val == null || val.isEmpty) ? '0' : val;
                      cont1TotalValue.text = (double.parse(cont1TotalValue.text) * 1).toStringAsFixed(2);
                      calcSummion();
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: cont1TotalValue,
                    padding: EdgeInsets.only(right: 0, left: 5),
                    Lable: 'الإجمالى',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: contBalanceTreasure,
                    padding: EdgeInsets.only(right: 5, left: 0),
                    Lable: 'رصيد الخزينة',
                    TextType: TextInputType.number,
                    readOnly: true,
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: contSumm,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    Lable: 'الإجمالى',
                    TextType: const TextInputType.numberWithOptions(decimal: false),
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    isdigitsOnly: true,
                    readOnly: true,
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: contNetValue,
                    padding: EdgeInsets.only(right: 0, left: 5),
                    Lable: 'الصافى',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    readOnly: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    loadDataFromDB();
    clearCachedData();
  }

  Future loadDataFromDB() async {
    await company_bloc.instance.getLstBranchesAsDataSource();
    contDate.text = sharedFunctions_Dates.convertToShortDateString(DateTime.now());
    contTime.text = sharedFunctions_Dates.convertDateTime_TimeString(DateTime.now());
  }

  Widget buildCustomBar() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.save,
            color: Colors.blue[900],
            size: 30,
          ),
          padding: EdgeInsets.only(right: 5, left: 0),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.cancel,
            color: Colors.red[700],
            size: 30,
          ),
          padding: EdgeInsets.only(right: 0, left: 5),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.print,
            color: Colors.purple,
            size: 30,
          ),
          padding: EdgeInsets.only(right: 0, left: 5),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.share,
            color: Colors.green,
            size: 30,
          ),
          padding: EdgeInsets.only(right: 0, left: 5),
        ),
      ],
    );
  }

  void clearCachedData() {
    ctr_SelectEmployee.branchID = branchID = null;
    contDate.text = contTime.text = contSumm.text = contNetValue.text = '';
  }

  void calcSummion() {
    contBalanceTreasure.text = (contBalanceTreasure.text.isEmpty) ? '0' : contBalanceTreasure.text;
    cont200TotalValue.text = (cont200TotalValue.text.isEmpty) ? '0' : cont200TotalValue.text;
    cont100TotalValue.text = (cont100TotalValue.text.isEmpty) ? '0' : cont100TotalValue.text;
    cont50TotalValue.text = (cont50TotalValue.text.isEmpty) ? '0' : cont50TotalValue.text;
    cont20TotalValue.text = (cont20TotalValue.text.isEmpty) ? '0' : cont20TotalValue.text;
    cont10TotalValue.text = (cont10TotalValue.text.isEmpty) ? '0' : cont10TotalValue.text;
    cont5TotalValue.text = (cont5TotalValue.text.isEmpty) ? '0' : cont5TotalValue.text;
    cont1TotalValue.text = (cont1TotalValue.text.isEmpty) ? '0' : cont1TotalValue.text;

    contSumm.text = (double.parse(cont200TotalValue.text) +
            double.parse(cont100TotalValue.text) +
            double.parse(cont50TotalValue.text) +
            double.parse(cont20TotalValue.text) +
            double.parse(cont10TotalValue.text) +
            double.parse(cont5TotalValue.text) +
            double.parse(cont1TotalValue.text))
        .toStringAsFixed(2);
    contNetValue.text = (double.parse(contBalanceTreasure.text) - double.parse(contSumm.text)).toStringAsFixed(2);
  }
}
