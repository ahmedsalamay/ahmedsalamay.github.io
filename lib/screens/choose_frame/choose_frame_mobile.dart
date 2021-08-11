import 'package:card_swiper/card_swiper.dart';
import 'package:fimto_frame/models/facebook_photo.dart';
import 'package:fimto_frame/repository/remote/facebook_repository.dart';
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

class ChooseFrameMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChooseFrameViewModel>(
        create: (_) => ChooseFrameViewModel(
            facebookRepository: context.read<FacebookRepository>()),
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
    var vm = context.watch<ChooseFrameViewModel>();

    return SafeArea(
      child: Stack(
        children: [
          Column(
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
                        vm.isImagesPicked ? _FramePreview() : _PickPhotos(),
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
          Visibility(
              visible: vm.isLoading,
              child: Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator()))
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
            SizedBox(height: 40),
            _UploadPhoto(),
            SizedBox(height: 35),
            _ImportPhoto()
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
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 2), // changes position of shadow
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
    var vm = context.read<ChooseFrameViewModel>();
    return Container(
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 2), // changes position of shadow
                  )
                ],
              ),
              child: MaterialButton(
                onPressed: () =>
                    vm.facebookLogin().then((value) => value != null
                        ? Get.dialog(FacebookPhotos(
                            photos: value,
                            buildContext: context,
                            addFacebookPhoto: vm.addFacebookPhoto,
                          ))
                        : () {}),
                elevation: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.facebook,
                      color: Colors.blue,
                      size: 40,
                    ),
                    SizedBox(height: 15),
                    Text(
                      S.of(context).importFromFacebook,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 2), // changes position of shadow
                  )
                ],
              ),
              child: MaterialButton(
                onPressed: () =>
                    vm.facebookLogin().then((value) => value != null
                        ? Get.dialog(FacebookPhotos(
                            photos: value,
                            buildContext: context,
                            addFacebookPhoto: vm.addFacebookPhoto,
                          ))
                        : () {}),
                elevation: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.facebook,
                      color: Colors.blue,
                      size: 40,
                    ),
                    SizedBox(height: 15),
                    Text(
                      S.of(context).importFromInstagram,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class _Frames extends StatelessWidget {
  const _Frames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<ChooseFrameViewModel>();
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: frames.values
                .toList()
                .map((e) => GestureDetector(
                      onTap: () => vm.selectFrameAction(e),
                      child: Container(
                        padding: const EdgeInsets.all(4.0),
                        color: vm.selectedFrame == e
                            ? Color(0xFFf4f4f4)
                            : Colors.transparent,
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
                                      fontSize: 16,
                                      color: vm.selectedFrame == e
                                          ? FimtoColors.primaryColor
                                          : Colors.black,
                                      fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 12),
          Divider()
        ],
      ),
    );
  }
}

class _FramePreview extends StatelessWidget {
  _FramePreview({Key? key}) : super(key: key);

  final classicPadding = EdgeInsets.fromLTRB(24, 24, 49, 46);
  final cleanPadding = EdgeInsets.fromLTRB(12, 12, 40, 38);

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
              return GestureDetector(
                onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return _PhotoButtonSheet(index, context);
                    }),
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
                        padding: vm.selectedFrame == frames.classic ||
                                vm.selectedFrame == frames.permise
                            ? classicPadding
                            : cleanPadding,
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
        SizedBox(height: 30),
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
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 2), // changes position of shadow
              )
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

class _PhotoButtonSheet extends StatelessWidget {
  final int index;
  final BuildContext buildContext;
  const _PhotoButtonSheet(this.index, this.buildContext);

  @override
  Widget build(BuildContext context) {
    var vm = buildContext.watch<ChooseFrameViewModel>();
    return Container(
      height: 150.0,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: Text(
              S.of(context).delete,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () => vm.removePhoto(index),
          ),
          Divider(height: 2),
          GestureDetector(
              child: Text(
                S.of(context).dismiss,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              onTap: () => Navigator.pop(context))
        ],
      ),
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

class FacebookPhotos extends StatefulWidget {
  final PhotoPaging photos;
  final Function addFacebookPhoto;
  final BuildContext buildContext;
  FacebookPhotos(
      {Key? key,
      required this.photos,
      required this.addFacebookPhoto,
      required this.buildContext})
      : super(key: key);

  @override
  _FacebookPhotosState createState() => _FacebookPhotosState();
}

class _FacebookPhotosState extends State<FacebookPhotos> {
  Map<int, String> selectedFaceBookPhotos = <int, String>{};

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var vm = widget.buildContext.watch<ChooseFrameViewModel>();
    return Container(
      height: size.height * 0.7,
      width: size.width * 0.9,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1, vertical: size.height * 0.2),
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () => vm.addFacebookPhoto(
                        selectedFaceBookPhotos.values.toList()),
                    child: Text('Done')),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(widget.photos.data!.length, (index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedFaceBookPhotos.containsKey(index)
                          ? selectedFaceBookPhotos
                              .removeWhere((key, value) => key == index)
                          : selectedFaceBookPhotos[index] =
                              widget.photos.data![index].source;
                    });
                  },
                  //  widget.addFacebookPhoto(index, widget.photos.data![index].source),
                  child: Stack(
                    children: [
                      Image.network(
                        widget.photos.data![index].source,
                        fit: BoxFit.cover,
                        height: 100,
                        width: 90,
                      ),
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: selectedFaceBookPhotos.containsKey(index)
                              ? Icon(Icons.check_box_outlined,
                                  color: Colors.blue)
                              : Icon(Icons.check_box_outline_blank_outlined,
                                  color: Colors.grey),
                        ),
                        alignment: Alignment.topRight,
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
