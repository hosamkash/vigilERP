import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/bll/bllFirebase/bllFix_Address_DistrictArea.dart';
import 'package:vigil_erp/bll/classModel/Fix_Address_DistrictArea.dart';
import 'package:vigil_erp/componants/ctr_DropDowenList.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/shared/shared_controls.dart';
import '../../../blocManagment/blocFixTables/fix_table_bloc.dart';
import '../../../shared/enumerators.dart';

class scr_AddressArea extends StatefulWidget {
  scr_AddressArea({super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  @override
  State<scr_AddressArea> createState() => _scr_AddressAreaState();
}

class _scr_AddressAreaState extends State<scr_AddressArea> {
  TextEditingController contName = TextEditingController();

  var frmKey = GlobalKey<FormState>();
  List<DropDowenDataSource> lst_GovernmentAsDataSource = [];
  List<DropDowenDataSource> lst_CityAsDataSource = [];
  int? governmentID;
  int? cityID;
  en_FormMode frmMode = en_FormMode.NewMode;
  Fix_Address_DistrictArea? itemArea;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: buildCustomBar(),
        titleSpacing: 70,
        actions: [
          // const SizedBox(width: 210),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_forward)),
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
      child: Column(
        children: [
          SizedBox(
            height: 45,
            child: ctr_TextHeaderPage(
              text: 'تعريف الأحياء - المناطق',
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
            ),
          ),
          const SizedBox(height: 5),

          //************************ الأحياء - المناطق **************************
          BlocBuilder<address_bloc, fixTable_state>(builder: (context, state) {
            bool isGov = state is getListAddressGovernment_State;
            lst_GovernmentAsDataSource = isGov ? state.lst_AddressGovernmentAsDataSource : lst_GovernmentAsDataSource;

            bool isCity = state is getListAddressCityAsDataSource_State;
            lst_CityAsDataSource = isCity ? state.lst_AddressCityAsDataSource : lst_CityAsDataSource;

            return Column(
              children: [
                SizedBox(
                  height: 55,
                  child: ctr_DropDowenList(
                    hintLable: 'المحافظة',
                    padding: EdgeInsets.only(right: 5, left: 5),
                    lstDataSource: lst_GovernmentAsDataSource,
                    hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                    itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                    menuMaxHeightValue: 300,
                    showClearIcon: false,
                    selectedValue: governmentID,
                    OnChanged: (returnID) {
                      governmentID = returnID;
                      address_bloc.instance.add(getListAddressCityAsDataSource_Event(governmentID: governmentID));
                      return governmentID;
                    },
                  ),
                ),
                SizedBox(
                  height: 55,
                  child: ctr_DropDowenList(
                    hintLable: 'المدينة',
                    padding: EdgeInsets.only(right: 5, left: 5),
                    lstDataSource: lst_CityAsDataSource,
                    hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                    itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                    menuMaxHeightValue: 300,
                    showClearIcon: false,
                    selectedValue: cityID,
                    OnChanged: (returnID) {
                      cityID = returnID;
                      address_bloc.instance.add(getListAddressArea_Event(cityID: cityID));
                      return cityID;
                    },
                  ),
                ),
              ],
            );
          }),

          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: contName,
                    padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
                    TextType: TextInputType.text,
                    TextAlignValue: TextAlign.end,
                    Lable: 'الحي - المنطقة',
                    OnValidate: (value) {
                      if (value == null || value.isEmpty) return 'لابد من إدخال قيمة';
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 45,
                  child: IconButton(
                    onPressed: () {
                      saveData();
                      frmMode = en_FormMode.NewMode;
                    },
                    icon: Icon(
                      Icons.save,
                      color: Colors.blue[900],
                      size: 30,
                    ),
                    padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 0),
                  ),
                ),
                SizedBox(
                  width: 45,
                  child: IconButton(
                    onPressed: () {
                      contName.clear();
                      frmMode = en_FormMode.NewMode;
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Colors.red[700],
                      size: 30,
                    ),
                    padding: EdgeInsets.only(right: 0, left: 5, top: 0, bottom: 0),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SizedBox(
              height: 400,
              width: 350,
              child: buildListView(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListView(BuildContext context) {
    return BlocBuilder<address_bloc, fixTable_state>(
      builder: (context, state) {
        if (state is address_StateInitial) {
          const LinearProgressIndicator(minHeight: 6);
          return const Center(child: CircularProgressIndicator());
        } else if (state is getListAddressArea_State) {
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
                  itemBuilder: (context, index) {
                    return buildListViewItem(state.lst_AddressArea[index], context);
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 1),
                  itemCount: state.lst_AddressArea.length,
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  buildListViewItem(Fix_Address_DistrictArea item, context) {
    return Column(
      children: [
        Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        InkWell(
          onDoubleTap: () {
            itemArea = item;
            editItem();
          },
          child: SizedBox(
            height: 22,
            child: Row(
              children: [
                SizedBox(
                  width: 250,
                  child: Text(
                    item.Name ?? '',
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      InkWell(
                        child: Icon(Icons.edit, color: Colors.blue),
                        onTap: () {
                          itemArea = item;
                          editItem();
                        },
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        child: Icon(Icons.delete, color: Colors.red[700]),
                        onTap: () => deleteItem(item),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    address_bloc.instance.add(getListAddressGovernment_Event());
    address_bloc.instance.getLst_AddressGovernmentAsDataSource();
  }

  Widget buildCustomBar() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.print,
            color: Colors.purple,
            size: 30,
          ),
          padding: EdgeInsets.only(right: 0, left: 5, top: 0, bottom: 0),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.share,
            color: Colors.green,
            size: 30,
          ),
          padding: EdgeInsets.only(right: 0, left: 5, top: 0, bottom: 0),
        ),
      ],
    );
  }

  void newMode() async {}

  void editItem() {
    frmMode = en_FormMode.EditMode;
    contName.text = itemArea!.Name!;
  }

  void deleteItem(Fix_Address_DistrictArea itemCity) async {
    await bllFix_Address_DistrictArea.fire_DeleteItem(itemArea!.ID.toString());
    // address_bloc.instance.lst_AddressCity.remove(itemCity);
    address_bloc.instance.add(getListAddressArea_Event(cityID: itemArea!.CityID));
    contName.clear();
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      int maxID = 0;

      //************************** New
      if (frmMode == en_FormMode.NewMode) {
        maxID = await bllFix_Address_DistrictArea.getMax_firestore(enTable_Fix_Address_DistrictArea.ID);
        itemArea = Fix_Address_DistrictArea(ID: maxID);
      }
      //************************** Edit
      else if (frmMode == en_FormMode.EditMode) {
        maxID = itemArea!.ID!;
      }
      itemArea!.Name = contName.text;
      itemArea!.CityID = cityID;
      await bllFix_Address_DistrictArea.fire_SetItem(maxID.toString(), itemArea!);

      address_bloc.instance.add(getListAddressArea_Event(cityID: cityID));
      contName.clear();
    }
  }
}
