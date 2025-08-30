import 'package:flutter/material.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/complaint_details_managment_view.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/models/complaint_model.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';

class ComplaintItem extends StatelessWidget {
  final ComplaintModel complaint;

  const ComplaintItem({
    super.key,
    required this.complaint,
  });

  /// ✅ تحديد اللون حسب حالة الشكوى
  Color getBoxColor() {
    if (complaint.isSolved == 1) {
      return Colors.green; // تمت المعالجة
    } else {
      return Colors.orange; // في انتظار المعالجة
    }
  }

  /// ✅ تحديد الأيقونة حسب حالة الشكوى
  Widget getIcon() {
    if (complaint.isSolved == 1) {
      return const Icon(Icons.check, color: Colors.white, size: 20); // تم الحل
    } else {
      return const Icon(Icons.hourglass_bottom,
          color: Colors.white, size: 20); // قيد الانتظار
    }
  }

  /// ✅ النص لعرض Tooltip (عند hover في الويب)
  String getStatusText() {
    if (complaint.isSolved == 1) {
      return "تمت المعالجة";
    } else {
      return "قيد الانتظار";
    }
  }

  void navigateToDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ComplaintDetailsManagmentView(
          complaintid: complaint.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToDetails(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.deepPurple, width: 3.0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            /// ✅ Custom Checkbox (مع Tooltip للويب)
            Tooltip(
              message: getStatusText(),
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: getBoxColor(),
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(child: getIcon()),
              ),
            ),

            const SizedBox(width: 16),

            /// ✅ النص
            Expanded(
              child: Text(
                complaint.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
