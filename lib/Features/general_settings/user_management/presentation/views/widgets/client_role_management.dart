import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/manager/user_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/manager/user_state.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/views/widgets/role_selection_dialog.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/assets.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';

class ClientRoleManagement extends StatefulWidget {
  const ClientRoleManagement({super.key});

  @override
  State<ClientRoleManagement> createState() => _ClientRoleManagementState();
}

class _ClientRoleManagementState extends State<ClientRoleManagement> {
  @override
  void initState() {
    super.initState();
    // استدعاء التابع getUsers عند بداية تحميل الواجهة
    context.read<UserCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserFailure) {
          return Center(child: Text("خطأ: ${state.errorMessage}"));
        } else if (state is UserSuccess) {
          final users = state.users;
          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                margin: EdgeInsets.only(bottom: 16.h),
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    children: [
                      /// الاسم
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${user.firstName} ${user.lastName}",
                          style: Styles.textStyle20.copyWith(
                            color: AppColors.black,
                            fontSize: 18.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      /// الايميل
                      Expanded(
                        flex: 3,
                        child: Text(
                          user.email,
                          style: Styles.textStyle20.copyWith(
                            color: Colors.grey[800],
                            fontSize: 16.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      /// الدور + أيقونة تعديل
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                user.role,
                                style: Styles.textStyle20.copyWith(
                                  color: AppColors.deepPurple,
                                  fontSize: 16.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => RoleSelectionDialog(
                                    text: 'اختر الدور الجديد',
                                    selectedRole: user.role,
                                    onSave: (newRole) {
                                      context.read<UserCubit>().updateUserRole(
                                            userId: user.id,
                                            newRole: newRole,
                                          );
                                    },
                                  ),
                                );
                              },
                              child: SvgPicture.asset(
                                AssetsData.iconedit,
                                width: 22.w,
                                height: 22.h,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
