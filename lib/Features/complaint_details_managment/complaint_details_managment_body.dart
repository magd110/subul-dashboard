import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/presentation/manager/complaint_details_cubit.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/presentation/manager/complaint_details_state.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/widgets/reply_item.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';

class ComplaintDetailsManagmentBody extends StatefulWidget {
  final int complaintid;

  const ComplaintDetailsManagmentBody({Key? key, required this.complaintid})
      : super(key: key);

  @override
  State<ComplaintDetailsManagmentBody> createState() =>
      _ComplaintDetailsManagmentBodyState();
}

class _ComplaintDetailsManagmentBodyState
    extends State<ComplaintDetailsManagmentBody> {
  final TextEditingController _replyController = TextEditingController();

  void showReplyDialog() {
    final complaintDetailsCubit = context.read<ComplaintDetailsCubit>();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(24),
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.chat_bubble,
                    color: Colors.deepPurple, size: 40),
                const SizedBox(height: 12),
                Text(
                  "إضافة رد",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                    color: AppColors.deepPurple,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _replyController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'أدخل ردك هنا...',
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final replyContent = _replyController.text.trim();
                    if (replyContent.isNotEmpty) {
                      final success =
                          await complaintDetailsCubit.addComplaintResponse(
                        complaintId: widget.complaintid,
                        content: replyContent,
                      );
                      if (success && mounted) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم إضافة الرد بنجاح')),
                        );
                        _replyController.clear();
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('يرجى إدخال رد قبل الحفظ'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "حفظ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplaintDetailsCubit, ComplaintDetailsState>(
      builder: (context, state) {
        if (state.isLoadingDetails) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.detailsError != null) {
          return Scaffold(
            body: Center(child: Text('حدث خطأ: ${state.detailsError}')),
          );
        }

        final complaint = state.complaint;
        final replies = complaint?.responses ?? [];

        if (complaint == null) {
          return const Scaffold(
            body: Center(child: Text('لا توجد تفاصيل متاحة')),
          );
        }

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              backgroundColor: AppColors.deepPurple,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                'تفاصيل الشكوى',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              elevation: 4,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // بطاقة الوصف
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 300, // أقصى عرض مناسب للشاشات الكبيرة
                    ),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize:
                              MainAxisSize.min, // الحجم يتناسب مع المحتوى
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "الوصف:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: AppColors.deepPurple,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              complaint.description,
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

// بطاقة الحالة
                  Card(
                    color: complaint.isSolved == 1
                        ? Colors.green.shade50
                        : Colors.orange.shade50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .min, // 👈 البطاقة تتوسع حسب المحتوى فقط
                        children: [
                          Icon(
                            complaint.isSolved == 1
                                ? Icons.check_circle
                                : Icons.error_outline,
                            color: complaint.isSolved == 1
                                ? Colors.green
                                : Colors.orange,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            complaint.isSolved == 1
                                ? "محلولة"
                                : "في انتظار المعالجة",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: complaint.isSolved == 1
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// 🟪 الردود
                  Text("الردود:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: AppColors.deepPurple)),
                  const SizedBox(height: 8),

                  replies.isEmpty
                      ? Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: Text("لا توجد ردود حتى الآن",
                                  style: TextStyle(fontSize: 16.sp)),
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: replies.length,
                          itemBuilder: (context, index) {
                            final reply = replies[index];
                            return Align(
                              alignment:
                                  Alignment.center, // محاذاة البطاقة إلى اليمين
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      500, // أقصى عرض مناسب للردود القصيرة والمتوسطة
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  color: Colors.white,
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    child: ReplyItem(
                                      replyText: reply.content,
                                      date: reply.createdAt ?? '',
                                      userName: reply.userName ?? '',
                                      userRole: reply.userRole ?? '',
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                  const SizedBox(height: 20),

                  /// 🟪 زر إضافة رد
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: showReplyDialog,
                      icon: const Icon(Icons.add_comment, color: Colors.white),
                      label: const Text(
                        'إضافة رد',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.deepPurple,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
