import 'dart:io';

import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/register_as_writer.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ConfirmDataWriterPage extends StatefulWidget {
  const ConfirmDataWriterPage({Key? key, required this.vm}) : super(key: key);
  final RegisterAsWriterViewModel vm;

  @override
  State<ConfirmDataWriterPage> createState() => _ConfirmDataWriterPageState();
}

class _ConfirmDataWriterPageState extends State<ConfirmDataWriterPage> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      bodyBgColor: AppColor.ghostWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: VStack([
            Image.asset(AppImages.appLogoHorizontal)
                .w(180)
                .center()
                .pOnly(top: Vx.dp24),
            UiSpacer.verticalSpace(),
            VStack(
              [
                Column(
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: FileImage(File(widget.vm.selectedPhotoKTP!.path)),
                            fit: BoxFit.cover,
                          )),
                    )
                        .box
                        .white
                        .border(color: AppColor.fadedGrey)
                        .rounded
                        .width(160)
                        .height(90)
                        .make(),
                    UiSpacer.verticalSpace(),
                    'Nama Asli:'.text.sm.italic.make(),
                    widget.vm.realNameCon.text.text.bold.lg.make(),
                    4.height,
                    'Tgl. Lahir:'.text.sm.italic.make(),
                    "${widget.vm.formatedTglLahir}".text.bold.lg.make(),
                    4.height,
                    'No. Identitas:'.text.sm.italic.make(),
                    widget.vm.noIdCon.text.text.bold.lg.make(),
                    4.height,
                    'Alamat:'.text.sm.italic.make(),
                    widget.vm.addressCon.text.text.bold.lg.make(),
                    4.height,
                    'Tgl. Lahir:'.text.sm.italic.make(),
                    "${widget.vm.formatedTglLahir}".text.bold.lg.make(),
                    4.height,
                    'No. Telp/Whatsapp'.text.sm.italic.make(),
                    widget.vm.phoneCon.text.text.bold.lg.make(),
                    UiSpacer.verticalSpace(),
                    '- Data Pembayaran -'.text.bold.make(),
                    8.height,
                    'Nama Bank:'.text.sm.italic.make(),
                    widget.vm.bankNameCon.text.text.bold.lg.make(),
                    4.height,
                    'Atas Nama:'.text.sm.italic.make(),
                    widget.vm.bankOwnerAccountCon.text.text.bold.lg.make(),
                    4.height,
                    'No.Rekening:'.text.sm.italic.make(),
                    widget.vm.bankAccountCon.text.text.bold.lg.make(),
                  ],
                ).py8().box
                    .rounded.shadowSm
                    // .outerShadowMd
                    .shadowOutline(outlineColor: AppColor.grey)
                    .white
                    .p8
                    .make().wFull(context)
                    .px16()
                    .centered(),
                UiSpacer.verticalSpace(),
                EasyRichText(
                  'Jika data tersebut benar, kamu bisa register as penulis dengan pencet tombol di bawah, dan dengan ini'
                      ' kamu menyetujui Syarat & Ketentuan dan Kebijakan yang ada di Aplikasi ReadNovel.',
                  patternList: [
                    EasyRichTextPattern(
                      targetString: 'Syarat & Ketentuan',
                      style: const TextStyle(color: Colors.blue),
                    ),
                    EasyRichTextPattern(
                      targetString: 'Kebijakan',
                      style: const TextStyle(color: Colors.blue),
                    ),
                    EasyRichTextPattern(
                      targetString: 'ReadNovel',
                      style: TextStyle(color: AppColor.royalOrange),
                    ),
                  ],
                  defaultStyle: const TextStyle(fontSize: 11),
                ),
                UiSpacer.verticalSpace(),
                CustomButton(
                  height: 52,
                  isGradientColor: true,
                  loading: isLoading,
                  shapeRadius: 30,
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await widget.vm.handleBecomeWriter();
                    setState(() {
                      isLoading = false;
                    });
                  },
                  title: 'Register',
                ).px8(),
                8.height,
                TextButton(onPressed: () => context.pop(), child: 'Kembali'.text.sm.black.bold.make()),
                UiSpacer.verticalSpace()
              ],
              crossAlignment: CrossAxisAlignment.center,
            ).wFull(context).px12().center(),
          ]),
        ),
      ),
    );
  }
}
