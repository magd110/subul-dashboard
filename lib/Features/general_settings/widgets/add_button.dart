import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';

class AddButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color textColor;
  final Color iconColor;

  const AddButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.icon,
    this.width = 152,
    this.height = 60,
    this.textColor = AppColors.black, 
    this.iconColor = AppColors.white, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double calculatedWidth = AppSizes.widthRatio(context, width);
    double minWidth = 120;
    double finalWidth = calculatedWidth < minWidth ? minWidth : calculatedWidth;

    return SizedBox(
      width: finalWidth,
      height:
          AppSizes.heightRatio(context, height).clamp(50.0, double.infinity),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 24,
          color: iconColor,
        ),
        label: Flexible(
         
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Styles.textStyle14.copyWith(
              color: textColor,
              fontSize: 14,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.goldenYellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
