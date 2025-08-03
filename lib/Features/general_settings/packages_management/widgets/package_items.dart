import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/data/models/parcel_model.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/presentation/manager/parcel_cubit.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';

class PackageItems extends StatelessWidget {
  final String title;
  final List<ParcelModel> items;

  final String image;
  final VoidCallback onAddPressed;

  const PackageItems({
    super.key,
    required this.title,
    required this.items,
    required this.image,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: AppColors.deepPurple,
          width: 2,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  image,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: AppSizes.widthRatio(context, 24)),
                Expanded(
                  child: Text(
                    title,
                    style: Styles.textStyle20.copyWith(
                      color: AppColors.deepPurple,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = items[index];

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // اسم الطرد
                        Expanded(
                          child: Text(
                            item.content,
                            style: Styles.textStyle20.copyWith(
                              color: AppColors.deepPurple,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                        const SizedBox(
                            width: 8), // مسافة صغيرة بين النص والأزرار
                        // زر التبديل
                        ToggleButtons(
                          isSelected: [
                            item.isAllowed == 1,
                            item.isAllowed == 0
                          ],
                          onPressed: (selectedIndex) {
                            final newStatus = selectedIndex == 0 ? 1 : 0;
                            if (item.isAllowed != newStatus) {
                              context.read<ParcelCubit>().updateParcelStatus(
                                    id: item.id,
                                    newStatus: newStatus,
                                  );
                            }
                          },
                          borderRadius: BorderRadius.circular(10),
                          selectedColor: Colors.white,
                          fillColor: AppColors.deepPurple,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text('مسموح'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text('ممنوع'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // زر الإضافة في الأسفل
            Align(
              alignment: Alignment.bottomLeft,
              child: GestureDetector(
                onTap: onAddPressed,
                child: Container(
                  width: 53,
                  height: 53,
                  decoration: const BoxDecoration(
                    color: AppColors.goldenYellow,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: AppColors.deepPurple,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
