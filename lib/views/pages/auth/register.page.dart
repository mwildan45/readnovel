import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:read_novel/widgets/form_field/auth.form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(AppImages.appLogoTransparent,
                        width: 150, height: 150).centered(),
                    24.height,
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Form(
                        // key: _formKey,
                        child: Column(
                          children: [
                            EditText(
                              hintText: 'masukkan email',
                              isPassword: false,
                              // mController: usernameCont,
                              mKeyboardType: TextInputType.name,
                              validator: (String? s) {},
                            ),
                            14.height,
                            EditText(
                              hintText: 'masukkan username',
                              isPassword: false,
                              // mController: usernameCont,
                              mKeyboardType: TextInputType.emailAddress,
                              validator: (String? s) {},
                            ),
                            14.height,
                            EditText(
                              hintText: 'masukkan password',
                              isPassword: true,
                              // mController: passwordCont,
                              isSecure: true,
                              validator: (String? s) {},
                            ),
                            14.height,
                            EditText(
                              hintText: 'konfirmasi password',
                              isPassword: true,
                              // mController: passwordCont,
                              isSecure: true,
                              validator: (String? s) {},
                            ),
                            8.height,
                          ],
                        ),
                      ),
                    ),
                    VStack(
                      [
                        'Dengan mengklik tombol daftar di bawah ini, Anda menyetujui'.text.sm.gray400.size(12).make(),
                        HStack(
                          [
                            'Syarat & Ketentuan'.text.sm.cyan500.size(12).make(),
                            ' dan '.text.sm.gray400.size(12).make(),
                            'Kebijakan Privasi'.text.sm.cyan500.size(12).make(),
                            ' Aplikasi ReadNovel'.text.sm.gray400.size(12).make(),
                          ]
                        ),
                      ],
                    ).px20(),
                    12.height,
                    CustomButton(
                      color: Colors.cyan,
                      title: 'DAFTAR',
                      titleStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      onPressed: () {},
                    ).px20(),
                    20.height,
                  ],
                ),
              ),
            ),
          ),
          // isLoading
          //     ? Container(
          //         child: CircularProgressIndicator(),
          //         alignment: Alignment.center,
          //       )
          //     : SizedBox(),
        ],
      ),
    );
  }
}
