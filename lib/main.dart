import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vigil_erp/screens/mainFiles/scr_Boarding.dart';
import 'package:vigil_erp/shared/sharedDesigne.dart';
import 'package:vigil_erp/shared/sharedHive.dart';
import 'blocManagment/blocConnectivity/connectivity_bloc.dart';
import 'blocManagment/blocDealing/dealing_bloc.dart';
import 'blocManagment/blocDefinition/definition_bloc.dart';
import 'blocManagment/blocFixTables/fix_table_bloc.dart';
import 'blocManagment/blocHR/hr_bloc.dart';
import 'blocManagment/blocInventory/inv_bloc.dart';
import 'blocManagment/blocInvoices/invoic_bloc.dart';
import 'blocManagment/bloc_Financial/financial_bloc.dart';
import 'blocManagment/general/cubitGeneral.dart';
import 'blocManagment/general/cubitStates.dart';
import 'blocManagment/general/myBlocObserver.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: true,
  );
  Bloc.observer = myBlocObserver();
  sharedHive.initial();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => connectivity_Bloc()),
        BlocProvider(create: (context) => company_bloc()),
        BlocProvider(create: (context) => unit_bloc()),
        BlocProvider(create: (context) => productionCom_bloc()),
        BlocProvider(create: (context) => cubitGeneral()),
        BlocProvider(create: (context) => religions_bloc()),
        BlocProvider(create: (context) => categories_bloc()),
        BlocProvider(create: (context) => job_bloc()),
        BlocProvider(create: (context) => financialCluses_bloc()),
        BlocProvider(create: (context) => sections_bloc()),
        BlocProvider(create: (context) => stock_bloc()),
        BlocProvider(create: (context) => treasure_bloc()),
        BlocProvider(create: (context) => product_bloc()),
        BlocProvider(create: (context) => employee_bloc()),
        BlocProvider(create: (context) => client_bloc()),
        BlocProvider(create: (context) => priceType_bloc()),
        BlocProvider(create: (context) => balanceType_bloc()),
        BlocProvider(create: (context) => vendor_bloc()),
        BlocProvider(create: (context) => maritalStatus_bloc()),
        BlocProvider(create: (context) => militaryStatus_bloc()),
        BlocProvider(create: (context) => gender_bloc()),
        BlocProvider(create: (context) => user_bloc()),
        BlocProvider(create: (context) => productQty_bloc()),
        BlocProvider(create: (context) => permissionAdd_bloc()),
        BlocProvider(create: (context) => permissionDiscount_bloc()),
        BlocProvider(create: (context) => settlement_bloc()),
        BlocProvider(create: (context) => requestStatus_bloc()),
        BlocProvider(create: (context) => address_bloc()),
        BlocProvider(create: (context) => transfer_bloc()),
        BlocProvider(create: (context) => recived_bloc()),
        BlocProvider(create: (context) => purchase_bloc()),
        BlocProvider(create: (context) => sales_bloc()),
        BlocProvider(create: (context) => purchaseReturned_bloc()),
        BlocProvider(create: (context) => salesReturned_bloc()),
        BlocProvider(create: (context) => bonusType_bloc()),
        BlocProvider(create: (context) => bonus_bloc()),
        BlocProvider(create: (context) => discount_bloc()),
        BlocProvider(create: (context) => withdrwals_bloc()),
        BlocProvider(create: (context) => advances_bloc()),
        BlocProvider(create: (context) => dealingType_bloc()),
        BlocProvider(create: (context) => financialType_bloc()),
        BlocProvider(create: (context) => exchange_bloc()),
        BlocProvider(create: (context) => supplay_bloc()),
      ],
      child: BlocConsumer<cubitGeneral, cubitStates>(
        listener: (context, state) => state_InitialApp(),
        builder: (context, state) {
          //*************************************

          religions_bloc.cretaeInctance(context);
          company_bloc.cretaeInctance(context);
          unit_bloc.cretaeInctance(context);
          productionCom_bloc.cretaeInctance(context);
          categories_bloc.cretaeInctance(context);
          job_bloc.cretaeInctance(context);
          financialCluses_bloc.cretaeInctance(context);
          sections_bloc.cretaeInctance(context);
          stock_bloc.cretaeInctance(context);
          treasure_bloc.cretaeInctance(context);
          product_bloc.cretaeInctance(context);
          employee_bloc.cretaeInctance(context);
          client_bloc.cretaeInctance(context);
          priceType_bloc.cretaeInctance(context);
          balanceType_bloc.cretaeInctance(context);
          vendor_bloc.cretaeInctance(context);
          maritalStatus_bloc.cretaeInctance(context);
          militaryStatus_bloc.cretaeInctance(context);
          gender_bloc.cretaeInctance(context);
          user_bloc.cretaeInctance(context);
          productQty_bloc.cretaeInctance(context);
          permissionAdd_bloc.cretaeInctance(context);
          permissionDiscount_bloc.cretaeInctance(context);
          settlement_bloc.cretaeInctance(context);
          requestStatus_bloc.cretaeInctance(context);
          address_bloc.cretaeInctance(context);
          transfer_bloc.cretaeInctance(context);
          recived_bloc.cretaeInctance(context);
          purchase_bloc.cretaeInctance(context);
          sales_bloc.cretaeInctance(context);
          purchaseReturned_bloc.cretaeInctance(context);
          salesReturned_bloc.cretaeInctance(context);
          bonusType_bloc.cretaeInctance(context);
          bonus_bloc.cretaeInctance(context);
          discount_bloc.cretaeInctance(context);
          withdrwals_bloc.cretaeInctance(context);
          advances_bloc.cretaeInctance(context);
          dealingType_bloc.cretaeInctance(context);
          financialType_bloc.cretaeInctance(context);
          exchange_bloc.cretaeInctance(context);
          supplay_bloc.cretaeInctance(context);

          //*************************************
          cubitGeneral.get(context);

          return MaterialApp(
            locale: Locale('ar'),
            // Set locale to Arabic for RTL
            supportedLocales: const [
              Locale('en'), // English
              Locale('ar'), // Arabic
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: sharedDesigne.colorScheme,
            ),
            home: scr_Boarding(),
          );
        },
      ),

    );
  }
}
