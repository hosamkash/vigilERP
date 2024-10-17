import 'package:flutter/material.dart';
import 'package:vigil_erp/screens/Inventory/1-PermissionAdd/scr_PermissionAddView.dart';
import 'package:vigil_erp/screens/Inventory/10-ProductsQty/scr_ProductsQtyView.dart';
import 'package:vigil_erp/screens/Inventory/2-PermissionDiscount/scr_PermissionDiscountView.dart';
import 'package:vigil_erp/screens/Inventory/3-Settlement/scr_SettlementView.dart';
import 'package:vigil_erp/screens/Inventory/4-Transfer/scr_TransferView.dart';
import 'package:vigil_erp/screens/Inventory/5-RecivedQty/scr_RecivedQtyView.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

class scr_StocksTools extends StatelessWidget {
   scr_StocksTools({super.key});

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
          decoration:
          BoxDecoration(color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
          border: Border.all(color: Colors.pink , width: 3 ),
          )
          ,
          child: const Text(
            'المخازن',
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
              // InkWell(
              //   onTap: () async {
              //     // sharedControls.navigatTo(context, scr_InvoicesRepresentView());
              //   },
              //   child: Container(
              //     decoration: const BoxDecoration(
              //       color: Colors.pink,
              //       borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
              //     ),
              //     child: const Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(
              //           Icons.home,
              //           color: Colors.white,
              //           size: 40,
              //         ),
              //         Text(
              //           'حد الطلب للأصناف',
              //           textAlign: TextAlign.center,
              //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              //           maxLines: 2,
              //           overflow: TextOverflow.ellipsis,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: () async {
              //     // sharedControls.navigatTo(context, scr_InvoicesRepresentView());
              //   },
              //   child: Container(
              //     decoration: const BoxDecoration(
              //       color: Colors.pink,
              //       borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
              //     ),
              //     child: const Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(
              //           Icons.home,
              //           color: Colors.white,
              //           size: 40,
              //         ),
              //         Text(
              //           'طلبات النواقص',
              //           textAlign: TextAlign.center,
              //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              //           maxLines: 2,
              //           overflow: TextOverflow.ellipsis,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              InkWell(
                onTap: () async {
                    sharedControls.navigatTo(context, scr_PermissionAddView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.pink,
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
                        'إذن إضافة',
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
                  sharedControls.navigatTo(context, scr_PermissionDiscountView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.pink,
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
                        'إذن خصم',
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
                  sharedControls.navigatTo(context, scr_SettlementView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.pink,
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
                        'تسويات الأصناف',
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
                   sharedControls.navigatTo(context, scr_ProductsQtyView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.pink,
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
                        'الجرد المستمر',
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
                   sharedControls.navigatTo(context, scr_TransferView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.pink,
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
                        'التحويل بين المخازن',
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
                   sharedControls.navigatTo(context, scr_RecivedQtyView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.pink,
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
                        'إستلام تحويل أصناف',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              // InkWell(
              //   onTap: () async {
              //     // sharedControls.navigatTo(context, scr_InvoicesRepresentView());
              //   },
              //   child: Container(
              //     decoration: const BoxDecoration(
              //       color: Colors.pink,
              //       borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
              //     ),
              //     child: const Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(
              //           Icons.home,
              //           color: Colors.white,
              //           size: 40,
              //         ),
              //         Text(
              //           'كارت الأصناف',
              //           textAlign: TextAlign.center,
              //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              //           maxLines: 2,
              //           overflow: TextOverflow.ellipsis,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: () async {
              //     // sharedControls.navigatTo(context, scr_InvoicesRepresentView());
              //   },
              //   child: Container(
              //     decoration: const BoxDecoration(
              //       color: Colors.pink,
              //       borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
              //     ),
              //     child: const Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(
              //           Icons.home,
              //           color: Colors.white,
              //           size: 40,
              //         ),
              //         Text(
              //           'الجرد اليومي',
              //           textAlign: TextAlign.center,
              //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              //           maxLines: 2,
              //           overflow: TextOverflow.ellipsis,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
