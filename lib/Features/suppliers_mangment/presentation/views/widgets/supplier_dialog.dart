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
  final String? phone;
  final void Function(String name, String location, String email, String phone)?
      onSave;

  const SupplierDialog({
    super.key,
    required this.text,
    this.name,
    this.location,
    this.email,
    this.phone,
    this.onSave,
  });

  @override
  _SupplierDialogState createState() => _SupplierDialogState();
}

class _SupplierDialogState extends State<SupplierDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name ?? '';
    locationController.text = widget.location ?? '';
    emailController.text = widget.email ?? '';
    phoneController.text = widget.phone ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    emailController.dispose();
    phoneController.dispose();
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
          width: AppSizes.widthRatio(context, 606),
          height: AppSizes.heightRatio(context, 650),
          decoration: BoxDecoration(
            color: AppColors.softGray,
            border: Border.all(color: AppColors.deepPurple, width: 3.0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(width: AppSizes.widthRatio(context, 120)),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      vertical: AppSizes.heightRatio(context, 20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: AppSizes.heightRatio(context, 20)),
                      Text(
                        widget.text,
                        style: Styles.textStyle36.copyWith(
                          color: AppColors.deepPurple,
                          fontSize: 24.sp,
                        ),
                      ),
                      SizedBox(height: AppSizes.heightRatio(context, 30)),
                      _buildTextField(
                          nameController, 'أدخل اسم...', TextInputType.text),
                      SizedBox(height: AppSizes.heightRatio(context, 15)),
                      _buildTextField(locationController, 'أدخل الموقع...',
                          TextInputType.text),
                      SizedBox(height: AppSizes.heightRatio(context, 15)),
                      _buildTextField(emailController, 'أدخل الإيميل ...',
                          TextInputType.emailAddress),
                      SizedBox(height: AppSizes.heightRatio(context, 15)),
                      _buildTextField(phoneController, 'أدخل رقم الهاتف ...',
                          TextInputType.phone),
                      SizedBox(height: AppSizes.heightRatio(context, 30)),
                     SizedBox(
  width: AppSizes.widthRatio(context, 182),
  height: AppSizes.heightRatio(context, 50),
  child: ElevatedButton(
    onPressed: () {
      String name = nameController.text.trim();
      String location = locationController.text.trim();
      String email = emailController.text.trim();
      String phone = phoneController.text.trim();

      if (name.isEmpty || location.isEmpty || email.isEmpty || phone.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('يرجى تعبئة جميع الحقول')),
        );
        return;
      }

      // ✅ فقط استدعاء onSave، ولا تغلق dialog هنا
      if (widget.onSave != null) {
        widget.onSave!(name, location, email, phone);
      }
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
)
,
                      SizedBox(height: AppSizes.heightRatio(context, 40)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                child: SvgPicture.asset(
                  AssetsData.image1,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      [TextInputType keyboardType = TextInputType.text,
      TextInputAction textInputAction = TextInputAction.next]) {
    return SizedBox(
      width: AppSizes.widthRatio(context, 284),
      height: AppSizes.heightRatio(context, 45),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: Styles.textStyle14.copyWith(
            color: AppColors.black,
            fontSize: 14.sp,
          ),
          filled: true,
          fillColor: AppColors.goldenYellow,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
    );
  }
}
