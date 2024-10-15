import 'package:flutter/material.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

class scr_InvoicesTools extends StatelessWidget {
  scr_InvoicesTools({super.key});

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
              BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                border: Border.all(color: Colors.blue  , width: 3 ),
              ),
          child: const Text(
            'الفواتير',
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
                  // sharedControls.navigatTo(context, scr_InvoicesRepresentView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
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
                        'المشتريات',
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
                  // sharedControls.navigatTo(context, scr_InvoicesRepresentView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
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
                        'مرتجعات المشتريات',
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
                  // sharedControls.navigatTo(context, scr_InvoicesRepresentView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
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
                        'المبيعات',
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
                  // sharedControls.navigatTo(context, scr_InvoicesRepresentView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
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
                        'مرتجعات المبيعات',
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
                  // sharedControls.navigatTo(context, scr_InvoicesRepresentView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
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
                        'مبيعات الأصناف',
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
                  // sharedControls.navigatTo(context, scr_InvoicesRepresentView());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
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
                        'أرباح الفواتير',
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
