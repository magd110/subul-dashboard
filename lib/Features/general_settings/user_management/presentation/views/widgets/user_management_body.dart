import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/views/widgets/add_buttom.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/views/widgets/client_role_management.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/views/widgets/signup_view.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';

class UserManagementBody extends StatefulWidget {
  const UserManagementBody({super.key});

  @override
  State<UserManagementBody> createState() => _UserManagementViewState();
}

class _UserManagementViewState extends State<UserManagementBody> {
  bool showClients = false;
  bool showAccountOptions = false;
  String? selectedAccountType;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: AppColors.globalBackgroundGradient,
          child: Column(
            children: [
              SizedBox(height: 40.h),

              /// الأزرار الأساسية
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMainButton(
                      text: 'إنشاء حساب',
                      onPressed: () {
                        setState(() {
                          showAccountOptions = !showAccountOptions;
                          showClients = false;
                          selectedAccountType = null;
                        });
                      },
                    ),
                    _buildMainButton(
                      text: 'عرض المستخدمين',
                      onPressed: () {
                        setState(() {
                          showClients = true;
                          showAccountOptions = false;
                          selectedAccountType = null;
                        });
                      },
                    ),
                  ],
                ),
              ),

              /// خيارات إنشاء الحساب (مدير / مستلم)
              if (showAccountOptions)
                Padding(
                  padding: EdgeInsets.only(right: 150.w, top: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSubButton(
                        text: "مدير",
                        onPressed: () {
                          setState(() {
                            selectedAccountType = "manager";
                          });
                        },
                      ),
                      SizedBox(height: 15.h),
                      _buildSubButton(
                        text: "مستلم",
                        onPressed: () {
                          setState(() {
                            selectedAccountType = "receiver";
                          });
                        },
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 20.h),

              /// محتوى داخلي (عملاء / تسجيل حساب)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Builder(
                    builder: (_) {
                      if (showClients) {
                        return const ClientRoleManagement();
                      } else if (selectedAccountType != null) {
                        return const SignUpView();
                      } else {
                        return Center(
                          child: Text(
                            "اختر إجراء من الأعلى",
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.deepPurple,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// زر رئيسي (إنشاء حساب / عرض العملاء)
  Widget _buildMainButton(
      {required String text, required VoidCallback onPressed}) {
    return Expanded(
      child: Card(
        child: AddButton1(
          width: 200.w,
          height: 90.h,
          text: text,
          backgroundColor: AppColors.goldenYellow,
          fontSize: 22.sp,
          textColor: AppColors.deepPurple,
          icon: Icons.keyboard_arrow_down,
          iconColor: AppColors.deepPurple,
          onPressed: onPressed,
        ),
      ),
    );
  }

  /// زر فرعي (مدير / مستلم)
  Widget _buildSubButton(
      {required String text, required VoidCallback onPressed}) {
    return Card(
      child: AddButton1(
        width: 200.w,
        height: 70.h,
        fontSize: 18.sp,
        text: text,
        textColor: AppColors.deepPurple,
        backgroundColor: AppColors.goldenYellow,
        onPressed: onPressed,
      ),
    );
  }
}
