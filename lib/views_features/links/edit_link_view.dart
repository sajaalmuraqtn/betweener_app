import 'dart:io';

import 'package:betweeener_app/controllers/link_controller.dart';
import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/models/link_response_model.dart';
import 'package:betweeener_app/views_features/main_app_view.dart';
import 'package:betweeener_app/views_features/widgets/custom_text_form_field.dart';
import 'package:betweeener_app/views_features/widgets/primary_outlined_button_widget.dart';
import 'package:betweeener_app/views_features/widgets/secondary_button_widget.dart';
import 'package:flutter/material.dart';

class EditLinkView extends StatefulWidget {
  static const id = '/editLink';
  EditLinkView({super.key, this.link, this.superContext});
  BuildContext? superContext;

  LinkElement? link; // 🔹 تأكد من final

  @override
  State<EditLinkView> createState() => _EditLinkViewState();
}

class _EditLinkViewState extends State<EditLinkView> {
  late TextEditingController titleController;
  late TextEditingController linkController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.link?.title);
    linkController = TextEditingController(text: widget.link?.link);
  }

  void _EditLink() {
    if (formKey.currentState!.validate()) {
      editUserLink({
        'title': titleController.text,
        'link': linkController.text,
      }, widget.link!.id).then((isEdited) {
        if (isEdited) {
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,

      appBar: AppBar(title: const Text('Edit Link')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: formKey,
          child: Container(
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextFormField(
                  label: 'Title',
                  hint: 'snapshout',
                  controller: titleController,
                  validator: (title) {
                    if (title == null || title.isEmpty) {
                      return 'please enter the title';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  label: 'Link',
                  hint: 'http://example.com',
                  controller: linkController,
                  validator: (link) {
                    if (link == null || link.isEmpty) {
                      return 'please enter the link';
                    }
                    if (!link.contains(".com")) {
                      return 'please enter valid link';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),
                SecondaryButtonWidget(
                  onTap: _EditLink,
                  text: 'SAVE',
                  width: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
