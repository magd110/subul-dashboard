import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:subul_dashboard2/Features/fixed_cost_managment/presentation/manager/fixed_cost_cubit.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/assets.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';
import 'package:subul_dashboard2/core/widgets/custom_text_field.dart';

class EditFixedCostDialog extends StatefulWidget {
  final String text;
  final int id;
  final String name;
  final String value;

  const EditFixedCostDialog({
    Key? key,
    required this.text,
    required this.id,
    required this.name,
    required this.value,
  }) : super(key: key);

  @override
  State<EditFixedCostDialog> createState() => _EditFixedCostDialogState();
}

class _EditFixedCostDialogState extends State<EditFixedCostDialog> {
  late TextEditingController valueController;

  @override
  void initState() {
    super.initState();
    valueController = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    valueController.dispose();
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
          width: AppSizes.widthRatio(context, 500),
          height: AppSizes.heightRatio(context, 300),
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
                      // Field to edit value
                      CustomTextField(
                        controller: valueController,
                        hint: 'أدخل القيمة الجديدة...',
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 30.h),
                      SizedBox(
                        width: 182.w,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () {
                            final value = valueController.text.trim();
                            final updatedValue =
                                value.isEmpty ? widget.value : value;

                            context.read<FixedCostCubit>().updateFixedCost(
                                  id: widget.id,
                                  value: updatedValue,
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
