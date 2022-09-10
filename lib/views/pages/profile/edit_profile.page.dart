import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/services/validator.service.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/profile.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:read_novel/widgets/form_field/auth.form_field.dart';
import 'package:read_novel/widgets/picker/image_picture_profile.picker.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(context),
      onModelReady: (model) => model.getLocalDataProfile(),
      builder: (context, vm, child) {
        return BasePage(
          activeContext: context,
          withAppBar: true,
          customAppBar: true,
          onBackPressed: () => vm.onBackPressed(),
          title: 'Edit Akun',
          body: SingleChildScrollView(
            child: VStack(
              [
                UiSpacer.verticalSpace(space: Vx.dp48),
                ImagePictureProfilePickerView(
                  vm: vm,
                ),
                UiSpacer.verticalSpace(space: Vx.dp32),
                Form(
                  key: vm.formKey,
                  child: Column(
                    children: [
                      EditText(
                        hintText: 'masukkan username',
                        isPassword: false,
                        mController: vm.username,
                        mKeyboardType: TextInputType.emailAddress,
                        validator: (val) =>
                            FormValidator.validateEmpty(val, errorTitle: 'Username'),
                      ),
                      14.height,
                      EditText(
                        hintText: 'masukkan nama asli',
                        isPassword: false,
                        mController: vm.realName,
                        mKeyboardType: TextInputType.emailAddress,
                        validator: (val) =>
                            FormValidator.validateEmpty(val, errorTitle: 'Nama Asli'),
                      ),
                      UiSpacer.verticalSpace(space: Vx.dp48),
                      CustomButton(
                        isGradientColor: true,
                        loading: vm.isBusy,
                        shapeRadius: 10,
                        title: 'Edit',
                        titleStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        onPressed: vm.updateProfile,
                      ).w24(context)
                    ],
                  ),
                ).px32(),
              ],
            ).pOnly(left: Vx.dp12, right: Vx.dp12),
          ),
        );
      },
    );
  }
}
