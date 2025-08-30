import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/presentation/manager/add_parcel_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/presentation/manager/add_parcel_state.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/assets.dart';
import 'package:subul_dashboard2/core/widgets/custom_text_field.dart';

class AddParcelDialog extends StatefulWidget {
  final String title;
  final int isAllowed;

  const AddParcelDialog({
    super.key,
    required this.title,
    required this.isAllowed,
  });

  @override
  _AddParcelDialogState createState() => _AddParcelDialogState();
}

class _AddParcelDialogState extends State<AddParcelDialog> {
  final TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddParcelCubit, AddParcelState>(
      listener: (context, state) {
        if (state is AddParcelSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تمت إضافة الطرد بنجاح')),
          );
          Navigator.of(context).pop(true);
        } else if (state is AddParcelFailure) {
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
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.softGray,
              border: Border.all(color: AppColors.deepPurple, width: 3.0),
              borderRadius: BorderRadius.circular(12),
            ),
            width: 550.w,
            height: 450.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.deepPurple,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      CustomTextField(
                        controller: contentController,
                        hint: 'المحتوى',
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: 182.w,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () {
                            final content = contentController.text.trim();
                            if (content.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('يرجى إدخال المحتوى')),
                              );
                              return;
                            }

                            context.read<AddParcelCubit>().addParcel(
                                  content: content,
                                  isAllowed: widget.isAllowed,
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'حفظ',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100.w,
                  height: 250.h,
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
      ),
    );
  }
}
