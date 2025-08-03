import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subul_dashboard2/Features/auth/presentation/views/log_in_view.dart';
import 'package:subul_dashboard2/Features/dashboard/presentation/views/dashboard_view.dart';
import 'package:subul_dashboard2/Features/home_view/home_view.dart';
import 'package:subul_dashboard2/core/utils/service_locator.dart';
import 'package:subul_dashboard2/core/utils/shared_preference_store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initSharedPrefernce();
  setupAuthFeatureLocator();
  setupCountriesFeatureLocator();
  setupParcelsFeatureLocator();
  setupDeliveryStaffLocator();
  setupUserFeatureLocator();
  setupComplaintsFeatureLocator();
  setupComplaintDetailsFeatureLocator();
  setupDashboardFeatureLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1400, 1020), // استخدم نفس الأبعاد من Figma
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(),
              home: const LogInView()
              //  DashboardView(),
              //
              //    const HomeView(),
              );
        });
  }
}
