import 'dart:typed_data';

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

class ChooseFrameMobile extends StatelessWidget {
  final List<Uint8List> pickedFile;

  const ChooseFrameMobile({Key? key, required this.pickedFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChooseFrameViewModel>(
        create: (_) => ChooseFrameViewModel(pickedFiles: pickedFile),
        child: Scaffold(
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
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAppBar(title: S.of(context).chooseYourFrame),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 25),
                    _Frames(),
                    SizedBox(height: 20),
                    _FramePreview(),
                    SizedBox(height: 15),
                    Text(
                      S.of(context).chooseSuitableDesign,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GradientButton(
              text: S.of(context).checkout,
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return _BottomSheet();
                    });
              })
        ],
      ),
    );
  }
}

class _Frames extends StatelessWidget {
  const _Frames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.read<ChooseFrameViewModel>();
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: frames.values
                .toList()
                .map((e) => GestureDetector(
                      onTap: () => vm.selectFrameAction(e),
                      child: Column(
                        children: [
                          Image(
                            height: 50,
                            fit: BoxFit.contain,
                            image: AssetImage(
                                'assets/images/${e.toString().split('.')[1]}.png'),
                          ),
                          SizedBox(height: 6),
                          Text(
                            e.toString().split('.')[1],
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ))
                .toList(),
            // GestureDetector(
            //   onTap: () => vm.selectFrameAction(1),
            //   child: Image(
            //     height: 50,
            //     fit: BoxFit.contain,
            //     image: AssetImage('assets/images/frame2.png'),
            //   ),
            // ),
            // GestureDetector(
            //   onTap: () => vm.selectFrameAction(0),
            //   child: Image(
            //     height: 50,
            //     fit: BoxFit.contain,
            //     image: AssetImage('assets/images/frame1.png'),
            //   ),
            // ),
          ),
          SizedBox(height: 12),
          Divider()
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
        height: 200.0,
        // viewportFraction: 0.8,
        enableInfiniteScroll: false,
      ),
      items: vm.pickedFiles.map((file) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              height: 200,
              width: 200,
              child: Stack(
                overflow: Overflow.clip,
                //fit: StackFit.loose,
                children: [
                  Image(
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill,
                    image: AssetImage(
                        'assets/images/${vm.selectedFrame.toString().split('.')[1]}.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 28, 25),
                    child: Image.memory(
                      file,
                      height: 200,
                      width: 200,
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

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      color: Colors.white,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(15.0),
                  topRight: const Radius.circular(15.0))),
          child: Column(
            children: [
              _SheetRowItem('3 Frames', '269LE'),
              _SheetRowItem('Extra Frame', '74LE'),
              _SheetRowItem('Delivery', 'Free'),
              Divider(),
              _SheetTotal('Total', '343LE'),
              Spacer(),
              GradientButton(
                  text: S.of(context).addAddress,
                  onTap: () => Get.toNamed(addAddressRoute))
            ],
          )),
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
