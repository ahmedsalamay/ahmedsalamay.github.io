import 'package:fimto_frame/repository/remote/instagram_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'instagram_picker_viewmodel.dart';

class InstgramPicker extends StatelessWidget {
  final String code;
  const InstgramPicker({required this.code, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<InstagramPickerViewModel>(
        create: (_) => InstagramPickerViewModel(
          instagramAcessTokenCode: code,
          instagramRepository: context.read<InstagramRepository>(),
        ),
        builder: (context, child) => _Body(),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    context.read<InstagramPickerViewModel>().initAsync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
