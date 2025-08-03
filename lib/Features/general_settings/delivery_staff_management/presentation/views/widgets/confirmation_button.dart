import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';

class ConfirmationButton extends StatelessWidget {
  final String text;
  final String image;

  final VoidCallback onPressed;
  final double width;
  final double height;
  const ConfirmationButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.image,
    this.width = 182,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: AppSizes.widthRatio(context, width),
          height: AppSizes.heightRatio(context, height),
          decoration: BoxDecoration(
            color: AppColors.goldenYellow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                image,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: AppSizes.widthRatio(context, 10),
              ),
              Text(
                text,
                style: Styles.textStyle14
                    .copyWith(color: AppColors.white, fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
