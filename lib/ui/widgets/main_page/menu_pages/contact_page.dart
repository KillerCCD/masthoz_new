import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/palette.dart';
import '../../helper_widgets/actions_widgets.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(226, 224, 224, 1),
        body: CustomScrollView(slivers: [
          const SliverAppBar(
            expandedHeight: 73,
            backgroundColor: Color.fromRGBO(226, 224, 224, 1),
            pinned: false,
            floating: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color.fromRGBO(25, 4, 18, 1)),
            flexibleSpace: ActionsHelper(
              buttonShow: false,
              leftPadding: 50,
              // botomPadding: 0,
              // topPadding: 30,
              text: 'Կապ',
              fontFamily: 'Grapalat',
              fontSize: 20,
              laterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: Palette.appBarTitleColor,
            ),
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
                  Form(
                      child: Column(
                    children: [
                      fullName(),
                      const SizedBox(height: 30),
                      email(),
                      const SizedBox(height: 30),
                      message(),
                      const SizedBox(height: 30),
                      sendButton(),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget email() {
    return TextFormField(
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

  Widget fullName() {
    return TextFormField(
      cursorColor: Colors.black,
      decoration: const InputDecoration(
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
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget message() {
    return const TextField(
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
            onPressed: () {},
            child: Text('Ուղարկել')));
  }
}
