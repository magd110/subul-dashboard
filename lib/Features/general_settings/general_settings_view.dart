import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/presentation/views/complaints_management_view.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/countries_management_view.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/presentation/views/delivery_staff_management_view.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/packages_management_body.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/widgets/packages_management_view.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/views/user_management_view.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/views/widgets/user_management_body.dart';
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
  bool showOnlyUserManagement = false;

  final List<Widget> _pages = [
    const PackagesManagementView(),
    const CountriesManagementView(),
    const DeliveryStaffManagementView(),
    const ComplaintsManagementView(),
    //  const UserManagementView()
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        //backgroundColor: AppColors.white,
        body: showOnlyUserManagement
            ? const UserManagementView()
            : Container(
                decoration: AppColors.globalBackgroundGradient,
                child: Column(
                  children: [
                    // 🔹 أزرار التنقل تحت الـ AppBar مباشرة
                    // SizedBox(
                    //   height: AppSizes.heightRatio(context, 50),
                    // ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0.0,
                          AppSizes.heightRatio(context, 30),
                          AppSizes.widthRatio(context, 31),
                          0.0),
                      child: SizedBox(
                        // width: AppSizes.widthRatio(context, 1221),
                        // height: AppSizes.heightRatio(context, 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              // width: AppSizes.widthRatio(context, 364),
                              //  height: AppSizes.heightRatio(context, 60),
                              child: Text("jjjkkkkkkkkkkkkkkkkkkkkkk"),
                            ),
                            Text(
                              "الإعدادات العامة",
                              style: Styles.textStyle36.copyWith(
                                color: Color(0xFF29206F),
                                fontSize: 36.sp,
                              ),
                            ),
                            TextLogo(),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 40, 73, 0),
                      child: Container(
                        height: AppSizes.heightRatio(context, 60),
                        width: AppSizes.widthRatio(context, 1221),
                        decoration: BoxDecoration(
                            color: AppColors.goldenYellow,
                            borderRadius: BorderRadius.circular(20)),
                        //color: Colors.white, // خلفية بيضاء للأزرار
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceAround, // توزيع الأزرار بشكل متساوٍ
                          children: [
                            _buildNavItem("إدارة الطرود", 0),
                            _buildNavItem("إدارة البلدان", 1),
                            _buildNavItem("إدارة موظفي التسليم", 2),
                            _buildNavItem("إدارة النزاعات", 3),
                            _buildNavItem("إدارة المستخدمين والأدوار", 4),
                          ],
                        ),
                      ),
                    ),

                    // 🔹 المساحة التي تعرض الصفحة المختارة
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            AppSizes.widthRatio(context, 255),
                            50,
                            AppSizes.widthRatio(context, 225),
                            0),
                        child: IndexedStack(
                          index: _selectedIndex,
                          children: _pages,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
  //  child: Padding(
  //                 padding: EdgeInsets.symmetric(
  //                   horizontal:
  //                       AppSizes.widthRatio(context, 220), // التوسيط أفقيًا
  //                   // vertical:
  //                   //     AppSizes.heightRatio(context, 100), // التوسيط عموديًا
  //                 ),
  //                 child: _pages[_selectedIndex],
  //               ),

  Widget _buildNavItem(String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (index == 4) {
            showOnlyUserManagement = true;
          } else {
            _selectedIndex = index;
            showOnlyUserManagement = false;
          }
        });
      },
      child: Text(label,
          style: Styles.textStyle20.copyWith(
            color: AppColors.deepPurple,
            fontSize: 20.sp,
          )),
    );
  }
}

// الشاشات الفرعية
class PackagesManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PackagesManagementView();
  }
}

class CountriesManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountriesManagementView();
  }
}

class UsersAndRolesManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: "المستخدمون", icon: Icon(Icons.people)),
              Tab(text: "الأدوار", icon: Icon(Icons.security)),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                UsersScreen(),
                RolesScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("قائمة المستخدمين وإدارتهم"));
  }
}

class RolesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("إدارة الأدوار والصلاحيات"));
  }
}

class DisputesManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("إدارة النزاعات"));
  }
}
