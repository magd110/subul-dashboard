import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/styles.dart';

class ReplyItem extends StatelessWidget {
  final String replyText;
  final String date;
  final String? userName;
  final String? userRole;

  const ReplyItem({
    Key? key,
    required this.replyText,
    required this.date,
    this.userName,
    this.userRole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.deepPurple, width: 3.0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ✅ الاسم والدور
          if (userName != null || userRole != null)
            Row(
              children: [
                Icon(Icons.person, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  '${userName ?? "غير معروف"} [${userRole ?? "غير محدد"}]',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),

          SizedBox(height: 12),

          /// ✅ محتوى الرد
          Text(
            replyText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 12),

          /// ✅ التاريخ
          Row(
            children: [
              Icon(Icons.access_time, color: Colors.grey, size: 18),
              SizedBox(width: 6),
              Text(
                DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.parse(date)),
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
