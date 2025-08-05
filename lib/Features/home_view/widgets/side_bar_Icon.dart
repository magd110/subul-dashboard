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
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.center, 
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
                  // width: double.infinity, 
                  // height: double.infinity,
                ),
              ),
              SizedBox(width: 3), 
              Flexible(
                child: SvgPicture.asset(
                  AssetsData.vector,
                  fit: BoxFit.contain,
                  color: isSelected ? Colors.blue : null, 

                  // width: double.infinity,
                  // height: double.infinity,
                ),
              ),
            ],
          ),

          Stack(
            clipBehavior: Clip.none,
            children: [
           
              SvgPicture.asset(
                AssetsData.vector3,
                fit: BoxFit.contain,
                // تكبير الصورة بما يناسب المساحة
                color: isSelected ? Colors.blue : null,
                width: 45,
                height: 30,
              ),

              
              Positioned(
                top: 10,
                left: 22, 
                child: SvgPicture.asset(
                  AssetsData.Ellipse,
                  fit: BoxFit.contain, 
                  width: 29,
                  height: 29,
                  color: isSelected ? Colors.blue : null,
                ),
              ),
              Positioned(
                top: 13,
                left: 26, 
                child: SvgPicture.asset(
                  image,
                  fit: BoxFit.contain, 
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
