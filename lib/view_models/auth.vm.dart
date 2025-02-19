import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/api.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/constants/app_strings.dart';
import 'package:read_novel/models/login.model.dart';
import 'package:read_novel/models/register.model.dart';
import 'package:read_novel/requests/auth.request.dart';
import 'package:read_novel/requests/social.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';


class AuthViewModel extends MyBaseViewModel {
  AuthViewModel(BuildContext context){
    viewContext = context;
  }

  SocialRequest socialRequest = SocialRequest();
  AuthRequest authRequest = AuthRequest();
  Register? register;
  Login? login;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  void initialise(){
    //
  }


  void onLocalLogin() async {

    if (formKey.currentState!.validate()) {
      setBusy(true);

      try {
        final result = await authRequest.login(
          {
            'email': email.text,
            'password': password.text
          }
        );

        if(result.status == 'success'){
          login = Login.fromJson(result.data);
        }else{
          ScaffoldMessenger.of(viewContext!).showSnackBar(SnackBar(content: Text(result.message)));
        }

        setValue(AppStrings.profileImg, login?.profile ?? "");

        setAuth(login);

        clearErrors();
      } catch (error) {
        setError(error);
        print("FAILED TO LOGIN: $error");
        ScaffoldMessenger.of(viewContext!).showSnackBar(SnackBar(content: Text('$error')));
      }

      setBusy(false);

    }
  }


  void onLocalRegister() async {

    if (formKey.currentState!.validate()) {
      if(password.text == confirmPassword.text) {
        setBusy(true);

        try {
          final result = await authRequest.register(
              {
                'username': username.text,
                'email': email.text,
                'password': password.text
              }
          );

          if(result.status == 'success'){
            register = Register.fromJson(result.data);
          }else{
            ScaffoldMessenger.of(viewContext!).showSnackBar(SnackBar(content: Text(result.message)));
          }

          setValue(AppStrings.profileImg, register?.profile ?? "");

          setAuth(register);

          clearErrors();
        } catch (error) {
          setError(error);
          print("FAILED TO LOGIN: $error");
          ScaffoldMessenger.of(viewContext!).showSnackBar(
              SnackBar(content: Text('$error')));
        }

        setBusy(false);
      }else{
        ScaffoldMessenger.of(viewContext!).showSnackBar(
            const SnackBar(content: Text('Password konfirmasi anda tidak sama')));
      }
    }
  }


  void onLoginGoogle() async {
    setBusy(true);

    try {

      await socialRequest.handleSignInGoogle().then((value) async {
        print('val gmail $value');
        await setRegister(value, true);
      });

      clearErrors();
    } catch (error){
      setError(error);
      print("FAILED TO LOGIN: $error");
      ScaffoldMessenger.of(viewContext!).showSnackBar(SnackBar(content: Text('Failed to Login: $error')));
    }

    setBusy(false);
  }

  void onLoginFacebook() async {
    setBusy(true);

    try {

      await socialRequest.handleSignInFacebook().then((value) async {
        print('val fb $value');
        await setRegister(value, true);
      });

      clearErrors();
    } catch (error){
      setError(error);
      print("FAILED TO LOGIN: $error");
      ScaffoldMessenger.of(viewContext!).showSnackBar(SnackBar(content: Text('Failed to Login: $error')));
    }

    setBusy(false);
  }


  setRegister(params, isSocialLogin) async {
    try {

      final result = await authRequest.register(params);
      register = Register.fromJson(result.data);

      if(isSocialLogin) {
        setValue(AppStrings.isSocialLogin, true);
      }else{
        setValue(AppStrings.isSocialLogin, false);
      }

      await setAuth(register);

      clearErrors();
    } catch (error){
      setError(error);
      print("FAILED TO LOGIN: $error");
      ScaffoldMessenger.of(viewContext!).showSnackBar(const SnackBar(content: Text('Failed to Login')));
    }
  }


  setAuth(data) async {
    try {

      await AuthServices.isAuthenticated();
      await AuthServices.setAuthBearerToken(data.accesstoken);

      if(data.profile != null){
        setValue(AppStrings.profileImg, Api.baseProfilePictureUrl + (data.profile ?? ""));
      }

      await AuthServices.setProfileValue(data);

      viewContext?.navigator?.pushNamedAndRemoveUntil(
        AppRoutes.homeRoute,
            (route) => false,
      );
    } catch (error){
      setError(error);
      print("FAILED TO REDIRECT: $error");
      // ScaffoldMessenger.of(viewContext!).showSnackBar(const SnackBar(content: Text('Cant ')));
    }
  }

  navRegisterPage() {
    viewContext?.navigator?.pushNamed(AppRoutes.registerRoute);
  }
}