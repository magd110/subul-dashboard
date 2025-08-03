import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';

class AddButton1 extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final double width;
  final double? fontSize;
  final double height;
  final Color backgroundColor;

  final Color textColor;
  final Color iconColor;

  const AddButton1({
    Key? key,
    required this.text,
    this.icon,
    this.onPressed,
    this.fontSize,
    this.width = 182,
    this.height = 50,
    required this.backgroundColor,
    this.textColor = AppColors.black, // لون النص الافتراضي
    this.iconColor = AppColors.white, // لون الأيقونة الافتراضي
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.widthRatio(context, width),
      height: AppSizes.heightRatio(context, height),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          backgroundColor: backgroundColor, // لون الزر
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: Styles.textStyle14.copyWith(
                color: textColor,
                fontSize: fontSize?.sp,
              ),
            ),
            SizedBox(width: 8), // مسافة بين النص والأيقونة
            if (icon != null) ...[
              SizedBox(width: 8),
              Icon(
                icon,
                size: 24,
                color: iconColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
