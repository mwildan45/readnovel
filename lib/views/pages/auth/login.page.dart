import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/services/validator.service.dart';
import 'package:read_novel/view_models/auth.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:read_novel/widgets/form_field/auth.form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
        viewModelBuilder: () => AuthViewModel(context),
        onModelReady: (model) => model.initialise(),
        builder: (context, vm, child) {
          //third party auth
          Widget socialButtons = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: boxDecorationWithRoundedCorners(
                    borderRadius: radius(10), backgroundColor: Colors.deepOrange),
                padding: const EdgeInsets.all(8),
                child: const Icon(FontAwesomeIcons.google, color: white, size: 24),
              ).onTap(vm.onLoginGoogle),
              16.width,
              Container(
                decoration: boxDecorationWithRoundedCorners(
                    borderRadius: radius(10), backgroundColor: Colors.blueAccent),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.facebook, color: white, size: 24),
              ).onTap(vm.onLoginFacebook),
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
                              key: vm.formKey,
                              child: Column(
                                children: [
                                  EditText(
                                    hintText: 'masukkan email',
                                    isPassword: false,
                                    mController: vm.email,
                                    mKeyboardType: TextInputType.emailAddress,
                                    validator: FormValidator.validateEmail,
                                  ),
                                  14.height,
                                  EditText(
                                    hintText: 'masukkan password',
                                    isPassword: true,
                                    mController: vm.password,
                                    isSecure: true,
                                    validator: FormValidator.validatePassword,
                                  ),
                                  8.height,
                                ],
                              ),
                            ),
                          ),
                          20.height,
                          CustomButton(
                            isGradientColor: true,
                            loading: vm.isBusy,
                            shapeRadius: 10,
                            title: 'LOGIN',
                            titleStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            onPressed: vm.onLocalLogin,
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
                                    onTap: vm.navRegisterPage,
                                    child: const Text('Daftar!',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.cyan,
                                        )),
                                )
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
        });
  }
}
