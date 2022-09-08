import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/constants/app_strings.dart';
import 'package:read_novel/models/faq.model.dart';
import 'package:read_novel/requests/profile.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileViewModel extends MyBaseViewModel {
  ProfileViewModel(BuildContext context){
    viewContext = context;
  }

  ProfileRequest profileRequest = ProfileRequest();
  List<FAQ>? faq;


  @override
  void initialise() {

  }

  //
  getFAQData() async {

    setBusyForObject(faq, true);

    try {
      faq = await profileRequest.getFAQ();

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }

    setBusyForObject(faq, false);
  }

  navPusatBantuanPage(){
    viewContext?.navigator?.pushNamed(AppRoutes.faqRoute);
  }


  navKoinkuPage(){
    viewContext?.navigator?.pushNamed(AppRoutes.koinkuRoute);
  }

  onLoginPage() {
    viewContext?.navigator?.pushNamed(AppRoutes.loginRoute);
  }

  processLogout() async {
    AuthServices.logout(viewContext!);
  }

  openEmailForFeedback() async {
    EmailContent email = EmailContent(
      to: [
        'editorreadnovel@gmail.com',
      ],
      subject: 'Umpan Balik - ${getStringAsync(AppStrings.userEmail)}',
    );

    // Android: Will open mail app or show native picker.
    // iOS: Will open mail app if single mail app found.
    var result = await OpenMailApp.composeNewEmailInMailApp(emailContent: email);

    // If no mail apps found, show error
    if (!result.didOpen && !result.canOpen) {
      showToast(msg: 'tidak ada aplikasi email tersedia');

      // iOS: if multiple mail apps found, show dialog to select.
      // There is no native intent/default app system in iOS so
      // you have to do it yourself.
    } else if (!result.didOpen && result.canOpen) {
      showDialog(
        context: viewContext!,
        builder: (_) {
          return MailAppPickerDialog(
            mailApps: result.options,
            emailContent: email,
          );
        },
      );
    }
  }

  openReadNovelInstagram() async {
    var url = 'https://instagram.com/readnovel.id?igshid=YmMyMTA2M2Y=';

    if (await canLaunch(url)) {
      await launch(
        url,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }
}