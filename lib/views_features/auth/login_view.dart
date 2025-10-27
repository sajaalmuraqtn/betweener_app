import 'package:betweeener_app/controllers/auth_controller.dart';
import 'package:betweeener_app/core/util/assets.dart';
import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:betweeener_app/views_features/auth/register_view.dart';
import 'package:betweeener_app/views_features/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:email_validator/email_validator.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../main_app_view.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/google_button_widget.dart';
import '../widgets/primary_outlined_button_widget.dart';
import '../widgets/secondary_button_widget.dart';

class LoginView extends StatefulWidget {
  static String id = '/loginView';

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // TextField  يخزن النص اللي المستخدم بيكتبه داخل TextEditingController

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void submitLogin() {
    // عند الضغط على زر تسجيل الدخول

    if (_formKey.currentState!.validate()) {
      //(email و password مش فاضيين) يتأكد من صحة الإدخال

      final Map<String, dynamic> body = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      //post requestلحتى نحولها و نرسلها لل  bodyاسمها  map رح نحط المعلومات داخل
      login(body)
          .then((user) async {
            // بعد ما يكون كلشي تمام وتمت عملية تسجيل الدخول
            // رح يحفظ معلومات المستخدم اللي سجل دخولو لاستخدامو بالتطبيق
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('user', userToJson(user));
            Navigator.pushReplacementNamed(context, MainAppView.id);
            // اذا كان كلشي تمام رح يروح على الصفحة الرئيسية
          })
          .catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.toString()),
                backgroundColor: Colors.red,
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Spacer(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                    child: Hero(
                      tag: 'authImage',
                      child: SvgPicture.asset(AssetsData.authImage),
                    ),
                  ),
                  const Spacer(),
                  CustomTextFormField(
                    controller: emailController,
                    hint: 'example@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    label: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter the email';
                      } else if (!EmailValidator.validate(value)) {
                        return 'please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  CustomTextFormField(
                    controller: passwordController,
                    hint: 'Enter password',
                    label: 'password',
                    autofillHints: const [AutofillHints.password],
                    password: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter the password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SecondaryButtonWidget(onTap: submitLogin, text: 'LOGIN'),
                  const SizedBox(height: 24),
                  PrimaryOutlinedButtonWidget(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterView.id);
                    },
                    text: 'REGISTER',
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '-  or  -',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GoogleButtonWidget(onTap: () {}),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
