import 'package:betweeener_app/controllers/auth_controller.dart';
import 'package:betweeener_app/controllers/user_controller.dart';
import 'package:betweeener_app/core/util/assets.dart';
import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/views_features/auth/login_view.dart';
import 'package:betweeener_app/views_features/main_app_view.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/custom_text_form_field.dart';
import '../widgets/google_button_widget.dart';
import '../widgets/secondary_button_widget.dart';
import '../widgets/primary_outlined_button_widget.dart';

class RegisterView extends StatefulWidget {
  static String id = '/registerView';

  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  // TextField  يخزن النص اللي المستخدم بيكتبه داخل TextEditingController  .

  TextEditingController passwordController = TextEditingController();
  TextEditingController password_confirmationController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void submitRegister() {
    // عند الضغط على زر تسجيل حساب
    if (_formKey.currentState!.validate()) {
            //  يتأكد من صحة الإدخال 
         //post requestلحتى نحولها و نرسلها لل  bodyاسمها  map رح نحط المعلومات داخل 

      final Map<String, dynamic> body = {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'password_confirmation': password_confirmationController.text,
      };
      register(body)
      // الدالة اللي رح ترسل الطلب إلى السيرفر
          .then((user) async {
            Navigator.pushReplacementNamed(context, LoginView.id);
            // اذا كان كلشي تمام رح يروح على صفحة تسجيل الدخول
          })
          .catchError((error) {
           SnackBarShowMessage(
              message: error.toString(),
              color: Colors.red,
              context: context,
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: kScaffoldColor,

      appBar: AppBar(
        title: const Text("Register"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SizedBox(
            height:
                MediaQuery.of(context).size.height -
                AppBar().preferredSize.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Spacer(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                    child: Hero(
                      tag: 'authImage',
                      child: SvgPicture.asset(AssetsData.authImage),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomTextFormField(
                    controller: nameController,
                    hint: 'John Doe',
                    label: 'Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter the name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
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
                    password: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter the password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  CustomTextFormField(
                    controller: password_confirmationController,
                    hint: 'Enter confirm password',
                    label: 'Confirm password',
                    password: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter confirm password';
                      } else if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SecondaryButtonWidget(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        submitRegister();
                      }
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
