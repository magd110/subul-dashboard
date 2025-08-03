import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/views/widgets/add_buttom.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/views/widgets/ustom_text_field.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/assets.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    // مهم تحرير الموارد
    nameController.dispose();
    locationController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  PlatformFile? pickedFile;

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true, // ✨ ضروري للحصول على bytes
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        pickedFile = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          GestureDetector(
            onTap: pickImage,
            child: Center(
              child: Container(
                width: AppSizes.widthRatio(context, 150),
                height: AppSizes.heightRatio(context, 150),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                ),
                clipBehavior: Clip.antiAlias,
                child: pickedFile == null
                    ? SvgPicture.asset(AssetsData.profile)
                    : (pickedFile!.bytes != null
                        ? Image.memory(pickedFile!.bytes!)
                        : const Icon(Icons.broken_image)),
              ),
            ),
          ),
          const SizedBox(height: 30),
          CustomTextField(
            hintText: "أدخل الاسم...",
            controller: nameController,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            hintText: "أدخل الموقع...",
            controller: locationController,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            hintText: "أدخل رقم الهاتف...",
            controller: phoneController,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 30),
          AddButton1(
            width: 182,
            height: 50,
            fontSize: 14,
            backgroundColor: AppColors.deepPurple,
            text: 'حفظ',
            textColor: AppColors.white,
            onPressed: () async {
              final dataMap = <String, dynamic>{
                'name': nameController.text,
                'location': locationController.text,
                'phone': phoneController.text,
              };
              if (pickedFile != null && pickedFile!.bytes != null) {
                dataMap['profile_image'] = MultipartFile.fromBytes(
                  pickedFile!.bytes!,
                  filename: pickedFile!.name,
                );
              }
              final formData = FormData.fromMap(dataMap);
            },
          ),
        ],
      ),
    );
  }
}
