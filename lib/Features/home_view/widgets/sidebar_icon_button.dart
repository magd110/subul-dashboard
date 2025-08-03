import 'package:flutter/material.dart';
import 'package:subul_dashboard2/Features/home_view/widgets/side_bar_Icon.dart';

class SidebarIconButton extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String imagePath;
  final void Function(int) onTap;

  const SidebarIconButton({
    Key? key,
    required this.index,
    required this.selectedIndex,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: GestureDetector(
        onTap: () => onTap(index),
        child: SidebarIcon(
          image: imagePath,
          isSelected: selectedIndex == index,
        ),
      ),
    );
  }
}
