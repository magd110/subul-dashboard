import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/manager/user_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/views/widgets/add_buttom.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/views/widgets/client_role_management.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/views/widgets/signup_view.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';
import 'package:subul_dashboard2/core/widgets/text_logo.dart';

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
        //backgroundColor: AppColors.white,
        body: Container(
          decoration: AppColors.globalBackgroundGradient,
          child: Column(
            children: [
              // 🔹 أزرار التنقل تحت الـ AppBar مباشرة
              // SizedBox(
              //   height: AppSizes.heightRatio(context, 50),
              // ),

              Padding(
                padding: EdgeInsets.fromLTRB(
                    0,
                    AppSizes.heightRatio(context, 30),
                    AppSizes.widthRatio(context, 31),
                    AppSizes.heightRatio(context, 40)),
                child: Expanded(
                  child: SizedBox(
                    // width: AppSizes.widthRatio(context, 1221),
                    // height: AppSizes.heightRatio(context, 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "إدارة المستخدمين والأدوار",
                          style: Styles.textStyle36.copyWith(
                            color: Color(0xFF29206F),
                            fontSize: 36.sp,
                          ),
                        ),
                        SizedBox(
                          width: AppSizes.widthRatio(context, 200),
                        ),
                        TextLogo(),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(
                    AppSizes.widthRatio(context, 170),
                    0,
                    AppSizes.widthRatio(context, 190),
                    AppSizes.heightRatio(context, 10)),
                child: Row(children: [
                  // 🔹 زر عرض العملاء
                  AddButton1(
                    width: 300,
                    height: 60,
                    text: 'إنشاء حساب',
                    backgroundColor: AppColors.goldenYellow,
                    fontSize: 24,
                    icon: Icons.keyboard_arrow_down,
                    textColor: AppColors.deepPurple,
                    iconColor: AppColors.deepPurple,
                    onPressed: () {
                      setState(() {
                        showAccountOptions = !showAccountOptions;
                        showClients = false;
                        selectedAccountType = null;
                      });
                    },
                  ),
                  //340
                  SizedBox(
                    width: AppSizes.widthRatio(context, 330),
                  ),
                  // 🔹 زر إنشاء حساب

                  AddButton1(
                    width: 300,
                    height: 60,
                    text: 'عرض العملاء',
                    backgroundColor: AppColors.goldenYellow,
                    fontSize: 24,
                    icon: Icons.keyboard_arrow_down,
                    textColor: AppColors.deepPurple,
                    iconColor: AppColors.deepPurple,
                    onPressed: () {
                      setState(() {
                        showClients = true;
                        showAccountOptions = false;
                        selectedAccountType = null;
                      });
                    },
                  ),
                ]),
              ),

              const SizedBox(height: 5),
              // 🔹 خيارات إنشاء الحساب (المدير / مستلم المخزن)
              if (showAccountOptions) ...[
                Padding(
                  padding: EdgeInsets.only(
                    right: AppSizes.widthRatio(context, 210),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        AddButton1(
                          width: 209,
                          height: 50,
                          fontSize: 20,
                          text: 'مدير',
                          textColor: AppColors.deepPurple,
                          backgroundColor: AppColors.goldenYellow,
                          onPressed: () {
                            setState(() {
                              selectedAccountType = "manager";
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        AddButton1(
                          width: 209,
                          height: 50,
                          fontSize: 20,
                          text: 'مستلم',
                          backgroundColor: AppColors.goldenYellow,
                          textColor: AppColors.deepPurple,
                          onPressed: () {
                            setState(() {
                              selectedAccountType = "manager";
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],

              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      AppSizes.widthRatio(context, 255),
                      10,
                      AppSizes.widthRatio(context, 225),
                      0),
                  child: Builder(
                    builder: (_) {
                      if (showClients) {
                        return ClientRoleManagement();
                      } else if (selectedAccountType != null) {
                        return SignUpView();
                      } else {
                        return const SizedBox.shrink();
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
}

// 🧩 واجهة إنشاء الحساب
Widget _buildCreateAccountView(String type) {
  return Center(
    child: Text(
        "واجهة إنشاء حساب: ${type == 'manager' ? 'مدير' : 'مستلم المخزن'}"),
  );
}

// class ClientRoleManagement extends StatefulWidget {
//   const ClientRoleManagement({super.key});

//   @override
//   State<ClientRoleManagement> createState() => _ClientRoleManagementState();
// }

// class _ClientRoleManagementState extends State<ClientRoleManagement> {

//   final List<Map<String, String>> employees = [
//     {
//       "name": "أحمد علي",
//       "date": "11/1/2025",
//       "phone": "0551234567",
//       "role": "عميل عادي"
//     },
//     {
//       "name": "محمد سعيد",
//       "date": "11/1/2025",
//       "phone": "0569876543",
//       "role": "عميل عادي"
//     },
//     {
//       "name": "سارة ناصر",
//       "date": "11/1/2025",
//       "phone": "0532345678",
//       "role": "عميل عادي"
//     },
//     {
//       "name": "خالد يوسف",
//       "date": "11/1/2025",
//       "phone": "0598765432",
//       "role": "عميل عادي"
//     },
//   ];

//  @override
// Widget build(BuildContext context) {
//   return BlocBuilder<UserCubit, UserState>(
//     builder: (context, state) {
//       if (state is UserLoading) {
//         return const Center(child: CircularProgressIndicator());
//       } else if (state is UserFailure) {
//         return Center(child: Text("خطأ: ${state.errorMessage}"));
//       } else if (state is UserSuccess) {
//         final users = state.users;
//         return ListView.builder(
//           itemCount: users.length,
//           itemBuilder: (context, index) {
//             final user = users[index];
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 36.0),
//               child: Container(
//                 height: AppSizes.heightRatio(context, 70),
//                 decoration: BoxDecoration(
//                   color: AppColors.extraLightGray,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(child: Text("${user.firstName} ${user.lastName}")),
//                     Expanded(child: Text("2025/01/01")), // افترض تاريخ ثابت الآن
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Text(user.role),
//                           const SizedBox(width: 10),
//                           SvgPicture.asset(
//                             AssetsData.iconedit,
//                             width: 24,
//                             height: 24,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       } else {
//         return const SizedBox();
//       }
//     },
//   );
// }

// }
