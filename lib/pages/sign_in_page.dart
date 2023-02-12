import 'package:belajar_api/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            children: [
              24.verticalSpace,
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              12.verticalSpace,
              Text(
                'Login to continue',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16.sp,
                  color: Colors.grey[700],
                ),
              ),
              24.verticalSpace,
              SvgPicture.asset(
                'assets/svg/login.svg',
                width: 1.sw,
                height: 200.h,
              ),
              24.verticalSpace,
              CustomFormField(
                label: 'Email',
                controller: emailController,
              ),
              12.verticalSpace,
              CustomFormField(
                controller: passwordController,
                label: 'Password',
                isObscure: true,
              ),
              24.verticalSpace,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[900],
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    LoginService.login(
                      emailController.text,
                      passwordController.text,
                    ).then(
                      (value) {
                        value.fold(
                          (fail) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(fail.message),
                            ),
                          ),
                          (success) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(
                                  token: success.token ?? 'token',
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomFormField extends StatefulWidget {
  final String label;
  final bool isObscure;
  final TextEditingController controller;
  const CustomFormField({
    super.key,
    this.isObscure = false,
    required this.controller,
    required this.label,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        if (value!.isEmpty) {
          return '${widget.label} tidak boleh kosong';
        }
        return null;
      },
      obscureText: widget.isObscure,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Colors.grey[700],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
