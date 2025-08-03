 
 import 'package:flutter/material.dart';
import 'package:subul_dashboard2/Features/home_view/widgets/sidebar_icon_button.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/assets.dart';

class SideBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const SideBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
                width: AppSizes.widthRatio(context, 104),
                height: AppSizes.heightRatio(context, 848),
                decoration: const BoxDecoration(
                  color: AppColors.goldenYellow,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     SidebarIconButton(
  index: 0,
  selectedIndex: selectedIndex,
  imagePath: AssetsData.vector4,
  onTap: onTap,
),
                     const SizedBox(height: 20),
                     SidebarIconButton(
  index: 1,
  selectedIndex: selectedIndex,
  imagePath: AssetsData.setting,
  onTap: onTap,
),
                     const SizedBox(height: 20),
                   SidebarIconButton(
  index: 2,
  selectedIndex: selectedIndex,
  imagePath: AssetsData.box,
  onTap: onTap,
),
                  ],
                ),
              );
  }
}



