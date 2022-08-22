import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/requests/auth.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';


class AuthViewModel extends MyBaseViewModel {
  AuthViewModel(BuildContext context){
    viewContext = context;
  }

  AuthRequest authRequest = AuthRequest();

  @override
  void initialise(){
    //
  }

  void onLoginGoogle() async {
    setBusy(true);

    try {
      await authRequest.handleSignInGoogle().then((value) async {
        print('val gmail ${value}');
        await setAuth();
      });

    } catch (error){
      print("FAILED TO LOGIN: $error");
      ScaffoldMessenger.of(viewContext!).showSnackBar(const SnackBar(content: Text('Failed to Login')));
    }

    setBusy(false);
  }

  void onLoginFacebook() async {
    await authRequest.handleSignInFacebook().then((value) {
      print('val login fb ${value}');
    });
  }

  setAuth() async {
    try {
      await AuthServices.isAuthenticated();
      viewContext?.navigator?.pushNamedAndRemoveUntil(
        AppRoutes.homeRoute,
            (route) => false,
      );
    } catch (error){
      print("FAILED TO REDIRECT: $error");
      // ScaffoldMessenger.of(viewContext!).showSnackBar(const SnackBar(content: Text('Cant ')));
    }
  }
}