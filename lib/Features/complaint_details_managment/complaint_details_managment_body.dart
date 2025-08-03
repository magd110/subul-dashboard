import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/presentation/manager/complaint_details_cubit.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/presentation/manager/complaint_details_state.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/widgets/reply_item.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';

// تأكد من إضافة import الخاص بـ ReplyItem و AppColors و AppSizes حسب مشروعك

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

  /// ✅ نافذة إضافة الرد
  void showReplyDialog() {
    final complaintDetailsCubit = context.read<ComplaintDetailsCubit>();

    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              height: 450,
              width: 600,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Icon(Icons.chat, color: Colors.deepPurple, size: 28),
                      SizedBox(width: 15),
                      Text(
                        'إضافة رد:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _replyController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'أدخل ردك هنا...',
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurple, width: 2.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurple, width: 2.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 182,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        final replyContent = _replyController.text.trim();
                        if (replyContent.isNotEmpty) {
                          final success =
                              await complaintDetailsCubit.addComplaintResponse(
                            complaintId: widget.complaintid,
                            content: replyContent,
                          );
                          if (success) {
                            if (Navigator.canPop(context)) {
                              Navigator.of(context).pop(); // إغلاق الديالوج
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('تم إضافة الرد بنجاح')),
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
                        backgroundColor: AppColors.goldenYellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'حفظ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<ComplaintDetailsCubit, ComplaintDetailsState>(
      listener: (context, state) {
        if (state.addReplyStatus == AddReplyStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('فشل في إضافة الرد: ${state.addReplyError}')),
          );
        }
      },
      child: BlocBuilder<ComplaintDetailsCubit, ComplaintDetailsState>(
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
              appBar: AppBar(
                backgroundColor: AppColors.goldenYellow,
                title: Text(
                  'تفاصيل الشكوى',
                  style: TextStyle(
                    color: AppColors.deepPurple,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
              body: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.softGray,
                      AppColors.white,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ✅ الوصف
                    Text(
                      "الوصف:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      complaint.description,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// ✅ الحالة
                    Row(
                      children: [
                        Text(
                          'الحالة: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          complaint.isSolved == 1 ? 'محلولة' : 'غير محلولة',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: complaint.isSolved == 1
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// ✅ الردود
                    Text(
                      "الردود:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: replies.isEmpty
                            ? const Center(child: Text('لا توجد ردود حتى الآن'))
                            : ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: replies.length,
                                itemBuilder: (context, index) {
                                  final reply = replies[index];
                                  return Column(
                                    children: [
                                      ReplyItem(
                                        replyText: reply.content,
                                        date: reply.createdAt ?? '',
                                        userName: reply.userName ?? '',
                                        userRole: reply.userRole ?? '',
                                      ),
                                      const SizedBox(height: 12),
                                    ],
                                  );
                                },
                              ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Center(
                      child: ElevatedButton.icon(
                        onPressed: showReplyDialog,
                        icon: const Icon(Icons.chat),
                        label: const Text(
                          'أضف رد',
                          style: TextStyle(color: AppColors.deepPurple),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.goldenYellow,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
