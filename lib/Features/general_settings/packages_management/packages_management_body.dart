import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/allowed_packages_view.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/prohibited_packages_view.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';

class PackagesManagementBody extends StatelessWidget {
  const PackagesManagementBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.deepPurple, width: 3.0),
        borderRadius: BorderRadius.circular(12),
      ),
      width: AppSizes.widthRatio(context, 856),
      height: AppSizes.heightRatio(context, 620),
      child: Column(
        children: [
          SizedBox(height: AppSizes.heightRatio(context, 40)),
          Text(
            "إدارة الطرود",
            textAlign: TextAlign.center,
            style: Styles.textStyle38.copyWith(
              fontSize: 38.sp,
              color: AppColors.deepPurple,
            ),
          ),
          SizedBox(height: AppSizes.heightRatio(context, 30)),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: AppSizes.widthRatio(context, 390),
                    height: AppSizes.heightRatio(context, 480),
                    child: AllowedPackagesView()),
                SizedBox(width: AppSizes.widthRatio(context, 14)),
                SizedBox(
                    width: AppSizes.widthRatio(context, 390),
                    height: AppSizes.heightRatio(context, 480),
                    child: ProhibitedPackagesView()),
              ],
            ),
          ),
          SizedBox(height: AppSizes.heightRatio(context, 40)),
        ],
      ),
    );
  }
}
