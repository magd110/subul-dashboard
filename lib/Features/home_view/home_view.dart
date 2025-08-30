import 'package:flutter/material.dart';
import 'package:subul_dashboard2/Features/dashboard/presentation/views/dashboard_view.dart';
import 'package:subul_dashboard2/Features/general_settings/general_settings_view.dart';
import 'package:subul_dashboard2/Features/home_view/widgets/side_bar.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/presentation/views/suppliers_mangment_view.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    // const M(),
    const GeneralSettingsView(),
    SuppliersManagementView(),
    DashboardView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.softGray,
              AppColors.white,
            ],
          ),
        ),
        child: Row(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: SideBar(
                  selectedIndex: _selectedIndex,
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  }),
            ),
            Expanded(child: _screens[_selectedIndex]),
          ],
        ),
      ),
    );
  }
}
