import 'package:betweeener_app/controllers/link_controller.dart';
import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/views_features/main_app_view.dart';
import 'package:betweeener_app/views_features/widgets/custom_text_form_field.dart';
import 'package:betweeener_app/views_features/widgets/primary_outlined_button_widget.dart';
import 'package:betweeener_app/views_features/widgets/secondary_button_widget.dart';
import 'package:flutter/material.dart';

class AddLinkView extends StatefulWidget {
  static const id = '/addLink';
  AddLinkView({super.key});
   
  @override
  State<AddLinkView> createState() => _AddLinkViewState();
}

class _AddLinkViewState extends State<AddLinkView> {

  @override
  Widget build(BuildContext context) {
  BuildContext superContext = ModalRoute.of(context)!.settings.arguments as BuildContext;
  final TextEditingController titleController = TextEditingController();

  final TextEditingController linkController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void _addLink() {
    if (formKey.currentState!.validate()) {
      addUserLink({
        'title': titleController.text,
        'link': linkController.text,
      }).then((isAdded) {
        if (isAdded) {

          ScaffoldMessenger.of(superContext).showSnackBar(
            SnackBar(
              content: Text('Link added successfully'),
              backgroundColor: Colors.green,
            ),
          );
         Navigator.pop(context, true);
        }
      });
      //data ( emailcontrller , linkcontroller)
      //http method >> post
    }
  }

    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: AppBar(title: Text('Add Link'),
       ),
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
                  label: 'ttile',
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
                  label: 'link',
                  hint: 'http://example.com',
                  controller: linkController,
                  validator: (link) {
                    if (link == null || link.isEmpty) {
                      return 'please enter the link';
                    }
                    if (!link.contains(".com") ) {
                       return 'please enter valid link';
                    }
                    return null;
                  },
                ),
            
                SizedBox(height: 50),
            
                SecondaryButtonWidget(onTap: _addLink, text: 'ADD',width: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
