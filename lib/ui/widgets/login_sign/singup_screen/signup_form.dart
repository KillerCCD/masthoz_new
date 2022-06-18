import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/domens/blocs/register_bloc/register_bloc.dart';
import 'package:mashtoz_flutter/domens/blocs/register_bloc/register_state.dart';

class SignupForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.popAndPushNamed(context, '/homepage');
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        } else if (state.status.isSubmissionInProgress) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Container(
                  height: 23,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Palette.main),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: screenSize.height / 13),
                  const _FullNameInput(),
                  SizedBox(height: screenSize.height / 19),
                  const _EmailIput(),
                  SizedBox(height: screenSize.height / 19),
                  const PasswordInput(),
                  SizedBox(height: screenSize.height / 15),
                  const Align(
                      alignment: Alignment.centerRight, child: _SignupButton()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailIput extends StatelessWidget {
  const _EmailIput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          cursorColor: Palette.cursor,
          style: TextStyle(color: Palette.textLineOrBackGroundColor),
          decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Palette.textLineOrBackGroundColor)),
            enabledBorder: const UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Palette.textLineOrBackGroundColor)),
            labelText: 'էլ. փոստ',
            labelStyle: const TextStyle(
              fontFamily: 'GHEAGrapalat',
              fontSize: 14,
              color: Palette.labelText,
            ),
            focusColor: Palette.labelText,
            errorText: state.email.invalid ? 'Մուտքագրված հասցեն սխալ է' : null,
          ),
          onChanged: (email) =>
              context.read<RegisterCubit>().emailChanged(email),
        );
      },
    );
  }
}

class _FullNameInput extends StatelessWidget {
  const _FullNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.fullName != current.fullName,
      builder: (context, state) {
        return TextFormField(
          cursorColor: Palette.cursor,
          style: TextStyle(color: Palette.textLineOrBackGroundColor),
          decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Palette.textLineOrBackGroundColor)),
            enabledBorder: const UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Palette.textLineOrBackGroundColor)),
            labelText: 'Անուն Ազգանուն',
            labelStyle: const TextStyle(
              fontFamily: 'GHEAGrapalat',
              fontSize: 14,
              color: Palette.labelText,
            ),
            focusColor: Palette.labelText,
            errorText: state.fullName.invalid
                ? 'Մուտքագրված տվյալները սխալ են '
                : null,
          ),
          onChanged: (fullName) =>
              context.read<RegisterCubit>().fullaNameChanged(fullName),
        );
      },
    );
  }
}

class PasswordInput extends StatefulWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isHiddenPassword = true;

  void _togglePassword() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          cursorColor: Palette.cursor,
          style: TextStyle(color: Palette.textLineOrBackGroundColor),
          decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(255, 255, 255, 1))),
            enabledBorder: const UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(255, 255, 255, 1))),
            labelText: 'Գաղտնաբառ',
            labelStyle: const TextStyle(
                fontFamily: 'GHEAGrapalat',
                fontSize: 14,
                color: Color.fromRGBO(189, 189, 189, 1)),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: InkWell(
                onTap: _togglePassword,
                child: isHiddenPassword
                    ? const Icon(
                        Icons.visibility,
                        color: Palette.textLineOrBackGroundColor,
                      )
                    : const Icon(
                        Icons.visibility_off,
                        color: Palette.textLineOrBackGroundColor,
                      ),
              ),
            ),
            errorText: state.password.invalid ? 'Գաղտնաբառը հուսալի չէ' : null,
          ),
          obscureText: isHiddenPassword,
          onChanged: (password) =>
              context.read<RegisterCubit>().passwordChanged(password),
        );
      },
    );
  }
}

class _SignupButton extends StatefulWidget {
  const _SignupButton({Key? key}) : super(key: key);

  @override
  State<_SignupButton> createState() => _SignupButtonState();
}

class _SignupButtonState extends State<_SignupButton> {
  bool _isActive = false;

  void isActive() {
    setState(() {
      _isActive = !_isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
      return SizedBox(
        width: 47,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          // mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Stack(
                //fit: StackFit.expand,
                alignment: Alignment.centerRight,
                //overflow: Overflow.visible,
                children: [
                  /// bottom
                  Container(
                    width: 40,
                    height: 40,
                    // color: Colors.orange,
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        spreadRadius: -1,
                        blurRadius: 1,
                        offset: Offset(7, 5),
                      ),
                    ]),
                  ),
                  Container(
                    width: 37,
                    height: 40,
                    color: state.status.isValidated
                        ? Palette.main
                        : Palette.disableButton,
                    child: RawMaterialButton(
                      splashColor: Palette.whenTapedButton,
                      onPressed: () {
                        print('Status :: ${state.status.isPure}');
                        if (state.status.isValidated) {
                          isActive();
                          print('Status :: ${state.status.isValidated}');
                          context.read<RegisterCubit>().signUpCredentials();
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 26,
                      child: SvgPicture.asset('assets/images/Vector 81.svg'),
                    ),
                  ),

                  /// top
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

// class _ComplexButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             height: 60.0,
//             color: Palette.barColor,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [SignUpButton(), CoupleButtons()],
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }


