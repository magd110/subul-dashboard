import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:subul_dashboard2/core/utils/assets.dart';

class SidebarIcon extends StatelessWidget {
  final bool isSelected;
  final String image;
  const SidebarIcon({super.key, required this.isSelected, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      // يجعل العنصر يتمدد داخل SizedBox
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.center, // توسيط العناصر
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: SvgPicture.asset(
                  AssetsData.vector2,
                  fit: BoxFit.contain,
                  color: isSelected ? Colors.blue : null,
                  //  color: Colors.black,
                  // width: double.infinity, // يجعلها تأخذ الحجم المناسب
                  // height: double.infinity,
                ),
              ),
              SizedBox(width: 3), // مسافة بين الصور
              Flexible(
                child: SvgPicture.asset(
                  AssetsData.vector,
                  fit: BoxFit.contain,
                  color: isSelected ? Colors.blue : null, // تغيير اللون

                  // width: double.infinity,
                  // height: double.infinity,
                ),
              ),
            ],
          ),

          Stack(
            clipBehavior: Clip.none,
            children: [
              // العنصر الرئيسي داخل Stack
              SvgPicture.asset(
                AssetsData.vector3,
                fit: BoxFit.contain,
                // تكبير الصورة بما يناسب المساحة
                color: isSelected ? Colors.blue : null, // تغيير اللون
                width: 45,
                height: 30,
              ),

              // العنصر الجديد الذي يمكن التحكم في موقعه
              Positioned(
                top: 10, // التحكم في موقعه من الأعلى
                left: 22, // التحكم في موقعه من اليسار
                child: SvgPicture.asset(
                  AssetsData.Ellipse,
                  fit: BoxFit.contain, // تكبير الصورة بما يناسب المساحة
                  width: 29,
                  height: 29,
                  color: isSelected ? Colors.blue : null, // تغيير اللون
                ),
              ),
              Positioned(
                top: 13, // التحكم في موقعه من الأعلى
                left: 26, // التحكم في موقعه من اليسار
                child: SvgPicture.asset(
                  image,
                  fit: BoxFit.contain, // تكبير الصورة بما يناسب المساحة
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}