import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subul_dashboard2/Features/fixed_cost_managment/presentation/views/fixed_cost_management_view.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/presentation/views/complaints_management_view.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/countries_management_view.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/presentation/views/delivery_staff_management_view.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/widgets/packages_management_view.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/views/user_management_view.dart';
import 'package:subul_dashboard2/Features/shipments/presentation/views/shipment_view.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';
import 'package:subul_dashboard2/core/widgets/text_logo.dart';

class GeneralSettingsView extends StatefulWidget {
  const GeneralSettingsView({super.key});

  @override
  State<GeneralSettingsView> createState() => _GeneralSettingsViewState();
}

class _GeneralSettingsViewState extends State<GeneralSettingsView> {
  int _selectedIndex = 0;

  // Map لتخزين الصفحات بعد إنشائها لأول مرة
  final Map<int, Widget> _loadedPages = {};

  Widget _createPage(int index) {
    late Widget page;
    switch (index) {
      case 0:
        page = const PackagesManagementView();
        break;
      case 1:
        page = const CountriesManagementView();
        break;
      case 2:
        page = const DeliveryStaffManagementView();
        break;
      case 3:
        page = const ComplaintsManagementView();
        break;
      case 4:
        page = const FixedCostManagementView();
        break;
      case 5:
        page = const ShipmentView();
        break;
      case 6:
        page = const UserManagementView();
        break;
      default:
        page = const SizedBox();
    }

    _loadedPages[index] = page; // حفظ الصفحة بعد إنشائها لأول مرة
    return page;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: AppColors.globalBackgroundGradient,
          child: Column(
            children: [
              // العنوان والشعار
              Padding(
                padding: EdgeInsets.fromLTRB(
                  0.0,
                  AppSizes.heightRatio(context, 30),
                  AppSizes.widthRatio(context, 31),
                  0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(child: Text(" ")),
                    Text(
                      "الإعدادات العامة",
                      style: Styles.textStyle36.copyWith(
                        color: const Color(0xFF29206F),
                        fontSize: 36.sp,
                      ),
                    ),
                    const TextLogo(),
                  ],
                ),
              ),

              // شريط التنقل
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 40, 73, 0),
                child: Container(
                  height: AppSizes.heightRatio(context, 60),
                  width: AppSizes.widthRatio(context, 1221),
                  decoration: BoxDecoration(
                    color: AppColors.goldenYellow,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem("إدارة الطرود", 0),
                      _buildNavItem("إدارة البلدان", 1),
                      _buildNavItem("إدارة موظفي التسليم", 2),
                      _buildNavItem("إدارة النزاعات", 3),
                      _buildNavItem("إدارة التكاليف", 4),
                      _buildNavItem("إدارة الشحنات", 5),
                      _buildNavItem("إدارة المستخدمين والأدوار", 6),
                    ],
                  ),
                ),
              ),

              // عرض الصفحة الحالية فقط باستخدام Offstage
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSizes.widthRatio(context, 255),
                    50,
                    AppSizes.widthRatio(context, 225),
                    0,
                  ),
                  child: _loadedPages[_selectedIndex] ??
                      _createPage(_selectedIndex),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Text(
        label,
        style: Styles.textStyle20.copyWith(
          color: AppColors.deepPurple,
          fontSize: 20.sp,
        ),
      ),
    );
  }
}
