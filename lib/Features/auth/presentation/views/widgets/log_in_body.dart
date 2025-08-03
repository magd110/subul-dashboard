import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:subul_dashboard2/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:subul_dashboard2/Features/auth/presentation/manager/auth_state.dart';
import 'package:subul_dashboard2/Features/auth/presentation/views/widgets/custom_login_button.dart';
import 'package:subul_dashboard2/Features/auth/presentation/views/widgets/custom_login_text_field.dart';
import 'package:subul_dashboard2/Features/home_view/home_view.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/assets.dart';

class LogInBody extends StatefulWidget {
  const LogInBody({super.key});

  @override
  State<LogInBody> createState() => _LogInBodyState();
}

class _LogInBodyState extends State<LogInBody> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// الخلفية
          Positioned.fill(
            child: Image.asset(
              AssetsData.background1,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),

          /// المحتوى
          Center(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("✅ تم تسجيل الدخول بنجاح")),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ),
                  );
                  
                } else if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage)),
                  );
                }
              },
              builder: (context, state) {
                print("🔍 AuthState: $state");
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// العنوان
                          Text(
                            "تسجيل الدخول",
                            style: TextStyle(
                              fontSize: 36.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldenYellow,
                            ),
                          ),
                          SizedBox(height: 60.h),

                          /// حقل البريد الإلكتروني
                          CustomLoginTextField(
                            controller: emailController,
                            hint: "البريد الإلكتروني",
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "يرجى إدخال البريد الإلكتروني";
                              }
                              if (!value.contains('@')) {
                                return "البريد الإلكتروني غير صالح";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),

                          /// حقل كلمة المرور
                          CustomLoginTextField(
                            controller: passwordController,
                            hint: "كلمة المرور",
                            icon: Icons.lock_outline,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "يرجى إدخال كلمة المرور";
                              }
                              if (value.length < 6) {
                                return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 40.h),

                          /// زر تسجيل الدخول
                          CustomLoginButton(
                            text: "موافق",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();
                                context.read<AuthCubit>().login(
                                      email: email,
                                      password: password,
                                    );
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    /// مؤشر التحميل فوق كل شيء
                    if (state is AuthLoading) const CircularProgressIndicator(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
