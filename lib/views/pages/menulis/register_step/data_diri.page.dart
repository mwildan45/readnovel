import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/services/validator.service.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/register_as_writer.vm.dart';
import 'package:read_novel/widgets/form_field/general.form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class DataDiriPenulisPage extends StatelessWidget {
  const DataDiriPenulisPage({Key? key, required this.vm}) : super(key: key);
  final RegisterAsWriterViewModel vm;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: vm.formKey,
        child: VStack(
          [
            UiSpacer.verticalSpace(),
            Image.asset(AppImages.appLogoOnly).w(50).h(50),
            8.height,
            'Satu langkah lagi untuk menjadi penulis!'
                .text
                .bold
                .lg
                .center
                .make(),
            UiSpacer.verticalSpace(space: Vx.dp24),
            // CircleAvatar(radius: 40),
            '*harap mengisi seluruh data dengan benar'
                .text
                .cyan500
                .sm
                .make()
                .objectCenterLeft(),
            8.height,
            CustomTextFormField(
              textEditingController: vm.realNameCon,
              height: 40,
              hintText: 'Nama Sebenarnya',
              maxLines: 1,
              validator: (val) => FormValidator.validateEmpty(val, errorTitle: 'Nama Sebenarnya'),
            ),
            4.height,
            Text(
              vm.formatedTglLahir ?? 'Tgl Lahir',
              style: TextStyle(color: vm.formatedTglLahir == null ? AppColor.romanSilver : Colors.black, fontSize: 14),
            ).py(15).px8().wFull(context).box.roundedLg.white.border(color: AppColor.grey).make().onTap(() {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                minTime: DateTime(1900, 1, 1),
                maxTime: DateTime(2100, 12, 31),
                theme: DatePickerTheme(
                    headerColor: AppColor.royalOrange,
                    backgroundColor: AppColor.ghostWhite2,
                    itemStyle: GoogleFonts.alata(
                        color: AppColor.fontColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    doneStyle: GoogleFonts.alata(color: Colors.white, fontSize: 16),
                    cancelStyle: GoogleFonts.alata(color: Colors.white, fontSize: 16)
                ),
                onChanged: (date) {
                  print('change $date in time zone ' +
                      date.timeZoneOffset.inHours.toString());
                },
                onConfirm: vm.onTglLahirSelected,
                currentTime: DateTime.now(),
                locale: LocaleType.id,
              );
            }),
            4.height,
            CustomTextFormField(
              textEditingController: vm.noIdCon,
              height: 40,
              hintText: 'No Identitas (KTP/Paspor/SIM)',
              maxLines: 1,
              validator: (val) => FormValidator.validateEmpty(val, errorTitle: 'No Identitas'),
            ),
            4.height,
            CustomTextFormField(
              textEditingController: vm.addressCon,
              hintText: 'Alamat',
              maxLines: 3,
              radius: 15,
              validator: (val) => FormValidator.validateEmpty(val, errorTitle: 'Alamat'),
            ),
            4.height,
            CustomTextFormField(
              textEditingController: vm.phoneCon,
              height: 40,
              hintText: 'No. Telp/Whatsapp',
              maxLines: 1,
              validator: (val) => FormValidator.validateEmpty(val, errorTitle: 'No. Telp/Whatsapp'),
            ),
            UiSpacer.verticalSpace(),
            '* Data Pembayaran'.text.bold.make(),
            8.height,
            CustomTextFormField(
              textEditingController: vm.bankNameCon,
              height: 40,
              hintText: 'Nama Bank',
              maxLines: 1,
              validator: (val) => FormValidator.validateEmpty(val, errorTitle: 'Nama Bank'),
            ),
            4.height,
            CustomTextFormField(
              textEditingController: vm.bankOwnerAccountCon,
              height: 40,
              hintText: 'Atas Nama',
              maxLines: 1,
              validator: (val) => FormValidator.validateEmpty(val, errorTitle: 'Atas Nama'),
            ),
            4.height,
            CustomTextFormField(
              textEditingController: vm.bankAccountCon,
              height: 40,
              hintText: 'Rekening',
              maxLines: 1,
              validator: (val) => FormValidator.validateEmpty(val, errorTitle: 'Rekening'),
            ),
          ],
          crossAlignment: CrossAxisAlignment.center,
        ).w(double.maxFinite).px32(),
      ),
    );
  }
}
