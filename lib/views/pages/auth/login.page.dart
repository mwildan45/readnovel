
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_images.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:read_novel/widgets/form_field/auth.form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    Widget socialButtons = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: boxDecorationWithRoundedCorners(borderRadius: radius(10), backgroundColor: Colors.deepOrange),
          padding: EdgeInsets.all(8),
          child: Icon(FontAwesomeIcons.google, color: white, size: 24),
        ).onTap(() {
          // onGoogleSignInTap();
        }),
        16.width,
        Container(
          decoration: boxDecorationWithRoundedCorners(borderRadius: radius(10), backgroundColor: Colors.blueAccent),
          padding: EdgeInsets.all(8),
          child: Icon(Icons.facebook, color: white, size: 24),
        ).onTap(() {
          // MobileNumberSignInScreen().launch(context);
        }),
        // 16.width,
        // Container(
        //   decoration: boxDecorationWithRoundedCorners(borderRadius: radius(10), backgroundColor: Colors.black),
        //   padding: EdgeInsets.all(8),
        //   child: Image.asset(ic_apple, color: white, width: 24, height: 24),
        // ).onTap(() {
        //   // appleLogIn();
        // }).visible(Platform.isIOS),
      ],
    );

    return BasePage(
      body: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(AppImages.appLogoTransparent,
                        width: 150, height: 150),
                    24.height,
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Form(
                        // key: _formKey,
                        child: Column(
                          children: [
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
                            8.height,
                          ],
                        ),
                      ),
                    ),
                    8.height,
                    CustomButton(
                      color: Colors.cyan,
                      title: 'LOGIN',
                      titleStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      onPressed: () {},
                    ).px20(),
                    20.height,
                    socialButtons,
                    16.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Pengguna baru?',
                            style: primaryTextStyle(
                              size: 14,
                            )),
                        Container(
                          margin: const EdgeInsets.only(left: 4),
                          child: GestureDetector(
                              child: const Text('Daftar!',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyan,
                                  )),
                              onTap: () {
                                context.navigator?.pushNamed(AppRoutes.registerRoute);
                                // SignUpScreen().launch(context);
                              }),
                        )
                      ],
                    ),
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
