import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/assets.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';

class RoleSelectionDialog extends StatefulWidget {
  final String text;
  final String? selectedRole;
  final void Function(String selectedRole)? onSave;

  const RoleSelectionDialog({
    Key? key,
    required this.text,
    this.selectedRole,
    this.onSave,
  }) : super(key: key);

  @override
  _RoleSelectionDialogState createState() => _RoleSelectionDialogState();
}

class _RoleSelectionDialogState extends State<RoleSelectionDialog> {
  late String _selectedRole;
  final List<String> roles = ['manager', 'warehouseman', 'company', 'customer'];

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.selectedRole ?? roles.first;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.softGray,
            border: Border.all(color: AppColors.deepPurple, width: 3.0),
            borderRadius: BorderRadius.circular(12),
          ),
          width: AppSizes.widthRatio(context, 500),
          height: AppSizes.heightRatio(context, 550),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.text,
                        style: Styles.textStyle36.copyWith(
                          color: AppColors.deepPurple,
                          fontSize: 24.sp,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: roles
                            .map((role) => _buildRoleOption(role))
                            .toList(),
                      ),
                      SizedBox(height: 30.h),
                      SizedBox(
                        width: AppSizes.widthRatio(context, 182),
                        height: AppSizes.heightRatio(context, 50),
                        child: ElevatedButton(
                          onPressed: () {
                            if (widget.onSave != null) {
                              print("1");
                              widget.onSave!(_selectedRole);
                            }
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.deepPurple,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'حفظ',
                            style: Styles.textStyle14.copyWith(
                                color: AppColors.white, fontSize: 14.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset(
                    AssetsData.image1,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleOption(String role) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: RadioListTile<String>(
        title: Text(
          role,
          style: Styles.textStyle14
              .copyWith(fontSize: 16.sp, color: AppColors.black),
        ),
        value: role,
        groupValue: _selectedRole,
        onChanged: (value) {
          setState(() {
            _selectedRole = value!;
          });
        },
        activeColor: AppColors.deepPurple,
      ),
    );
  }
}
