import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/complaint_details_managment_body.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/complaint_details_managment_view.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/presentation/manager/complaint_details_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/models/complaint_model.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/presentation/manager/complaints_cubit.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/service_locator.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';

class ComplaintItem extends StatefulWidget {
  final ComplaintModel complaint;

  const ComplaintItem({
    super.key,
    required this.complaint,
  });

  @override
  State<ComplaintItem> createState() => _ComplaintItemState();
}

class _ComplaintItemState extends State<ComplaintItem> {
  bool? _checkboxValue;
  final TextEditingController _replyController = TextEditingController();
  void navigateToDetails() {
  
   Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => ComplaintDetailsManagmentView(
      complaintid: widget.complaint.id,
     
    ),
  ),

    );
  }

  // void showReplyDialog() {
  //   final cubit = context.read<ComplaintsCubit>();

  //   showDialog(
  //     context: context,
  //     builder: (dialogContext) {
  //       return Directionality(
  //         textDirection: TextDirection.rtl,
  //         child: Dialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(16),
  //           ),
  //           child: Container(
  //             height: 450.h,
  //             width: 606.w,
  //             padding: const EdgeInsets.all(24),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 // ✅ مساحة فارغة بطول 80
  //                 SizedBox(height: 50.h),
  //                 Row(
  //                   children: [
  //                     Icon(Icons.chat, color: AppColors.deepPurple, size: 28),
  //                     SizedBox(width: 15),
  //                     Text(
  //                       'الرد:',
  //                       style: Styles.textStyle24.copyWith(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 24.sp,
  //                           color: AppColors.deepPurple),
  //                     ),
  //                   ],
  //                 ),

  //                 const SizedBox(height: 16),

  //                 // ✅ حقل الإدخال
  //                 TextFormField(
  //                   controller: _replyController,
  //                   maxLines: 4,
  //                   decoration: InputDecoration(
  //                     hintText: 'أدخل ردك هنا...',
  //                     filled: true, // ✅ التفعيل
  //                     fillColor: Colors.white, // ✅ لون الخلفية

  //                     // ✅ الحد عند الوضع العادي
  //                     enabledBorder: OutlineInputBorder(
  //                       borderSide: BorderSide(
  //                         color: AppColors.deepPurple, // غير اللون هنا كما تريد
  //                         width: 2.0,
  //                       ),
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),

  //                     // ✅ الحد عند التركيز
  //                     focusedBorder: OutlineInputBorder(
  //                       borderSide: BorderSide(
  //                         color: AppColors
  //                             .deepPurple, // نفس اللون أو لون مختلف عند التركيز
  //                         width: 2.0,
  //                       ),
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                   ),
  //                 ),

  //                 const SizedBox(height: 24),

  //                 SizedBox(
  //                   width: 182.w,
  //                   height: 50.h,
  //                   child: ElevatedButton(
  //                     onPressed: () {
  //                       final replyContent = _replyController.text.trim();
  //                       if (replyContent.isNotEmpty) {
  //                         cubit.addComplaintResponse(
  //                             complaintId: widget.complaint.id,
  //                             content: replyContent);
  //                       }
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: AppColors.deepPurple, // ✅ لون الزر
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(12), // ✅ التدويرة
  //                       ),
  //                     ),
  //                     child: Text(
  //                       'حفظ',
  //                       style: Styles.textStyle14.copyWith(
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 14.sp,
  //                         color: Colors.white, // ✅ لون النص مختلف
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void _toggleCheckbox() {
    setState(() {
      if (_checkboxValue == null) {
        _checkboxValue = true;
      } else if (_checkboxValue == true) {
        _checkboxValue = false;
      } else {
        _checkboxValue = null;
      }
    });

    print("قيمة الحالة: $_checkboxValue");
  }

  Color getBoxColor() {
    if (_checkboxValue == true) {
      return Colors.green;
    } else if (_checkboxValue == false) {
      return Colors.red;
    } else {
      return Colors.grey.withOpacity(0.3);
    }
  }

  Widget getIcon() {
    if (_checkboxValue == true) {
      return Icon(Icons.check, color: Colors.white, size: 20);
    } else if (_checkboxValue == false) {
      return Icon(Icons.close, color: Colors.white, size: 20);
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigateToDetails,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.deepPurple, width: 3.0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            /// ✅ Custom Checkbox
            GestureDetector(
              onTap: _toggleCheckbox,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: getBoxColor(),
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(child: getIcon()),
              ),
            ),

            /// ✅ النص
            Expanded(
              child: Center(
                child: Text(
                  widget.complaint.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // /// ✅ أيقونة الدردشة
            // IconButton(
            //   onPressed: showReplyDialog,
            //   icon: const Icon(Icons.chat),
            //   color: AppColors.goldenYellow,
            // ),
          ],
        ),
      ),
    );
  }
}
