import 'package:flutter/material.dart';
import 'package:vigil_erp/screens/definitions/Company/scr_CompanyView.dart';
import 'package:vigil_erp/screens/definitions/ProductionCom/scr_ProductionComView.dart';
import 'package:vigil_erp/screens/definitions/address/scr_AddressArea.dart';
import 'package:vigil_erp/screens/definitions/category/scr_categoryView.dart';
import 'package:vigil_erp/screens/definitions/financialCluses/scr_FinancialClusesView.dart';
import 'package:vigil_erp/screens/definitions/jobs/scr_JobView.dart';
import 'package:vigil_erp/screens/definitions/products/scr_ProductView.dart';
import 'package:vigil_erp/screens/definitions/sections/scr_SectionView.dart';
import 'package:vigil_erp/screens/definitions/stocks/scr_StocksView.dart';
import 'package:vigil_erp/screens/definitions/treasure/scr_TreasureView.dart';
import 'package:vigil_erp/screens/definitions/units/scr_UnitView.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

import '../definitions/address/scr_AddressCity.dart';

class scr_DefinitionsTools extends StatelessWidget {
  scr_DefinitionsTools({super.key});

  var gridController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sharedControls.buildMainMenu(context),
      body: buildGridView(context),
    );
  }

  Widget buildGridView(context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 2, bottom: 2, right: 15, left: 15),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
            border: Border.all(color: Colors.green, width: 3),
          ),
          child: const Text(
            'التعريفات',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            padding: const EdgeInsets.all(10),
            physics: const BouncingScrollPhysics(),
            controller: gridController,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: [
              InkWell(
                onTap: () async {
                   sharedControls.navigatTo(context, scr_CompanyView());
                  //sharedControls.navigatTo(context, scr_employeeView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        'بيانات الشركة',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  sharedControls.navigatTo(context, scr_UnitView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        'الوحدات',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  sharedControls.navigatTo(context, scr_ProductionComView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        'الشركة المنتجة',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                   sharedControls.navigatTo(context, scr_StocksView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        'المخازن',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  sharedControls.navigatTo(context, scr_categoryView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        'التصنيفات',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  sharedControls.navigatTo(context, scr_ProductView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        'الأصناف',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  sharedControls.navigatTo(context, scr_FinancialClusesView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        'بنود الماليات',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  sharedControls.navigatTo(context, scr_TreasureView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        'الخزائن',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  sharedControls.navigatTo(context, scr_SectionView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        'الإدارات وأقسام',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  sharedControls.navigatTo(context, scr_JobView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        'الوظائف',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  sharedControls.navigatTo(context, scr_AddressCity());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        'المدن والمراكز',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  sharedControls.navigatTo(context, scr_AddressArea());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        'الأحياء - المناطق',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ],
    );
  }
}
