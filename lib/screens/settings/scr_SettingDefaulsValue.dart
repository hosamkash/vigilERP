import 'package:flutter/material.dart';
import 'package:vigil_erp/bll/bllFirebase/bllDealing_Clients.dart';
import 'package:vigil_erp/bll/bllFirebase/bllDealing_Employees.dart';
import 'package:vigil_erp/bll/bllFirebase/bllDealing_Users.dart';
import 'package:vigil_erp/bll/bllFirebase/bllDealing_Vendors.dart';
import 'package:vigil_erp/bll/bllFirebase/bllDef_CompanyStructure.dart';
import 'package:vigil_erp/bll/bllFirebase/bllDef_FinancialCluses.dart';
import 'package:vigil_erp/bll/bllFirebase/bllDef_ProductStructure.dart';
import 'package:vigil_erp/bll/bllFirebase/bllDef_ProductionCompanies.dart';
import 'package:vigil_erp/bll/bllFirebase/bllDef_Sections.dart';
import 'package:vigil_erp/bll/bllFirebase/bllDef_Stocks.dart';
import 'package:vigil_erp/bll/bllFirebase/bllDef_Treasures.dart';
import 'package:vigil_erp/bll/bllFirebase/bllFix_BounsType.dart';
import 'package:vigil_erp/bll/classModel/Def_Categories.dart';
import 'package:vigil_erp/bll/classModel/Def_Units.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/sharedFunctions.dart';
import '../../bll/bllFirebase/bllDef_Categories.dart';
import '../../bll/bllFirebase/bllDef_Units.dart';
import '../../bll/bllFirebase/bllFix_Address_Government.dart';
import '../../bll/bllFirebase/bllFix_BalanceType.dart';
import '../../bll/bllFirebase/bllFix_DocumentsType.dart';
import '../../bll/bllFirebase/bllFix_FinacialType.dart';
import '../../bll/bllFirebase/bllFix_Gender.dart';
import '../../bll/bllFirebase/bllFix_MaritalStatus.dart';
import '../../bll/bllFirebase/bllFix_MilitaryStatus.dart';
import '../../bll/bllFirebase/bllFix_Monthes.dart';
import '../../bll/bllFirebase/bllFix_PriceType.dart';
import '../../bll/bllFirebase/bllFix_Religions.dart';
import '../../bll/bllFirebase/bllFix_RequestStatus.dart';
import '../../bll/classModel/Dealing_Clients.dart';
import '../../bll/classModel/Dealing_Employees.dart';
import '../../bll/classModel/Dealing_Users.dart';
import '../../bll/classModel/Dealing_Vendors.dart';
import '../../bll/classModel/Def_CompanyStructure.dart';
import '../../bll/classModel/Def_FinancialCluses.dart';
import '../../bll/classModel/Def_ProductStructure.dart';
import '../../bll/classModel/Def_ProductionCompanies.dart';
import '../../bll/classModel/Def_Sections.dart';
import '../../bll/classModel/Def_Stocks.dart';
import '../../bll/classModel/Def_Treasures.dart';
import '../../bll/classModel/Fix_Address_Government.dart';
import '../../bll/classModel/Fix_BalanceType.dart';
import '../../bll/classModel/Fix_BounsType.dart';
import '../../bll/classModel/Fix_DocumentsType.dart';
import '../../bll/classModel/Fix_FinacialType.dart';
import '../../bll/classModel/Fix_Gender.dart';
import '../../bll/classModel/Fix_MaritalStatus.dart';
import '../../bll/classModel/Fix_MilitaryStatus.dart';
import '../../bll/classModel/Fix_Monthes.dart';
import '../../bll/classModel/Fix_PriceType.dart';
import '../../bll/classModel/Fix_Religions.dart';
import '../../bll/classModel/Fix_RequestStatus.dart';

class scr_SettingDefaulsValue extends StatefulWidget {
  scr_SettingDefaulsValue(this.showAppBar, {super.key});

  bool showAppBar = false;

  @override
  State<scr_SettingDefaulsValue> createState() => _scr_SettingDefaulsValueState();
}

class _scr_SettingDefaulsValueState extends State<scr_SettingDefaulsValue> {
  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  TextEditingController controllerfilter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,

      //******************************* App Bar *************************************

      appBar: widget.showAppBar
          ? AppBar(
              backgroundColor: Colors.white,
              leading: Container(),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_forward)),
              ],
            )
          : null,
      // drawer: sharedControls.BuildMainMenu(context),

      body: buildPageContent(),
    );
  }

  Widget buildPageContent() {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: ctr_TextHeaderPage(
              text: 'إعدادات الجداول الثابته',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
            )),
            const SizedBox(height: 10),
            //نوع سندات النقدية Finacial Type
            ElevatedButton.icon(
              label: const Text(
                'نوع سندات النقدية Finacial Type',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              icon: const Icon(Icons.monetization_on_outlined),
              iconAlignment: IconAlignment.start,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
              onPressed: () {
                // bllFix_FinacialType.fire_DeleteCollection();
                bllFix_FinacialType.fire_SetItem(en_finacialType.finacialTypeExchange.name, Fix_FinacialType(ID: 1, Name: 'بند دفع'));

                bllFix_FinacialType.fire_SetItem(en_finacialType.finacialTypeSupplay.name, Fix_FinacialType(ID: 2, Name: 'بند قبض'));
              },
            ),

            //نوع سعر الأصناف Price Type
            ElevatedButton.icon(
              label: const Text(
                'نوع سعر الأصناف Price Type',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              icon: const Icon(Icons.monetization_on_outlined),
              iconAlignment: IconAlignment.start,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
              onPressed: () {
                // bllFix_PriceType.fire_DeleteCollection();
                bllFix_PriceType.fire_SetItem(en_PriceType.purchasePrice.name, Fix_PriceType(ID: 1, Name: 'سعر الشراء'));

                bllFix_PriceType.fire_SetItem(en_PriceType.salesPrice1.name, Fix_PriceType(ID: 2, Name: 'سعر بيع 1'));

                bllFix_PriceType.fire_SetItem(en_PriceType.salesPrice2.name, Fix_PriceType(ID: 3, Name: 'سعر بيع 2'));

                bllFix_PriceType.fire_SetItem(en_PriceType.salesPrice3.name, Fix_PriceType(ID: 4, Name: 'سعر بيع 3'));

                bllFix_PriceType.fire_SetItem(en_PriceType.salesPrice4.name, Fix_PriceType(ID: 5, Name: 'سعر بيع 4'));

                bllFix_PriceType.fire_SetItem(en_PriceType.salesPrice5.name, Fix_PriceType(ID: 6, Name: 'سعر بيع 5'));
              },
            ),

            //حالة الرصيد Balance Type
            ElevatedButton.icon(
              label: const Text(
                'حالة الرصيد Balance Type',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              icon: const Icon(Icons.monetization_on_outlined),
              iconAlignment: IconAlignment.start,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
              onPressed: () {
                // bllFix_BalanceType.fire_DeleteCollection();
                bllFix_BalanceType.fire_SetItem(en_BalanceType.debit_Madeen_Aleh.name, Fix_BalanceType(ID: 1, Name: 'مدين (عليه)'));

                bllFix_BalanceType.fire_SetItem(en_BalanceType.credit_Daeen_Loh.name, Fix_BalanceType(ID: 2, Name: 'دائن (له)'));
              },
            ),

            //الحالة الإجتماعية MaritalStatus
            ElevatedButton.icon(
              label: const Text(
                'الحالة الإجتماعية MaritalStatus',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              icon: const Icon(Icons.monetization_on_outlined),
              iconAlignment: IconAlignment.start,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
              onPressed: () {
                // bllFix_MaritalStatus.fire_DeleteCollection();
                bllFix_MaritalStatus.fire_SetItem(en_MaritalStatus.singel.name, Fix_MaritalStatus(ID: 1, Name: 'اعزب'));
                bllFix_MaritalStatus.fire_SetItem(en_MaritalStatus.married.name, Fix_MaritalStatus(ID: 2, Name: 'متزوج'));
                bllFix_MaritalStatus.fire_SetItem(en_MaritalStatus.marriedWithChildren.name, Fix_MaritalStatus(ID: 3, Name: 'متزوج ويعول'));
                bllFix_MaritalStatus.fire_SetItem(en_MaritalStatus.armal.name, Fix_MaritalStatus(ID: 4, Name: 'ارمل'));
                bllFix_MaritalStatus.fire_SetItem(en_MaritalStatus.motallak.name, Fix_MaritalStatus(ID: 5, Name: 'مطلق'));
              },
            ),

            //حالة التجنيد MilitaryStatus
            ElevatedButton.icon(
              label: const Text(
                'حالة التجنيد MilitaryStatus',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              icon: const Icon(Icons.monetization_on_outlined),
              iconAlignment: IconAlignment.start,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
              onPressed: () {
                // bllFix_MilitaryStatus.fire_DeleteCollection();
                bllFix_MilitaryStatus.fire_SetItem(en_MilitaryStatus.exempt.name, Fix_MilitaryStatus(ID: 1, Name: 'معفى '));
                bllFix_MilitaryStatus.fire_SetItem(en_MilitaryStatus.postponement.name, Fix_MilitaryStatus(ID: 2, Name: 'تأجيل'));
                bllFix_MilitaryStatus.fire_SetItem(en_MilitaryStatus.ending.name, Fix_MilitaryStatus(ID: 3, Name: 'إنهاء الخدمة'));
              },
            ),

            //النوع Gender
            ElevatedButton.icon(
              label: const Text(
                'النوع Gender',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              icon: const Icon(Icons.generating_tokens),
              iconAlignment: IconAlignment.start,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
              onPressed: () {
                // bllFix_Gender.fire_DeleteCollection();
                bllFix_Gender.fire_SetItem(en_Gender.male.name, Fix_Gender(ID: 1, Name: 'ذكر'));
                bllFix_Gender.fire_SetItem(en_Gender.female.name, Fix_Gender(ID: 2, Name: 'أنثى'));
                bllFix_Gender.fire_SetItem(en_Gender.undefined.name, Fix_Gender(ID: 3, Name: 'غير محدد'));
              },
            ),

            //الديانة Religions
            ElevatedButton.icon(
              label: const Text(
                'الديانة Religions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              icon: const Icon(Icons.monetization_on_outlined),
              iconAlignment: IconAlignment.start,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
              onPressed: () {
                // bllFix_Gender.fire_DeleteCollection();
                bllFix_Religions.fire_SetItem(en_Religions.muslim.name, Fix_Religions(ID: 1, Name: 'مسلم'));
                bllFix_Religions.fire_SetItem(en_Religions.misihy.name, Fix_Religions(ID: 2, Name: 'مسيحي'));
                bllFix_Religions.fire_SetItem(en_Religions.undefined.name, Fix_Religions(ID: 3, Name: 'غير محدد'));
              },
            ),

            // شهور السنة Monthes
            ElevatedButton.icon(
              label: const Text(
                'شهور السنة Monthes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              icon: const Icon(Icons.calendar_month),
              iconAlignment: IconAlignment.start,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
              onPressed: () {
                bllFix_Monthes.fire_SetItem(en_Monthes.January.name, Fix_Monthes(ID: 1, Name: '1 - يناير'));
                bllFix_Monthes.fire_SetItem(en_Monthes.February.name, Fix_Monthes(ID: 2, Name: '2 - فبراير'));
                bllFix_Monthes.fire_SetItem(en_Monthes.March.name, Fix_Monthes(ID: 3, Name: '3 -مارس'));
                bllFix_Monthes.fire_SetItem(en_Monthes.April.name, Fix_Monthes(ID: 4, Name: '4 - ابريل'));
                bllFix_Monthes.fire_SetItem(en_Monthes.May.name, Fix_Monthes(ID: 5, Name: '5 - مايو'));
                bllFix_Monthes.fire_SetItem(en_Monthes.June.name, Fix_Monthes(ID: 6, Name: '6 - يونيو'));
                bllFix_Monthes.fire_SetItem(en_Monthes.July.name, Fix_Monthes(ID: 7, Name: '7 - يوليو'));
                bllFix_Monthes.fire_SetItem(en_Monthes.August.name, Fix_Monthes(ID: 8, Name: '8 - اغسطس'));
                bllFix_Monthes.fire_SetItem(en_Monthes.September.name, Fix_Monthes(ID: 9, Name: '9 - سبتمبر'));
                bllFix_Monthes.fire_SetItem(en_Monthes.October.name, Fix_Monthes(ID: 10, Name: '10 - اكتوبر'));
                bllFix_Monthes.fire_SetItem(en_Monthes.November.name, Fix_Monthes(ID: 11, Name: '11 - نوفمبر'));
                bllFix_Monthes.fire_SetItem(en_Monthes.December.name, Fix_Monthes(ID: 12, Name: '12 - ديسمبر'));
              },
            ),

            // حالة المستندات Request Status
            ElevatedButton.icon(
              label: const Text(
                'حالة المستندات Request Status',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              icon: const Icon(Icons.real_estate_agent),
              iconAlignment: IconAlignment.start,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
              onPressed: () {
                bllFix_RequestStatus.fire_SetItem(en_RequestStatus.OnDemand.name, Fix_RequestStatus(ID: 1, Name: 'قيد الطلب'));
                bllFix_RequestStatus.fire_SetItem(en_RequestStatus.RequestCompleted.name, Fix_RequestStatus(ID: 2, Name: 'تم إنهاء الطلب'));
                bllFix_RequestStatus.fire_SetItem(en_RequestStatus.UnderReview.name, Fix_RequestStatus(ID: 3, Name: 'قيد المراجعة'));
                bllFix_RequestStatus.fire_SetItem(en_RequestStatus.ReviewError.name, Fix_RequestStatus(ID: 4, Name: 'خطأ فى المراجعة'));
                bllFix_RequestStatus.fire_SetItem(en_RequestStatus.Preparing.name, Fix_RequestStatus(ID: 5, Name: 'قيد التجهيز'));
                bllFix_RequestStatus.fire_SetItem(en_RequestStatus.SuccessfullyPrepared.name, Fix_RequestStatus(ID: 6, Name: 'تم التجهيز بنجاح'));
                bllFix_RequestStatus.fire_SetItem(en_RequestStatus.PreparedWithNotes.name, Fix_RequestStatus(ID: 7, Name: 'تم التجهيز مع ملاحظات'));
                bllFix_RequestStatus.fire_SetItem(en_RequestStatus.PreparedIncomplete.name, Fix_RequestStatus(ID: 8, Name: 'تم التجهيز - ناقص'));
                bllFix_RequestStatus.fire_SetItem(en_RequestStatus.Sending.name, Fix_RequestStatus(ID: 9, Name: 'قيد الإرسال'));
                bllFix_RequestStatus.fire_SetItem(en_RequestStatus.Sent.name, Fix_RequestStatus(ID: 10, Name: 'تم الإرسال'));
                bllFix_RequestStatus.fire_SetItem(en_RequestStatus.ReceivedReview.name, Fix_RequestStatus(ID: 11, Name: 'قيد مراجعة الإستلام'));
                bllFix_RequestStatus.fire_SetItem(en_RequestStatus.Received.name, Fix_RequestStatus(ID: 12, Name: 'تم الإستلام'));
                // bllFix_RequestStatus.fire_SetItem(
                //     en_RequestStatus.ReceivedWithCorrection.name, Fix_RequestStatus(ID: 13, Name: 'تم الإستلام مع التصحيح'));
              },
            ),

            // Documents Type نوع المستندات
            ElevatedButton.icon(
              label: const Text(
                'Documents Type نوع المستندات',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              icon: const Icon(Icons.real_estate_agent),
              iconAlignment: IconAlignment.start,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
              onPressed: () {
                bllFix_DocumentsType.fire_SetItem(en_DocumentType.permissionAdd.name, Fix_DocumentsType(ID: 1, Name: 'إذن إضافة'));
                bllFix_DocumentsType.fire_SetItem(en_DocumentType.permissionDiscount.name, Fix_DocumentsType(ID: 2, Name: 'إذن خصم'));
              },
            ),

            // المحافظات - Government
            ElevatedButton.icon(
              label: const Text(
                'المحافظات - Government',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              icon: const Icon(Icons.calendar_month),
              iconAlignment: IconAlignment.start,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
              onPressed: () {
                bllFix_Address_Government.fire_SetItem('1', Fix_Address_Government(ID: 1, Name: 'القاهرة'));
                bllFix_Address_Government.fire_SetItem('2', Fix_Address_Government(ID: 2, Name: 'الجيزة'));
                bllFix_Address_Government.fire_SetItem('3', Fix_Address_Government(ID: 3, Name: 'الإسكندرية'));
                bllFix_Address_Government.fire_SetItem('4', Fix_Address_Government(ID: 4, Name: 'الشرقية'));
                bllFix_Address_Government.fire_SetItem('5', Fix_Address_Government(ID: 5, Name: 'القليوبية'));
                bllFix_Address_Government.fire_SetItem('6', Fix_Address_Government(ID: 6, Name: 'الدقهلية'));
                bllFix_Address_Government.fire_SetItem('7', Fix_Address_Government(ID: 7, Name: 'الغربية'));
                bllFix_Address_Government.fire_SetItem('8', Fix_Address_Government(ID: 8, Name: 'المنوفية'));
                bllFix_Address_Government.fire_SetItem('9', Fix_Address_Government(ID: 9, Name: 'الفيوم'));
                bllFix_Address_Government.fire_SetItem('10', Fix_Address_Government(ID: 10, Name: 'بني سويف'));
                bllFix_Address_Government.fire_SetItem('11', Fix_Address_Government(ID: 11, Name: 'المنيا'));
                bllFix_Address_Government.fire_SetItem('12', Fix_Address_Government(ID: 12, Name: 'أسيوط'));
                bllFix_Address_Government.fire_SetItem('13', Fix_Address_Government(ID: 13, Name: 'سوهاج'));
                bllFix_Address_Government.fire_SetItem('14', Fix_Address_Government(ID: 14, Name: 'قنا'));
                bllFix_Address_Government.fire_SetItem('15', Fix_Address_Government(ID: 15, Name: 'الأقصر'));
                bllFix_Address_Government.fire_SetItem('16', Fix_Address_Government(ID: 16, Name: 'أسوان'));
                bllFix_Address_Government.fire_SetItem('17', Fix_Address_Government(ID: 17, Name: 'البحر الأحمر'));
                bllFix_Address_Government.fire_SetItem('18', Fix_Address_Government(ID: 18, Name: 'البحيرة'));
                bllFix_Address_Government.fire_SetItem('19', Fix_Address_Government(ID: 19, Name: 'مطروح'));
                bllFix_Address_Government.fire_SetItem('20', Fix_Address_Government(ID: 20, Name: 'كفر الشيخ'));
                bllFix_Address_Government.fire_SetItem('21', Fix_Address_Government(ID: 21, Name: 'الوادى الجديد'));
                bllFix_Address_Government.fire_SetItem('22', Fix_Address_Government(ID: 22, Name: 'جنوب سيناء'));
                bllFix_Address_Government.fire_SetItem('23', Fix_Address_Government(ID: 23, Name: 'شمال سيناء'));
                bllFix_Address_Government.fire_SetItem('24', Fix_Address_Government(ID: 24, Name: 'السويس'));
                bllFix_Address_Government.fire_SetItem('25', Fix_Address_Government(ID: 25, Name: 'الإسماعيلية'));
                bllFix_Address_Government.fire_SetItem('26', Fix_Address_Government(ID: 26, Name: 'بورسعيد'));
                bllFix_Address_Government.fire_SetItem('27', Fix_Address_Government(ID: 27, Name: 'دمياط'));
              },
            ),

            // نوع المكافئة - Bonus Type
            ElevatedButton.icon(
              label: const Text(
                ' نوع المكافئة - Bonus Type',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              icon: const Icon(Icons.calendar_month),
              iconAlignment: IconAlignment.start,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
              onPressed: () {
                bllFix_BounsType.fire_SetItem('1', Fix_BounsType(ID: 1, Name: 'قيمة'));
                bllFix_BounsType.fire_SetItem('2', Fix_BounsType(ID: 2, Name: 'يوم'));

              },
            ),

            // // المركز - المدينة - Fix_Address_City
            // ElevatedButton.icon(
            //   label: const Text(
            //     'المركز - المدينة - Address City',
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            //   ),
            //   icon: const Icon(Icons.calendar_month),
            //   iconAlignment: IconAlignment.start,
            //   style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
            //   onPressed: () {
            //     // 1. القاهرة
            //     bllFix_Address_City.fire_SetItem('1-1', Fix_Address_City(ID: 1, Name: 'مدينة القاهرة', IDGovernment: 1));
            //     bllFix_Address_City.fire_SetItem('1-2', Fix_Address_City(ID: 2, Name: 'حلوان', IDGovernment: 1));
            //     bllFix_Address_City.fire_SetItem('1-3', Fix_Address_City(ID: 3, Name: 'المعادي', IDGovernment: 1));
            //     bllFix_Address_City.fire_SetItem('1-4', Fix_Address_City(ID: 4, Name: '15 مايو', IDGovernment: 1));
            //     bllFix_Address_City.fire_SetItem('1-5', Fix_Address_City(ID: 5, Name: 'مدينة نصر', IDGovernment: 1));
            //
            //     // 2. الجيزة
            //     bllFix_Address_City.fire_SetItem('2-1', Fix_Address_City(ID: 1, Name: 'الجيزة', IDGovernment: 2));
            //     bllFix_Address_City.fire_SetItem('2-2', Fix_Address_City(ID: 2, Name: '6 أكتوبر', IDGovernment: 2));
            //     bllFix_Address_City.fire_SetItem('2-3', Fix_Address_City(ID: 3, Name: 'الشيخ زايد', IDGovernment: 2));
            //     bllFix_Address_City.fire_SetItem('2-4', Fix_Address_City(ID: 4, Name: 'البدرشين', IDGovernment: 2));
            //     bllFix_Address_City.fire_SetItem('2-5', Fix_Address_City(ID: 5, Name: 'الوراق', IDGovernment: 2));
            //   },
            // ),
            //
            // // الحي - المنطفة - Fix_Address_DistrictArea
            // ElevatedButton.icon(
            //   label: const Text(
            //     'الحي - المنطفة - Address DistrictArea',
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            //   ),
            //   icon: const Icon(Icons.calendar_month),
            //   iconAlignment: IconAlignment.start,
            //   style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
            //   onPressed: () {
            //     // 1-1 وسط القاهرة
            //     bllFix_Address_DistrictArea.fire_SetItem('1-1-1', Fix_Address_DistrictArea(ID: 1, Name: 'حي وسط القاهرة', CityID: 1 - 1));
            //     bllFix_Address_DistrictArea.fire_SetItem('1-1-2', Fix_Address_DistrictArea(ID: 2, Name: 'التحرير', CityID: 1 - 1));
            //     bllFix_Address_DistrictArea.fire_SetItem('1-1-3', Fix_Address_DistrictArea(ID: 3, Name: 'عابدين', CityID: 1 - 1));
            //     bllFix_Address_DistrictArea.fire_SetItem('1-1-4', Fix_Address_DistrictArea(ID: 4, Name: 'الأزبكية', CityID: 1 - 1));
            //     bllFix_Address_DistrictArea.fire_SetItem('1-1-5', Fix_Address_DistrictArea(ID: 5, Name: 'باب اللوق', CityID: 1 - 1));
            //
            //     // 1-2 شرق القاهرة
            //     bllFix_Address_DistrictArea.fire_SetItem('1-2-1', Fix_Address_DistrictArea(ID: 1, Name: 'مدينة نصر', CityID: 1 - 2));
            //     bllFix_Address_DistrictArea.fire_SetItem('1-2-2', Fix_Address_DistrictArea(ID: 2, Name: 'مصر الجديدة', CityID: 1 - 2));
            //     bllFix_Address_DistrictArea.fire_SetItem('1-2-3', Fix_Address_DistrictArea(ID: 3, Name: 'هليوبوليس', CityID: 1 - 2));
            //     bllFix_Address_DistrictArea.fire_SetItem('1-2-4', Fix_Address_DistrictArea(ID: 4, Name: 'الشروق', CityID: 1 - 2));
            //   },
            // ),

            Divider(
              color: Colors.blue,
              thickness: 3,
            ),

            // // رفع اللوجو الإفتراضي
            // ElevatedButton.icon(
            //   label: const Text(
            //     'رفع اللوجو الإفتراضي',
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            //   ),
            //   icon: const Icon(Icons.real_estate_agent),
            //   iconAlignment: IconAlignment.start,
            //   style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
            //   onPressed: ()async {
            //    // String url =await bllDef_CompanyStructure.storage_UploadFile('erp_icon',Image.asset('assets/erp_icon.png'));
            //
            //      },
            // ),
            //

            // Defalut Values - التعريفات اللإفتراضية
            ElevatedButton.icon(
              label: Text(
                'Defalut Values - التعريفات اللإفتراضية',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              icon: const Icon(Icons.real_estate_agent, color: Colors.white, size: 30),
              iconAlignment: IconAlignment.start,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[600], elevation: 3),
              onPressed: () {
                // 1 - الشركة
                bllDef_CompanyStructure.fire_SetItem('1',Def_CompanyStructure(ID: 1,Code: 1,Name: 'فيجل',DateCreate: sharedFunctions_Dates.convertToShortDateString(DateTime.now()),isOwner: true,isActive: true));

                // 2 - الوحدة
                bllDef_Units.fire_SetItem('1', Def_Units(ID: 1, Name: 'دستة', IsActive: true));
                bllDef_Units.fire_SetItem('2', Def_Units(ID: 2, Name: 'كرتونة', IsActive: true));
                bllDef_Units.fire_SetItem('3', Def_Units(ID: 3, Name: 'قطعة', IsActive: true));

                // 3 - الشركة المنتجة
                bllDef_ProductionCompanies.fire_SetItem('1', Def_ProductionCompanies(ID: 1, Name: 'مصنع 1', IsActive: true ,IsSalesCategory: true ));
                bllDef_ProductionCompanies.fire_SetItem('1', Def_ProductionCompanies(ID: 1, Name: 'مصنع 2', IsActive: true ,IsSalesCategory: true ));

                // 4 - المخزن
                bllDef_Stocks.fire_SetItem('1', Def_Stocks(ID: 1,Code: 1, Name: 'مخزن إفتراضي', IsActive: true ,IDBranch: 1 , IsBindBranch: true ));

                // 5 - التصنيف
                bllDef_Categories.fire_SetItem('1', Def_Categories(ID: 1, Name: 'تصنيف 1', IsActive: true ,IsSalesCategory: true , IsViewAllProducts: false ));

                // 6 - بنود الماليات
                bllDef_FinancialCluses.fire_SetItem('1', Def_FinancialCluses(ID: 1,Code: 1,  Name: 'بند دفع 1', IsActive: true ,IsViewToRepresent: false , IsDefaultToTransferMony: false, IDFinancialType: 2 ));
                bllDef_FinancialCluses.fire_SetItem('2', Def_FinancialCluses(ID: 2,Code: 2,  Name: 'بند قبض 1', IsActive: true ,IsViewToRepresent: false , IsDefaultToTransferMony: false, IDFinancialType: 1 ));

                // 7 - خزينة نقدية
                bllDef_Treasures.fire_SetItem('1', Def_Treasures(ID: 1,Code: 1, Name: 'خزينة 1', IsActive: true ,IDBranch: 1 , IsBindBranch: true ,Balance: 0));

                // 8 - الإدارات والأقسم
                bllDef_Sections.fire_SetItem('1', Def_Sections(ID: 1, Name: 'الإدارة العليا', IsActive: true));
                bllDef_Sections.fire_SetItem('2', Def_Sections(ID: 2, Name: 'شئون العاملين', IsActive: true));
                bllDef_Sections.fire_SetItem('3', Def_Sections(ID: 3, Name: 'الحسابات', IsActive: true));

                // 9 - وظيفة
                bllDef_Sections.fire_SetItem('1', Def_Sections(ID: 1, Name: 'مدير', IsActive: true));
                bllDef_Sections.fire_SetItem('2', Def_Sections(ID: 2, Name: 'محاسب', IsActive: true));
                bllDef_Sections.fire_SetItem('3', Def_Sections(ID: 3, Name: 'إداري', IsActive: true));

                // 10 - الأصناف
                // TextEditingController x = TextEditingController(text: '1');
                bllDef_ProductStructure.fire_SetItem('1', Def_ProductStructure(ID: 1, Name: 'صنف 1', IsActive: true ,BarCode: 1,
                IDCategory: 1 , IDProductionCompany: 1 , IsPOS: true , IsUpdated: false ,

                Discription: '',LimitedQty: 0,UnitBig_ID: 1,UnitSmall_ID: 3 , UnitCountOf: 12 , UnitBig_PurchasePrice: 0 ,
                UnitBig_Sales1: 0,UnitBig_Sales2: 0,UnitBig_Sales3: 0,UnitBig_Sales4: 0,UnitBig_Sales5: 0,
                UnitSmall_PurchasePrice: 0,UnitSmall_Sales1: 0,UnitSmall_Sales2: 0,UnitSmall_Sales3: 0,
                UnitSmall_Sales4: 0,UnitSmall_Sales5: 0));


              },
            ),

            SizedBox(height: 5),

            // Dealing Views - جهات التعامل
            ElevatedButton.icon(
              label: Text(
                'Dealing Views - جهات التعامل',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              icon: const Icon(Icons.real_estate_agent, color: Colors.white, size: 30),
              iconAlignment: IconAlignment.start,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[600], elevation: 3),
              onPressed: () {
                // 1 - العملاء
                bllDealing_Clients.fire_SetItem('1',Dealing_Clients(ID: 1,Code: 1,Name: '',IsActive: true,IDBranch:1 ,
                  IDPriceType: 2,Address: '',BalanceType: 1 , CreditLimit: 0,CurrentBalance: 0,Mobile: '',Phone: '',Note: '',));

                // 2 - الموردين
                bllDealing_Vendors.fire_SetItem('1',Dealing_Vendors(ID: 1,Code: 1,Name: '',IsActive: true,IDBranch:1 ,
                  Address: '',BalanceType: 1 ,CurrentBalance: 0,Mobile: '',Phone: '',Note: '',));


                // 3 - الموظفين
                bllDealing_Employees.fire_SetItem('1',Dealing_Employees(ID: 1,Code: 1,Name: 'موظف عام',IsActive: true,IDBranch:1 , Address: '',Mobile: '',Phone: '',Age: 0,BirthDate: '',ChildrenCount: 0,CommissionSales1: 0,CommissionSales2: 0,
                CommissionSales3: 0,CommissionSales4: 0,CommissionSales5: 0,CommissionSalesReturned1: 0,CommissionSalesReturned2: 0,
                CommissionSalesReturned3: 0,CommissionSalesReturned4: 0,CommissionSalesReturned5: 0,DailyCommissionExecute: 0,
                DailyCommissionNotExecute: 0,DailyTarget: 0,DateHiring: '',ExpiryDateJob: '',IDDepartment: 1,IDGender: 1,
                IDJob: 1,IDMaritalStatus: 1,IDMilitaryStatus: 1,IDReligions: 1,ImageName: '',ImageURL: '',LeavingReson: '',
                MonthlyCommissionExecute: 0,MonthlyCommissionNotExecute: 0,MonthlyTarget: 0,MonthlyVacationDays: 0,NationalID: '',
                Qualification: '',RelativeMobile1: '',RelativeMobile2: '',RelativeMobile3: '',RelativeMobile4: '',RelativeName1: '',
                RelativeName2: '',RelativeName3: '',RelativeName4: '',RelativeType1: '',RelativeType2: '',RelativeType3: '',
                RelativeType4: '',SalaryDayValue: 0,SalaryHourValue: 0,SalaryMonthValue: 0,SalaryWeekValue: 0,TimeTotalWorkHour: 0,
                TimeWorkFrom: '',TimeWorkTo: '',));

                // 4 - المستخدمين
                bllDealing_Users.fire_SetItem('1',Dealing_Users(ID: 1,Code: 1,Name: 'Usre1',IsActive: true,IDBranch:1 ,
                  Address: '',Mobile: '',Phone: '',Note: '',EMail: '' ,IDEmployeeBind: 1,IsAdminAccount: true , UID: ''));


              },
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
