import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashtoz_flutter/domens/repository/user_data_provider.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/bottom_bars_pages/home_page.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/home_screen.dart';

import '../../../../config/palette.dart';
import '../../helper_widgets/actions_widgets.dart';
import '../../helper_widgets/menuShow.dart';

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(226, 224, 224, 1),
        body: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20.0),
          child: CustomScrollView(slivers: [
            // SliverAppBar(
            //   title: ActionsHelper(
            //     //botomPadding: 55,
            //     text: 'Կապ',
            //     fontFamily: 'Grapalat',
            //     rightPadding: 10.0,
            //     fontSize: 20,
            //     laterSpacing: 1,
            //     fontWeight: FontWeight.bold,
            //     color: Palette.appBarTitleColor,
            //   ),
            //   expandedHeight: 73,
            //   backgroundColor: Color.fromRGBO(226, 224, 224, 1),
            //   elevation: 0,
            //   automaticallyImplyLeading: false,
            //   systemOverlayStyle: SystemUiOverlayStyle(
            //       statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
            // ),
            SliverAppBar(
              flexibleSpace: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Կապ',
                  style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1,
                      fontFamily: 'GHEAGrapalat',
                      fontWeight: FontWeight.bold,
                      color: Palette.appBarTitleColor),
                ),
              ),
              expandedHeight: 73,
              backgroundColor: Color.fromRGBO(226, 224, 224, 1),
              elevation: 0,
              automaticallyImplyLeading: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
              actions: [
                MenuShow(),
              ],
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Container(
                  color: Color.fromRGBO(226, 224, 224, 1),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text(
                            'Մեզ նամակ ուղարկելու համար՝ լրացրեք ստորև բերված ձևը:',
                            style: TextStyle(
                                fontFamily: 'GHEAGrapalat',
                                fontSize: 12.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 20),
                          fullName(),
                          const SizedBox(height: 30),
                          email(),
                          const SizedBox(height: 30),
                          message(),
                          const SizedBox(height: 30),
                          sendButton(),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

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
          hintText: 'Էլ. փոստ',
          hintStyle: TextStyle(
              fontFamily: 'GHEAGrapalat',
              fontSize: 14.0,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w400)),
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (!value!.contains(RegExp(
            r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$'))) {
          return 'Մուտքագրված հասցեն սխալ է';
        }
        return null;
      },
    );
  }

  Widget fullName() {
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
          hintStyle: TextStyle(
              fontFamily: 'GHEAGrapalat',
              fontSize: 14.0,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w400)),
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty ||
            !value.contains(RegExp(
                r"^(?:[ա-ֆԱ-Ֆա-ֆԱ-Ֆ\w+а-яА-Яа-яА-Яa-zA-Z]{3,} [ա-ֆԱ-Ֆա-ֆԱ-Ֆ\w+а-яА-Яа-яА-Яa-zA-Za-zA-Z]{5,}){0,1}$"))) {
          return 'Մուտքագրված տվյալները սխալ են ';
        }
        return null;
      },
    );
  }

  Widget message() {
    return TextFormField(
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
          hintStyle: TextStyle(
              fontFamily: 'GHEAGrapalat',
              fontSize: 14.0,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w400)),
      autofocus: false,
      validator: (value) {
        if (!value!
            .contains(RegExp("[ա-ֆԱ-Ֆա-ֆԱ-Ֆ+а-яА-Яа-яА-Яa-zA-Za-zA-Z0-9]"))) {
          return null;
        }
        return null;
      },
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
            onPressed: () async {
              final email = emailController.text;
              final name = nameController.text;
              final message = messageConttroller.text;
              Map parameter = {
                "name": name,
                "email": email,
                "message": message,
                "locale": "hy"
              };

              if (_formKey.currentState!.validate()) {
                print('$email,$name,$message');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
                bool isSend = await userDataProvider.userContactForm(parameter);
                if (!isSend) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Failure')),
                  );
                } else {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
                }
              }
            },
            child: Text('Ուղարկել')));
  }
}
