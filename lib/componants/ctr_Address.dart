import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocManagment/blocDefinition/definition_bloc.dart';
import '../blocManagment/blocFixTables/fix_table_bloc.dart';
import 'ctr_DropDowenList.dart';
import 'ctr_TextFormField.dart';

class ctr_Address extends StatefulWidget {
  const ctr_Address({super.key});

  @override
  State<ctr_Address> createState() => _ctr_AddressState();
}

class _ctr_AddressState extends State<ctr_Address> {
  int? governmentID;
  int? cityID;

  @override
  void initState() {
    super.initState();

    address_bloc.instance.add(getListAddressGovernment_Event());
    address_bloc.instance.getLst_AddressGovernmentAsDataSource();
  }

  @override
  Widget build(BuildContext context) {
    List<DropDowenDataSource> lst_GovernmentAsDataSource = [];
    List<DropDowenDataSource> lst_CityAsDataSource = [];
    List<DropDowenDataSource> lst_AreaAsDataSource = [];

    return Column(
      children: [
        BlocBuilder<address_bloc, fixTable_state>(
          builder: (context, state) {
            bool isGov = state is getListAddressGovernment_State;
            lst_GovernmentAsDataSource = isGov ? state.lst_AddressGovernmentAsDataSource : lst_GovernmentAsDataSource;

            bool isCity = state is getListAddressCityAsDataSource_State;
            lst_CityAsDataSource = isCity ? state.lst_AddressCityAsDataSource : lst_CityAsDataSource;

            bool isArea = state is getListAddressAreaAsDataSource_State;
            lst_AreaAsDataSource = isArea ? state.lst_AddressAreaAsDataSource : lst_AreaAsDataSource;


            return Column(
              children: [
                //************************ المحافظة **************************
                ctr_DropDowenList(
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
                    address_bloc.instance.add(getListAddressCity_Event(governmentID: governmentID));
                    return governmentID;
                  },
                ),

                //************************ المدن **************************
                ctr_DropDowenList(
                  hintLable: 'المركز - المدينة',
                  padding: EdgeInsets.only(right: 5, left: 5),

                  lstDataSource: lst_CityAsDataSource,
                  hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                  itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                  menuMaxHeightValue: 250,
                  showClearIcon: false,
                  selectedValue: cityID,
                  OnChanged: (returnID) {
                    cityID = returnID;
                    address_bloc.instance.add(getListAddressArea_Event(cityID: cityID));
                    return cityID;
                  },
                ),

                ctr_DropDowenList(
                  hintLable: 'البلد - القرية',
                  padding: EdgeInsets.only(right: 5, left: 5),

                  lstDataSource: lst_AreaAsDataSource,
                  hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                  itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                  menuMaxHeightValue: 300,
                  showClearIcon: false,
                  // selectedValue: branchID,
                  OnChanged: (returnID) {
                    return null;
                  },
                ),


              ],
            );
          },
        ),



        ctr_DropDowenList(
          hintLable: 'الحي - المنطقة',
          padding: EdgeInsets.only(right: 5, left: 5),

          lstDataSource: company_bloc.instance.LstBranchesAsDataSource,
          hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
          itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
          menuMaxHeightValue: 300,
          showClearIcon: false,
          // selectedValue: branchID,
          OnChanged: (returnID) {
            return null;
          },
        ),
        ctr_DropDowenList(
          hintLable: 'المنشأة - جهة العمل',
          padding: EdgeInsets.only(right: 5, left: 5),

          lstDataSource: company_bloc.instance.LstBranchesAsDataSource,
          hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
          itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
          menuMaxHeightValue: 300,
          showClearIcon: false,
          // selectedValue: branchID,
          OnChanged: (returnID) {
            return null;
          },
        ),
        SizedBox(
          height: 80,
          child: ctr_TextFormField(
            // Controller: contAddress,
            padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 0),
            TextType: TextInputType.multiline,
            TextAlignValue: TextAlign.end,
            Lable: 'العنوان',
            autoSelectData: true,
            minLines: 3,
            OnValidate: (value) {
              if (value == null || value.isEmpty) return 'لابد من إدخال قيمة';
              return null;
            },
          ),
        ),
      ],
    );
  }
}
