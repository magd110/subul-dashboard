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
    return BlocListener<CountryCreateCubit, CountryCreateState>(
      listener: (context, state) {
        if (state is CountryCreateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تمت إضافة البلد بنجاح')),
          );
          context.read<CountriesCubit>().getCountries();
          Navigator.of(context).pop(); // يغلق الـ Dialog تلقائياً بعد النجاح
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
            decoration: BoxDecoration(
              color: AppColors.softGray,
              border: Border.all(color: AppColors.deepPurple, width: 3.0),
              borderRadius: BorderRadius.circular(12),
            ),
            width: AppSizes.widthRatio(context, 550),
            height: AppSizes.heightRatio(context, 500),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: Styles.textStyle36.copyWith(
                            fontSize: 36.sp, color: AppColors.deepPurple),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: nameController,
                        hintText: 'أدخل الاسم',
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        controller: codeController,
                        hintText: 'أدخل رمز البلد...',
                      ),
                      const SizedBox(height: 30),
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

                            // استدعاء الـ Cubit لبدء عملية الإنشاء
                            context.read<CountryCreateCubit>().createCountry(
                                  name: name,
                                  code: code,
                                );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.deepPurple),
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

                Expanded(
                  // height: 15.h +

                  // مجموع تقريبي لارتفاع الحقول حتى "أدخل رمز البلد"
                  child: Align(
                    alignment: Alignment.bottomRight, // الصورة تبدأ من الأسفل
                    child: SvgPicture.asset(
                      AssetsData.image1,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // SvgPicture.asset(
                //   AssetsData.image1,
                //   fit: BoxFit.cover,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
