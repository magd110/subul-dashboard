import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/presentation/manager/delivery_staff_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/presentation/manager/delivery_staff_state.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/presentation/views/widgets/confirmation_button.dart';
import 'package:subul_dashboard2/Features/general_settings/widgets/add_button.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/assets.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';

class DeleteEmployee extends StatelessWidget {
  final int id;
  const DeleteEmployee({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: BlocListener<DeliveryStaffCubit, DeliveryStaffState>(
          listener: (context, state) {
            if (state is DeliveryStaffSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('تم حذف الموظف بنجاح')),
              );
              Navigator.pop(context); 
            } else if (state is DeliveryStaffFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('خطأ: ${state.errorMessage}')),
              );
              Navigator.pop(
                  context); 
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.softGray,
              border: Border.all(color: AppColors.deepPurple, width: 3.0),
              borderRadius: BorderRadius.circular(12),
            ),
            width: AppSizes.widthRatio(context, 606),
            height: AppSizes.heightRatio(context, 450),
            child: Column(
              children: [
                SizedBox(height: AppSizes.heightRatio(context, 40)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'هل أنت متأكد؟',
                      style: Styles.textStyle36.copyWith(
                        color: AppColors.deepPurple,
                        fontSize: 36.sp,
                      ),
                    ),
                    SizedBox(width: AppSizes.widthRatio(context, 10)),
                    SvgPicture.asset(
                      AssetsData.image2,
                      fit: BoxFit.cover,
                      width: AppSizes.widthRatio(context, 60),
                      height: AppSizes.heightRatio(context, 60),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.heightRatio(context, 70)),
                ConfirmationButton(
                  text: 'نعم',
                  onPressed: () {
                    context.read<DeliveryStaffCubit>().deleteDeliveryStaff(id);
                   
                  },
                  image: AssetsData.check,
                ),
                SizedBox(height: AppSizes.heightRatio(context, 30)),
                ConfirmationButton(
                  text: 'لا',
                  onPressed: () => Navigator.pop(context),
                  image: AssetsData.alert,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
