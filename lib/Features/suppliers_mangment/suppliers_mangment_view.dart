import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:subul_dashboard2/Features/general_settings/widgets/add_button.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/assets.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';
import 'package:subul_dashboard2/core/widgets/text_logo.dart';

class SuppliersMangmentView extends StatelessWidget {
  SuppliersMangmentView({super.key});
  List<List<String>> data = [
    ["أحمد حسن", "القاهرة، مصر", "ahmed.hassan@gmail.com"],
    ["سارة يوسف", "دبي، الإمارات", "sara.yousef@gmail.com"],
    ["محمد علي", "الرياض، السعودية", "mohamed.ali@gmail.com"],
    ["ليلى خالد", "الدوحة، قطر", "layla.khaled@gmail.com"],
    ["خالد عمر", "عمّان، الأردن", "khaled.omar@gmail.com"],
    ["نورا سمير", "بيروت، لبنان", "noura.samir@gmail.com"],
    ["زياد أحمد", "تونس، تونس", "ziad.ahmed@egmail.com"],
    ["رنا محمد", "الجزائر، الجزائر", "rana.mohamed@gmail.com"],
    // ["وسيم طارق", "طرابلس، ليبيا", "wasim.tariq@example.com"],
    // ["هدى صالح", "المنامة، البحرين", "huda.saleh@example.com"],
    // ["عبدالله فهد", "مسقط، عمان", "abdullah.fahd@example.com"],
    // ["مها ناصر", "الخرطوم، السودان", "maha.nasser@example.com"],
    // ["طارق سامي", "الرباط، المغرب", "tareq.sami@example.com"],
    // ["مي علاء", "دمشق، سوريا", "mai.alaa@example.com"],
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
                AppSizes.widthRatio(context, 30), 31, 0.0, 0.0),
            child: Align(alignment: Alignment.centerLeft, child: TextLogo()),
          ),
          SizedBox(
            height: AppSizes.heightRatio(context, 35),
          ),
          Center(
            child: Text("تفاصيل الموردين وشركات النقل",
                style: Styles.textStyle36.copyWith(
                    color: AppColors.deepPurple,
                    fontSize: 36.sp,
                    fontFamily: AssetsData.almarai)),
          ),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      AppSizes.widthRatio(context, 130),
                      AppSizes.heightRatio(context, 50),
                      AppSizes.widthRatio(context, 210),
                      0),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical, // لدعم التمرير العمودي
                      child: Table(border: TableBorder.all(), columnWidths: {
                        //
                        0: FlexColumnWidth(AppSizes.widthRatio(context, 270)),
                        1: FlexColumnWidth(AppSizes.widthRatio(context, 270)),
                        2: FlexColumnWidth(AppSizes.widthRatio(context, 427)),
                      }, children: [
                        // ✅ صف العناوين
                        TableRow(
                          children: [
                            TableCell(child: Text('الاسم'), isHeader: true),
                            TableCell(child: Text('الموقع'), isHeader: true),
                            TableCell(child: Text('الإيميل'), isHeader: true),
                          ],
                        ),
                        // ✅ الصفوف الديناميكية
                        ...data.map((row) => TableRow(
                              children: [
                                TableCell(child: Text(row[0]), isHeader: false),
                                TableCell(child: Text(row[1]), isHeader: false),
                                TableCell(
                                  isHeader: false,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(child: Text(row[2])),
                                        SvgPicture.asset(
                                          AssetsData.iconedit,
                                          fit: BoxFit.cover,
                                          // width: AppSizes.widthRatio(context, 40),
                                          // height: AppSizes.heightRatio(context, 40),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ])))),

          SizedBox(height: AppSizes.heightRatio(context, 20)),
          Padding(
            padding: EdgeInsets.only(
              left: AppSizes.widthRatio(context, 130),
            ),
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                AddButton(
                  text: 'إضافة',
                  icon: FontAwesomeIcons.plus,
                  onPressed: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (context) => EmployeeDialog(
                    //     text: "إضافة موظف جديد",
                    //     onSave: () {
                    //       print("object");
                    //     },
                    //   ),
                    // );
                  },
                ),
                AddButton(
                  text: 'إضافة',
                  icon: FontAwesomeIcons.plus,
                  onPressed: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (context) => EmployeeDialog(
                    //     text: "إضافة موظف جديد",
                    //     onSave: () {
                    //       print("object");
                    //     },
                    //   ),
                    // );
                  },
                ),
              ],
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.fromLTRB(0, 0, 200, 0),
          //   child: Row(
          //     children: [
          //       AddButton(
          //         text: 'إضافة',
          //         icon: FontAwesomeIcons.plus,
          //         onPressed: () {
          //           // showDialog(
          //           //   context: context,
          //           //   builder: (context) => EmployeeDialog(
          //           //     text: "إضافة موظف جديد",
          //           //     onSave: () {
          //           //       print("object");
          //           //     },
          //           //   ),
          //           // );
          //         },
          //       ),
          //       AddButton(
          //         text: 'إضافة',
          //         icon: FontAwesomeIcons.plus,
          //         onPressed: () {
          //           // showDialog(
          //           //   context: context,
          //           //   builder: (context) => EmployeeDialog(
          //           //     text: "إضافة موظف جديد",
          //           //     onSave: () {
          //           //       print("object");
          //           //     },
          //           //   ),
          //           // );
          //         },
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  // دالة لإنشاء خلية الجدول
//   Widget tableCell(String text, {bool isHeader = false}) {
//     return Container(
//         height: AppSizes.heightRatio(context, 71),
//       decoration: BoxDecoration(color: isHeader ? AppColors.deepPurple : null),
//       child: Text(
//         text,
//         textAlign: TextAlign.center,
//         style: TextStyle(
//             fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),
//       ),
//     );
//   }
}

class TableCell extends StatelessWidget {
  final Widget child;
  final bool isHeader;

  const TableCell({
    Key? key,
    required this.child,
    required this.isHeader,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.heightRatio(context, 71),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isHeader ? AppColors.deepPurple : null,
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: isHeader ? 24.sp : 30.sp,
          fontFamily: isHeader ? AssetsData.almarai : AssetsData.poppins,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? AppColors.goldenYellow : AppColors.deepPurple,
        ),
        child: child,
      ),
    );
  }
}
// Text(text,
//           textAlign: TextAlign.center,
//           style: isHeader
//               ? Styles.textStyle24.copyWith(
//                   color: AppColors.goldenYellow,
//                   fontSize: 24.sp,
//                 )
//               : Styles.textStyle30.copyWith(
//                   color: AppColors.deepPurple,
//                   fontSize: 30.sp,
//                   fontFamily: AssetsData.poppins)),