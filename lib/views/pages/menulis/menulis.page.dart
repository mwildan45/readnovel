import 'package:flutter/material.dart';
import 'package:read_novel/view_models/menulis.vm.dart';
import 'package:stacked/stacked.dart';

class MenulisPage extends StatefulWidget {
  const MenulisPage({Key? key}) : super(key: key);

  @override
  State<MenulisPage> createState() => _MenulisPageState();
}

class _MenulisPageState extends State<MenulisPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MenulisViewModel>.reactive(
      viewModelBuilder: () => MenulisViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, vm, child) {
        return SafeArea(
          child: Container(
            child: Text("Menulis"),
          ),
        );
      },
    );
  }
}
