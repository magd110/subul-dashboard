import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/presentation/manager/countries_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/presentation/manager/country_create_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/presentation/manager/country_create_state.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/views/widgets/ustom_text_field.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/assets.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';

class CountryDialog extends StatefulWidget {
  final String title;
  final String? name;
  final String? code;

  const CountryDialog({
    super.key,
    required this.title,
    this.name,
    this.code,
  });

  @override
  _CountryDialogState createState() => _CountryDialogState();
}

class _CountryDialogState extends State<CountryDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name ?? '';
    codeController.text = widget.code ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // لضمان responsiveness
    final dialogWidth = AppSizes.widthRatio(context, 550);
    final dialogHeight = AppSizes.heightRatio(context, 500);

    return BlocListener<CountryCreateCubit, CountryCreateState>(
      listener: (context, state) {
        if (state is CountryCreateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تمت إضافة البلد بنجاح')),
          );
          context.read<CountriesCubit>().getCountries();
          Navigator.of(context).pop();
        } else if (state is CountryCreateFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('فشل الإضافة: ${state.errorMessage}')),
          );
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: dialogWidth,
            height: dialogHeight,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: AppColors.softGray,
              border: Border.all(color: AppColors.deepPurple, width: 3.0),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                // مساحة فارغة لتوازن التصميم
                const Expanded(flex: 1, child: SizedBox()),

                // العمود الرئيسي للنموذج
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.title,
                          style: Styles.textStyle36.copyWith(
                            fontSize: 36.sp,
                            color: AppColors.deepPurple,
                          ),
                        ),
                        SizedBox(height: 25.h),
                        CustomTextField(
                          controller: nameController,
                          hintText: 'أدخل الاسم',
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          controller: codeController,
                          hintText: 'أدخل رمز البلد...',
                        ),
                        SizedBox(height: 35.h),
                        SizedBox(
                          width: 182.w,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              final name = nameController.text.trim();
                              final code = codeController.text.trim();

                              if (name.isEmpty || code.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('يرجى إدخال الاسم والرمز')),
                                );
                                return;
                              }

                              context.read<CountryCreateCubit>().createCountry(
                                    name: name,
                                    code: code,
                                  );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.deepPurple),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            child: Text(
                              'حفظ',
                              style: Styles.textStyle14.copyWith(
                                  fontSize: 14.sp, color: AppColors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SvgPicture.asset(
                      AssetsData.image1,
                      width: 300.w, // تكبير الصورة
                      height: 300.h, // تكبير الصورة
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
