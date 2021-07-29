import 'package:fimto_frame/themes/theme.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'choose_frame_viewmodel.dart';
import '../../models/constants.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/drawer.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class ChooseFrameDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChooseFrameViewModel>(
        create: (_) => ChooseFrameViewModel(),
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
        mainAxisAlignment: MainAxisAlignment.center,
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
    var vm = context.watch<ChooseFrameViewModel>();
    return Container(
      color: Color(0xFFf9f9f9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 130),
          vm.isImagesPicked ? _FramePreview() : _PickPhotos(),
        ],
      ),
    );
  }
}

class _Frames extends StatefulWidget {
  const _Frames({Key? key}) : super(key: key);

  @override
  __FramesState createState() => __FramesState();
}

class __FramesState extends State<_Frames> {
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
                                        color: vm.selectedFrame == e
                                            ? FimtoColors.primaryColor
                                            : Colors.black,
                                        fontWeight: FontWeight.w800),
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

class _PickPhotos extends StatelessWidget {
  const _PickPhotos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.of(context).pickUpSomePhotos,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(fontWeight: FontWeight.w900, fontSize: 22),
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _UploadPhoto(),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    S.of(context).or,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                _ImportPhoto()
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _UploadPhoto extends StatelessWidget {
  const _UploadPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.read<ChooseFrameViewModel>();
    return Container(
      height: 180,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFb4b4b4),
            blurRadius: 15.0, // soften the shadow
            spreadRadius: 2.0, //extend the shadow
            offset: Offset(
              3.0, // Move to right 10  horizontally
              3.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: MaterialButton(
        onPressed: () => vm.uploadPhoto(),
        elevation: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt,
              color: FimtoColors.primaryColor,
              size: 40,
            ),
            SizedBox(height: 15),
            Text(
              S.of(context).uploadPhotos,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImportPhoto extends StatelessWidget {
  const _ImportPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 250,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFb4b4b4),
                  blurRadius: 15.0, // soften the shadow
                  spreadRadius: 2.0, //extend the shadow
                  offset: Offset(
                    3.0, // Move to right 10  horizontally
                    3.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.facebook_sharp,
                  size: 35,
                ),
                SizedBox(width: 15),
                Text(
                  S.of(context).importFromFacebook,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            height: 80,
            width: 250,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFb4b4b4),
                  blurRadius: 15.0, // soften the shadow
                  spreadRadius: 2.0, //extend the shadow
                  offset: Offset(
                    3.0, // Move to right 10  horizontally
                    3.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.facebook_sharp,
                  size: 35,
                ),
                SizedBox(width: 15),
                Text(
                  S.of(context).importFromInstagram,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
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

    return Column(
      children: [
        Container(
          height: 300,
          width: 600,
          child: Swiper(
            itemHeight: 300,
            itemWidth: 300,
            itemBuilder: (BuildContext context, int index) {
              return MouseRegion(
                onEnter: (_) => vm.showDeleteButton(),
                onExit: (_) => vm.hideDeleteButton(),
                child: Container(
                  height: 300,
                  width: 300,
                  child: Stack(
                    clipBehavior: Clip.hardEdge,
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
                          vm.pickedFiles[index],
                          height: 300,
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Visibility(
                        visible: vm.isDeleteButtonVisible,
                        child: Positioned(
                            left: 30,
                            top: 30,
                            child: IconButton(
                              onPressed: () => vm.removePhoto(index),
                              icon: Icon(
                                Icons.delete,
                                size: 40,
                                color: Colors.red,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: vm.pickedFiles.length,
            viewportFraction: 0.8,
            scale: 0.9,
            loop: false,
          ),
        ),
        SizedBox(height: 50),
        _AddMore()
      ],
    );
  }
}

class _AddMore extends StatelessWidget {
  const _AddMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => context.read<ChooseFrameViewModel>().uploadPhoto(),
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFb4b4b4),
                blurRadius: 15.0, // soften the shadow
                spreadRadius: 2.0, //extend the shadow
                offset: Offset(
                  2.0, // Move to right 10  horizontally
                  2.0, // Move to bottom 10 Vertically
                ),
              )
            ]),
        child: Icon(
          Icons.add,
          size: 45,
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
