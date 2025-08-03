import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/presentation/manager/delivery_staff_cubit.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/assets.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';
import 'package:subul_dashboard2/core/widgets/custom_text_field.dart';

class EmployeeDialog extends StatefulWidget {
  final String text;

  const EmployeeDialog({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<EmployeeDialog> createState() => _EmployeeDialogState();
}

class _EmployeeDialogState extends State<EmployeeDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController jopController = TextEditingController();

  @override
  void initState() {
    // super.initState();
    // nameController.text = widget.name ?? '';
    // locationController.text = widget.location ?? '';
    // phoneController.text = widget.phone ?? '';
    // jopController.text = widget.jop ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    phoneController.dispose();
    jopController.dispose();
    super.dispose();
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
          width: AppSizes.widthRatio(context, 550),
          height: AppSizes.heightRatio(context, 600),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),

              /// المحتوى الرئيسي
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
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
                      CustomTextField(
                        controller: nameController,
                        hint: 'أدخل اسم...',
                      ),
                      SizedBox(height: 15.h),
                      CustomTextField(
                        controller: locationController,
                        hint: 'أدخل الموقع...',
                      ),
                      SizedBox(height: 15.h),
                      CustomTextField(
                        controller: phoneController,
                        hint: 'أدخل رقم الهاتف...',
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 15.h),
                      CustomTextField(
                        controller: jopController,
                        hint: 'أدخل المنصب الوظيفي...',
                      ),
                      SizedBox(height: 30.h),
                      SizedBox(
                        width: 182.w,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () {
                            final name = nameController.text.trim();
                            final location = locationController.text.trim();
                            final phone = phoneController.text.trim();
                            final jop = jopController.text.trim();

                            if (name.isEmpty ||
                                location.isEmpty ||
                                phone.isEmpty ||
                                jop.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('جميع الحقول مطلوبة')),
                              );
                              return;
                            }
                            context
                                .read<DeliveryStaffCubit>()
                                .createDeliveryStaff(
                                  name: name,
                                  address: location,
                                  phone: phone,
                                  jobTitle: jop,
                                );

                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'حفظ',
                            style: Styles.textStyle14.copyWith(
                              color: AppColors.white,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),

              /// الصورة الجانبية
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
}
