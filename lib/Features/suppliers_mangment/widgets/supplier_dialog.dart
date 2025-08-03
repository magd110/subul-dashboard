import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/assets.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';

class SupplierDialog extends StatefulWidget {
  final String text;
   final String? name;
final String? location;
final String? email;
final void Function(String name, String location, String email)? onSave;

  const SupplierDialog({super.key, required this.text,this.name,
  this.location,
  this.email, this.onSave});

  @override
  _SupplierDialogState createState() => _SupplierDialogState();
}

class _SupplierDialogState extends State<SupplierDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
void dispose() {
  nameController.dispose();
  locationController.dispose();
  emailController.dispose();
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
          width: AppSizes.widthRatio(context, 606),
          height: AppSizes.heightRatio(context, 600),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: AppSizes.widthRatio(context, 120),
              ),
              Expanded(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: SizedBox(
                            height: AppSizes.heightRatio(context, 80))),
                    Expanded(
                      child: Text(
                        widget.text ?? '',
                        style: Styles.textStyle36
                            .copyWith(color: AppColors.deepPurple,fontSize: 24.sp),
                      ),
                    ),
                    
                    SizedBox(height: AppSizes.heightRatio(context, 40)),
                    Expanded(
                        child: _buildTextField(nameController, 'أدخل اسم...')),
                    SizedBox(height: AppSizes.heightRatio(context, 15)),
                    Expanded(
                        child: _buildTextField(
                            locationController, 'أدخل الموقع...')),
                    SizedBox(height: AppSizes.heightRatio(context, 15)),
                    Expanded(
                      child: _buildTextField(emailController,
                          'أدخل الإيميل ...', TextInputType.phone),
                    ),
                    SizedBox(height: AppSizes.heightRatio(context, 50)),
                    SizedBox(
                        width: AppSizes.widthRatio(context, 182),
                        height: AppSizes.heightRatio(context, 50),
                        child: ElevatedButton(
                            onPressed: () {
                              String name = nameController.text;
                              String location = locationController.text;
                              String email = emailController.text;

                              // تنفيذ الدالة الممررة عند الحفظ
                            if (widget.onSave != null) {
  widget.onSave!(name, location, email);
}

                              print("تم حفظ الموظف: $name, $location, $email");
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.deepPurple,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text('حفظ',
                                style: Styles.textStyle14
                                    .copyWith(color: AppColors.white,fontSize: 14.sp)))),
                    SizedBox(height: AppSizes.heightRatio(context, 80)),
                  ],
                ),
              ),
              SizedBox(
                child: SvgPicture.asset(
                  AssetsData.image1,
                  fit: BoxFit.cover,
                  // width: AppSizes.widthRatio(context, 40),
                  // height: AppSizes.heightRatio(context, 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      [TextInputType keyboardType = TextInputType.text]) {
    return SizedBox(
      width: AppSizes.widthRatio(context, 284),
      height: AppSizes.heightRatio(context, 37),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Styles.textStyle14.copyWith(color: AppColors.black,fontSize: 14.sp),
            filled: true,
            fillColor: AppColors.goldenYellow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ),
    );
  }
}
