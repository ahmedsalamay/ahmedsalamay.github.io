import 'dart:typed_data';

import 'package:fimto_frame/themes/theme.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'choose_frame_viewmodel.dart';
import '../../models/constants.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/drawer.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:flutter/material.dart';

class ChooseFrameDesktop extends StatelessWidget {
  final List<Uint8List> pickedFile;

  const ChooseFrameDesktop({Key? key, required this.pickedFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChooseFrameViewModel>(
        create: (_) => ChooseFrameViewModel(pickedFiles: pickedFile),
        child: Scaffold(
          backgroundColor: Colors.white,
          endDrawer: CustomDrawer(),
          body: _Body(),
        ));
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(title: S.of(context).chooseYourFrame),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _Preview(),
                ),
                Expanded(flex: 1, child: _Frames()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Preview extends StatelessWidget {
  const _Preview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFf9f9f9),
      child: Column(
        children: [
          SizedBox(height: 100),
          _FramePreview(),
          SizedBox(height: 50),
          _AddMore()
        ],
      ),
    );
  }
}

class _Frames extends StatelessWidget {
  const _Frames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<ChooseFrameViewModel>();
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 25),
      width: 200,
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: frames.values
                  .toList()
                  .map((e) => GestureDetector(
                        onTap: () => vm.selectFrameAction(e),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          color: vm.selectedFrame == e
                              ? Color(0xFFf4f4f4)
                              : Colors.transparent,
                          child: Row(
                            children: [
                              Image(
                                height: 50,
                                fit: BoxFit.contain,
                                image: AssetImage(
                                    'assets/images/${e.toString().split('.')[1]}.png'),
                              ),
                              SizedBox(width: 6),
                              Text(
                                e.toString().split('.')[1],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          SizedBox(
            width: 200,
            child: GradientButton(
                text: S.of(context).checkout,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return _BottomSheet();
                      });
                }),
          )
        ],
      ),
    );
  }
}

class _FramePreview extends StatelessWidget {
  const _FramePreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<ChooseFrameViewModel>();
    return CarouselSlider(
      options: CarouselOptions(
        height: 300.0,
        // viewportFraction: 0.8,
        enableInfiniteScroll: false,
      ),
      items: vm.pickedFiles.map((file) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              height: 300,
              width: 300,
              child: Stack(
                overflow: Overflow.clip,
                //fit: StackFit.loose,
                children: [
                  Image(
                    height: 300,
                    width: 300,
                    fit: BoxFit.fill,
                    image: AssetImage(
                        'assets/images/${vm.selectedFrame.toString().split('.')[1]}.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 40, 38),
                    child: Image.memory(
                      file,
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class _AddMore extends StatelessWidget {
  const _AddMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.grey,
      onTap: () => print('tap'),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(2, 2),
                  spreadRadius: 0,
                  blurRadius: 2)
            ]),
        child: Icon(
          Icons.add,
          size: 30,
          color: FimtoColors.primaryColor,
        ),
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          height: 250.0,
          width: 350,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(const Radius.circular(15.0))),
          child: Column(
            children: [
              _SheetRowItem('3 Frames', '269LE'),
              _SheetRowItem('Extra Frame', '74LE'),
              _SheetRowItem('Delivery', 'Free'),
              Divider(),
              _SheetTotal('Total', '343LE'),
              Spacer(),
              SizedBox(
                width: 120,
                child: GradientButton(
                    text: S.of(context).addAddress,
                    onTap: () => Get.toNamed(addAddressRoute)),
              )
            ],
          ),
        )
      ],
    );
  }
}

class _SheetRowItem extends StatelessWidget {
  final String title;
  final String value;

  const _SheetRowItem(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFF737888),
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFF737888),
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SheetTotal extends StatelessWidget {
  final String title;
  final String value;

  const _SheetTotal(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
