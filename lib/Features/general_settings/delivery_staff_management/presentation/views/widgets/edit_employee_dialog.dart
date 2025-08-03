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

class EditEmployeeDialog extends StatefulWidget {
  final String text;
  final int id;
  final String name;
  final String address;
  final String phone;
  final String jobTitle;

  const EditEmployeeDialog({
    Key? key,
    required this.text,
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.jobTitle,
  }) : super(key: key);

  @override
  State<EditEmployeeDialog> createState() => _EditEmployeeDialogState();
}

class _EditEmployeeDialogState extends State<EditEmployeeDialog> {
  late TextEditingController nameController;
  late TextEditingController locationController;
  late TextEditingController phoneController;
  late TextEditingController jopController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    locationController = TextEditingController(text: widget.address);
    phoneController = TextEditingController(text: widget.phone);
    jopController = TextEditingController(text: widget.jobTitle);
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
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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

                            final updatedName =
                                name.isEmpty ? widget.name : name;
                            final updatedLocation =
                                location.isEmpty ? widget.address : location;
                            final updatedPhone =
                                phone.isEmpty ? widget.phone : phone;
                            final updatedJop =
                                jop.isEmpty ? widget.jobTitle : jop;

                            context
                                .read<DeliveryStaffCubit>()
                                .updateDeliveryStaff(
                                  id: widget.id,
                                  name: updatedName,
                                  address: updatedLocation,
                                  phone: updatedPhone,
                                  jobTitle: updatedJop,
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
                            'تعديل',
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
