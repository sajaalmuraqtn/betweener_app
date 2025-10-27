import 'dart:io';

import 'package:betweeener_app/controllers/link_controller.dart';
import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/models/link_response_model.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:betweeener_app/views_features/main_app_view.dart';
import 'package:betweeener_app/views_features/widgets/custom_profile_avater_widget.dart';
import 'package:betweeener_app/views_features/widgets/custom_text_form_field.dart';
import 'package:betweeener_app/views_features/widgets/primary_outlined_button_widget.dart';
import 'package:betweeener_app/views_features/widgets/secondary_button_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EditProfileInfoView extends StatefulWidget {
  static const id = '/editProfile';
  EditProfileInfoView({super.key, required this.userInfo});

  final UserClass userInfo; 

  @override
  State<EditProfileInfoView> createState() => _EditProfileInfoViewState();
}

class _EditProfileInfoViewState extends State<EditProfileInfoView> {
  late TextEditingController nameController;
  late TextEditingController emailController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // 🔹 تهيئة الحقول بالقيم الأصلية
    nameController = TextEditingController(text: widget.userInfo.name);
    emailController = TextEditingController(text: widget.userInfo.email);
  }

  void _EditProfileInfo() {
    if (formKey.currentState!.validate()) {
      // editUserLink({
      //   'title': nameController.text,
      //   'link': emailController.text,
      // }, widget.link.id).then((isEdited) {
      //   if (isEdited) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(
      //         content: Text('Link Edited successfully'),
      //         backgroundColor: Colors.green,
      //       ),
      //     );
      //     // إعادة النتيجة للشاشة السابقة لتحديث القائمة
      //     Navigator.pop(context);
      //   }
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,

      appBar: AppBar(title: const Text('Edit User Info')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: formKey,
          child: Container(
            height: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CustomProfileAvaterWidget(height: 200),
                CustomTextFormField(
                  label: 'UserName',
                  hint: 'User Name',
                  controller: nameController,
                  validator: (title) {
                    if (title == null || title.isEmpty) {
                      return 'please enter New username';
                    }
                    return null;
                  },
                ),
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
                const SizedBox(height: 50),
                SecondaryButtonWidget(onTap: _EditProfileInfo, text: 'SAVE',width: 200,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
