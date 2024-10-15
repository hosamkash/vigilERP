import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/blocManagment/general/cubitGeneral.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

class scr_RepresentsTools extends StatelessWidget {
  scr_RepresentsTools({super.key});

  var gridController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: cubitGeneral.instance,
      listener: (context, state) => {},
      builder: (context, state) {
        return Scaffold(
          // appBar: AppBar(),
          drawer: sharedControls.buildMainMenu(context),
          body: buildGridView(context),
        );
      },
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
            border: Border.all(color: Colors.purple, width: 3),
          ),
          child: const Text(
            'مندوبين المبيعات',
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
                  // sharedControls.navigatTo(context, scr_RepInvoicesView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit_document,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        'فواتير المندوبين',
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

                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.request_page,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        'طلبات المندوبين',
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
                onTap: () {
                  // sharedControls.navigatTo(context, scr_RepresentAddDiscountQtyView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        'إضافة سريعة',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sd_card_alert_sharp,
                      color: Colors.white,
                      size: 40,
                    ),
                    Text(
                      'جرد المندوب',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.monetization_on,
                      color: Colors.white,
                      size: 40,
                    ),
                    Text(
                      'مبيعات المندوبين',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calculate,
                      color: Colors.white,
                      size: 40,
                    ),
                    Text(
                      'حساب المستحقات',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.discount,
                      color: Colors.white,
                      size: 40,
                    ),
                    Text(
                      'العروض',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }








}
