import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashtoz_flutter/domens/repository/user_data_provider.dart';

import '../../../../config/palette.dart';
import '../../helper_widgets/actions_widgets.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final emailController = TextEditingController();
  final messageConttroller = TextEditingController();
  final nameController = TextEditingController();
  final userDataProvider = UserDataProvider();

  final _formKey = GlobalKey<FormState>();

  Widget email() {
    return TextFormField(
      controller: emailController,
      cursorColor: Colors.black,
      decoration: const InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(226, 224, 224, 1),
            ),
            borderRadius: BorderRadius.zero),
        hintText: 'Էլ․ փոստ',
      ),
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget fullName(FormFieldState state) {
    return TextFormField(
      controller: nameController,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.black)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(226, 224, 224, 1),
            ),
            borderRadius: BorderRadius.zero),
        hintText: 'Անուն Ազգանուն',
      ),
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget message(FormFieldState state) {
    return TextField(
      controller: messageConttroller,
      maxLines: 10,
      cursorColor: Colors.black,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(226, 224, 224, 1),
            ),
            borderRadius: BorderRadius.zero),
        hintText: 'Հաղորդագրություն',
      ),
      autofocus: false,
    );
  }

  Widget sendButton() {
    return Container(
        height: 40,
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(113, 141, 156, 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            onPressed: () {
              final email = emailController.text;
              final name = nameController.text;
              final message = messageConttroller.text;
              Map parameter = {
                "name": name,
                "email": email,
                "message": message,
                "locale": "hy"
              };
              userDataProvider.userContactForm(parameter);
            },
            child: Text('Ուղարկել')));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(226, 224, 224, 1),
        body: CustomScrollView(slivers: [
          SliverAppBar(
            title: ActionsHelper(
              //botomPadding: 55,
              text: 'Կապ',
              fontFamily: 'Grapalat',
              rightPadding: 10.0,
              fontSize: 20,
              laterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: Palette.appBarTitleColor,
            ),
            expandedHeight: 73,
            backgroundColor: Color.fromRGBO(226, 224, 224, 1),
            elevation: 0,
            automaticallyImplyLeading: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Color.fromRGBO(226, 224, 224, 1),
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const Text(
                      'Մեզ նամակ ուղարկելու համար՝ լրացրեք ստորև բերված ձևը:'),
                  const SizedBox(height: 20),
                  FormField(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      builder: (FormFieldState state) {
                        return Column(
                          children: [
                            fullName(state),
                            const SizedBox(height: 30),
                            email(),
                            const SizedBox(height: 30),
                            message(state),
                            const SizedBox(height: 30),
                            sendButton(),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
