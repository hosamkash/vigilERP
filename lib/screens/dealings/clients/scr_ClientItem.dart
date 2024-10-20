import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../bll/bllFirebase/bllDealing_Clients.dart';
import '../../../bll/classModel/Dealing_Clients.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../blocManagment/blocDefinition/definition_bloc.dart';
import '../../../blocManagment/blocFixTables/fix_table_bloc.dart';
import '../../../componants/ctr_Address.dart';
import '../../../componants/ctr_ContactsListFromMobile.dart';
import '../../../componants/ctr_ContactsNumber.dart';
import '../../../componants/ctr_DropDowenList.dart';
import '../../../componants/ctr_TabBar.dart';
import '../../../componants/ctr_TextFormField.dart';
import '../../../componants/ctr_TextHeaderPage.dart';
import '../../../shared/enumerators.dart';
import '../../../shared/sharedFunctions.dart';
import '../../../shared/shared_controls.dart';

class scr_ClientItem extends StatefulWidget {
  scr_ClientItem(this.itemClients, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  Dealing_Clients? itemClients;
  en_FormMode frmMode;

  @override
  State<scr_ClientItem> createState() => _scr_ClientItemState();
}

class _scr_ClientItemState extends State<scr_ClientItem> {
  GoogleMapController? mapController;
  LatLng currentLocation = LatLng(0, 0);
  bool isLoading = true;
  Position? position;

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
    return SingleChildScrollView(
      child: Form(
        key: frmKey,
        child: Column(
          children: [
            ctr_TextHeaderPage(
              text: 'بيانات العميل',
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
            ),
            ElevatedButton.icon(
                label: Text(
                  'إستيراد من دليل الهاتف',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[800]),
                ),
                icon: Icon(Icons.contact_phone, color: Colors.blue[800]),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
                onPressed: () async {
                  // sharedFunctions_ContactsPhone.openContactsPicker();

                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ctr_ContactsListFromMobile(),
                    ),
                  );

                  if (result != null) {
                    contName.text = (result as Contact).displayName!;
                    contNote.text = result.androidAccountName!;
                    if (result.phones != null && result.phones!.length == 1) {
                      contMobile.text = (result).phones!.first.value.toString();
                    } else if ((result).phones != null && result.phones!.length >= 2) {
                      contMobile.text = result.phones![0].value.toString();
                      contMobile.text = result.phones![1].value.toString();
                    }
                  }
                }),
            const SizedBox(height: 5),
            ctr_DropDowenList(
              hintLable: 'الفرع',
              padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
              lstDataSource: company_bloc.instance.LstBranchesAsDataSource,
              hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
              itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
              menuMaxHeightValue: 300,
              showClearIcon: true,
              selectedValue: branchID,
              OnChanged: (returnID) {
                branchID = returnID;
                return branchID;
              },
              OnValidate: (value) {
                if (value == null) {
                  return 'لابد من إختيار قيمة';
                }
                return null;
              },
            ),
            ctr_TextFormField(
              Controller: contName,
              padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
              TextType: TextInputType.text,
              TextAlignValue: TextAlign.end,
              Lable: 'الإســــم',
              autoSelectData: true,
              OnValidate: (value) {
                if (value == null || value.isEmpty) return 'لابد من إدخال قيمة';
                return null;
              },
            ),
            SizedBox(
              height: 470,
              child: Card(
                color: Colors.grey[100],
                child: ctr_TabBar(
                  LstTabBarViewHeaderWidget: const [
                    Text(
                      'الشخصية',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'العنوان',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'اللوكيشن',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                  LstTabBarViewWidget: [
                    buildMainData(),
                    ctr_Address(),
                    // buildAddress(),
                    buildLocationMap(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMainData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 150,
                child: ctr_TextFormField(
                  Controller: contCode,
                  Lable: 'الكود',
                  padding: EdgeInsets.only(right: 5, left: 5),
                  TextType: TextInputType.number,
                  OnValidate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لابد من إدخال قيمة';
                    }
                    return null;
                  },
                ),
              ),
              Checkbox(
                  value: chkIsActive,
                  onChanged: (value) {
                    setState(() {
                      chkIsActive = !chkIsActive;
                    });
                  }),
              const Text('نشط', style: TextStyle(fontSize: 17)),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ctr_ContactsNumber(
                  Controller: contMobile,
                  padding: EdgeInsets.only(right: 5, left: 2, top: 0, bottom: 5),
                  TextAlignValue: TextAlign.center,
                  Lable: 'الموبيل',
                  autoSelectData: true,
                ),
              ),
              Expanded(
                child: ctr_ContactsNumber(
                  Controller: contPhone,
                  padding: EdgeInsets.only(right: 5, left: 2, top: 0, bottom: 5),
                  TextAlignValue: TextAlign.center,
                  Lable: 'الهاتف',
                  autoSelectData: true,
                ),
              ),
            ],
          ),
          ctr_DropDowenList(
            hintLable: 'فئة السعر',
            padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
            lstDataSource: priceType_bloc.instance.lstPriceTypeAsDataSource,
            hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
            itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
            menuMaxHeightValue: 300,
            // selectedValue: priceTypeID,
            OnChanged: (returnID) {
              priceTypeID = returnID;
              return priceTypeID;
            },
          ),
          ctr_TextFormField(
            Controller: contCreditLimit,
            padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
            TextType: TextInputType.phone,
            TextAlignValue: TextAlign.center,
            Lable: 'الحد الإئتماني',
            autoSelectData: true,
          ),
          Row(
            children: [
              Expanded(
                child: ctr_TextFormField(
                  Controller: contCurrentBalance,
                  padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                  TextType: TextInputType.phone,
                  TextAlignValue: TextAlign.center,
                  Lable: 'الرصيد الحالى',
                  autoSelectData: true,
                ),
              ),
              Expanded(
                child: ctr_DropDowenList(
                  hintLable: 'الحالة',
                  padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                  lstDataSource: balanceType_bloc.instance.lstBalanceTypeAsDataSource,
                  hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                  itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                  menuMaxHeightValue: 300,
                  selectedValue: balanceTypeID,
                  OnChanged: (returnID) {
                    balanceTypeID = returnID;
                    return balanceTypeID;
                  },
                ),
              ),
            ],
          ),
          ctr_TextFormField(
            Controller: contNote,
            padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
            TextType: TextInputType.phone,
            TextAlignValue: TextAlign.center,
            Lable: 'ملاحظات',
            autoSelectData: true,
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget buildLocationMap() {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                // ctr_AlertDialog.showListFilter(context,
                //     backgroundColor: Colors.white,
                //     elevation: 3,
                //     barrierDismissible: true,
                //     useSafeArea: true,
                //     content: Center(child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         CircularProgressIndicator(),
                //       ],
                //     )));

                position = await sharedFunctions_Location.getCurrentLocation_Silent();
                if (position != null) {
                  contLocationLatitude.text = position!.latitude.toString();
                  contLocationLongitude.text = position!.longitude.toString();
                  contLocationLink.text =
                      'https://www.google.com/maps/search/?api=1&query=${contLocationLatitude.text},${contLocationLongitude.text}';
                  ;
                }
              },
              label: Text(
                'الحصول على اللوكيشن',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              icon: Icon(Icons.map),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
            ),
            IconButton(
                onPressed: () {
                  contLocationLink.clear();
                  contLocationLatitude.clear();
                  contLocationLongitude.clear();
                },
                icon: Icon(
                  Icons.clear,
                  color: Colors.red,
                  size: 30,
                )),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: ctr_TextFormField(
                Controller: contLocationLatitude,
                padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                TextType: TextInputType.phone,
                TextAlignValue: TextAlign.center,
                Lable: 'خط العرض',
                readOnly: true,
              ),
            ),
            Expanded(
              child: ctr_TextFormField(
                Controller: contLocationLongitude,
                padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
                TextType: TextInputType.phone,
                TextAlignValue: TextAlign.center,
                Lable: 'خط الطول',
                readOnly: true,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 80,
          child: ctr_TextFormField(
            Controller: contLocationLink,
            padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 0),
            TextType: TextInputType.multiline,
            TextAlignValue: TextAlign.center,
            Lable: 'اللوكيشن على الخريطة',
            minLines: 3,
            maxLines: null,
            readOnly: true,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () async {
            if (contLocationLatitude.text.isNotEmpty && contLocationLongitude.text.isNotEmpty) {
              sharedFunctions_Location.openGoogleMaps(double.parse(contLocationLatitude.text), double.parse(contLocationLongitude.text));
            }
          },
          label: Text(
            'فتح الخريطة',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          icon: Icon(Icons.map),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  int? branchID;
  bool chkIsActive = true;
  TextEditingController contCode = TextEditingController();
  TextEditingController contName = TextEditingController();
  TextEditingController contMobile = TextEditingController();
  TextEditingController contPhone = TextEditingController();
  TextEditingController contAddress = TextEditingController();
  int? priceTypeID;
  TextEditingController contCreditLimit = TextEditingController();
  TextEditingController contCurrentBalance = TextEditingController();
  TextEditingController contLocationLink = TextEditingController();
  TextEditingController contLocationLatitude = TextEditingController();
  TextEditingController contLocationLongitude = TextEditingController();
  TextEditingController contLocationImage = TextEditingController();
  int? balanceTypeID;
  TextEditingController contNote = TextEditingController();

  var frmKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.frmMode == en_FormMode.NewMode)
      NewMode();
    else if (widget.frmMode == en_FormMode.EditMode) EditMode();
  }

  Widget buildCustomBar() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            saveData();
          },
          icon: Icon(
            Icons.save,
            color: Colors.blue[900],
            size: 30,
          ),
          padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 0),
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
          padding: EdgeInsets.only(right: 0, left: 5, top: 0, bottom: 0),
        ),
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

  void NewMode() async {
    bllDealing_Clients.getMax_firestore(enTable_Dealing_Clients.Code).then((val) {
      contCode.text = val.toString();
    }).toString();

    // branchID =
    // company_bloc.instance.LstBranchesAsDataSource.isNotEmpty ? company_bloc.instance.LstBranchesAsDataSource.first.valueMember : null;
    // priceTypeID = job_bloc.instance.LstJobsAsDataSource.isNotEmpty ? job_bloc.instance.LstJobsAsDataSource.first.valueMember : null;
    chkIsActive = true;
  }

  void EditMode() {
    if (widget.itemClients != null) {
      branchID = widget.itemClients!.IDBranch;
      chkIsActive = widget.itemClients!.IsActive!;
      contCode.text = widget.itemClients!.Code.toString();
      contName.text = widget.itemClients!.Name!;
      contPhone.text = widget.itemClients!.Phone!;
      contMobile.text = widget.itemClients!.Mobile!;
      contAddress.text = widget.itemClients!.Address!;
      priceTypeID = widget.itemClients!.IDPriceType;
      contCreditLimit.text = widget.itemClients!.CreditLimit.toString();
      contCurrentBalance.text = widget.itemClients!.CurrentBalance.toString();
      balanceTypeID = widget.itemClients!.BalanceType;
      contNote.text = widget.itemClients!.Note!;
      contLocationLatitude.text = widget.itemClients!.LocationLatitude != null ? widget.itemClients!.LocationLatitude.toString() : '';
      contLocationLongitude.text = widget.itemClients!.LocationLongitude != null ? widget.itemClients!.LocationLongitude.toString() : '';
      contLocationLink.text = widget.itemClients!.LocationLink!;
    }
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      int maxID = 0;
      //************************** New
      if (widget.frmMode == en_FormMode.NewMode) {
        maxID = await bllDealing_Clients.getMaxID_firestore();
        widget.itemClients = Dealing_Clients(
          ID: maxID,
        );
      }
      //************************** Edit
      else if (widget.frmMode == en_FormMode.EditMode) {
        maxID = widget.itemClients!.ID!;
      }

      widget.itemClients!.IDBranch = branchID;
      widget.itemClients!.IsActive = chkIsActive;
      widget.itemClients!.Code = int.parse(contCode.text);
      widget.itemClients!.Name = contName.text;
      widget.itemClients!.Phone = contPhone.text;
      widget.itemClients!.Mobile = contMobile.text;
      widget.itemClients!.Address = contAddress.text;
      widget.itemClients!.IDPriceType = priceTypeID;
      widget.itemClients!.CreditLimit = contCreditLimit.text.isNotEmpty ? double.parse(contCreditLimit.text) : 0;
      widget.itemClients!.CurrentBalance = contCurrentBalance.text.isNotEmpty ? double.parse(contCurrentBalance.text) : 0;
      widget.itemClients!.BalanceType = balanceTypeID;
      widget.itemClients!.Note = contNote.text;
      widget.itemClients!.LocationLatitude =
          contLocationLatitude.text.isNotEmpty && contLocationLatitude.text.isNotEmpty ? double.parse(contLocationLatitude.text) : null;
      widget.itemClients!.LocationLongitude =
          contLocationLongitude.text.isNotEmpty && contLocationLongitude.text.isNotEmpty ? double.parse(contLocationLongitude.text) : null;
      widget.itemClients!.LocationLink = contLocationLink.text;
      widget.itemClients!.LocationImage = '';
      await bllDealing_Clients.fire_SetItem(maxID.toString(), widget.itemClients!);
      Navigator.pop(context, true);
    }
  }
}
