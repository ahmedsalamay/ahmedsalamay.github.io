import 'package:card_swiper/card_swiper.dart';
import 'package:fimto_frame/models/facebook_photo.dart';
import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/repository/remote/facebook_repository.dart';
import 'package:fimto_frame/repository/remote/order_repository.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'choose_frame_viewmodel.dart';
import '../../models/constants.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/drawer.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:flutter/material.dart';

class ChooseFrameMobile extends StatelessWidget {
  const ChooseFrameMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var language = context.watch<Language>();

    return ChangeNotifierProvider<ChooseFrameViewModel>(
        create: (_) => ChooseFrameViewModel(
              facebookRepository: context.read<FacebookRepository>(),
              connectionService: context.read<ConnectionService>(),
              orderRepository: context.read<OrderRepository>(),
              messageService: context.read<MessageService>(),
              order: context.read<Order>(),
            ),
        child: Scaffold(
          backgroundColor: Colors.white,
          endDrawer: language.currentLocale.languageCode == 'en'
              ? const CustomDrawer()
              : null,
          drawer: language.currentLocale.languageCode == 'ar'
              ? const CustomDrawer()
              : null,
          body: const _Body(),
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
                        const SizedBox(height: 25),
                        const _Frames(),
                        const SizedBox(height: 20),
                        vm.isImagesPicked
                            ? const _FramePreview()
                            : const _PickPhotos(),
                        const SizedBox(height: 25),
                        Text(
                          S.of(context).chooseSuitableDesign,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        const SizedBox(height: 15),
                        vm.isWallVisible ? const _Walls() : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
              vm.showCheckOutButton
                  ? GradientButton(
                      text: S.of(context).checkout,
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (builder) {
                              return _BottomSheet(
                                buildContext: context,
                              );
                            });
                      })
                  : Padding(
                      padding: const EdgeInsets.all(25.0),
                      child:
                          Text('${vm.pickedFiles.length} / ${vm.packageSize}'),
                    )
            ],
          ),
          Visibility(
              visible: vm.isLoading,
              child: const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator()))
        ],
      ),
    );
  }
}

class _Walls extends StatelessWidget {
  const _Walls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<ChooseFrameViewModel>();
    return SizedBox(
      height: 300,
      width: 300,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: <Widget>[
              GestureDetector(
                onTapDown: (TapDownDetails details) {
                  print(details.globalPosition.dx.toString() +
                      '----' +
                      details.globalPosition.dy.toString());
                },
                child: const Image(
                  height: 300,
                  width: 300,
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/wall.jpg'),
                ),
              ),
            ] +
            vm.wall.images
                .asMap()
                .entries
                .map(
                  (image) => Positioned(
                    left: (image.value.x * 300 / vm.wall.areaWidth),
                    top: (image.value.y * 300 / vm.wall.areaHeight),
                    child: _FramesForWall(
                        index:
                            image.key >= vm.pickedFiles.length ? 0 : image.key),
                    // child: Image.memory(
                    //   vm.pickedFiles[
                    //       image.key >= vm.pickedFiles.length ? 0 : image.key],
                    //   height: 80,
                    //   width: 80,
                    //   fit: BoxFit.fill,
                    // ),
                  ),
                )
                .toList(),
      ),
    );
  }
}

class _FramesForWall extends StatelessWidget {
  final int index;
  const _FramesForWall({Key? key, required this.index}) : super(key: key);

  final classicPadding = const EdgeInsets.fromLTRB(7.2, 6.4, 13, 12.2);
  final cleanPadding = const EdgeInsets.fromLTRB(3.2, 3.2, 10.6, 10.1);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<ChooseFrameViewModel>();
    return SizedBox(
      height: 80,
      width: 80,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Image(
            height: 80,
            width: 80,
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
              height: 80,
              width: 65,
              fit: BoxFit.fill,
            ),
          ),
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
      child: SizedBox(
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
            const SizedBox(height: 40),
            const _UploadPhoto(),
            const SizedBox(height: 35),
            const _ImportPhoto()
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
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 2), // changes position of shadow
          )
        ],
      ),
      child: MaterialButton(
        onPressed: () => vm.uploadPhoto(),
        elevation: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.camera_alt,
              color: FimtoColors.primaryColor,
              size: 40,
            ),
            const SizedBox(height: 15),
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
    return SizedBox(
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 2), // changes position of shadow
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
                    IconButton(
                      icon: Image.asset('assets/images/facebook.png'),
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
                    ),
                    const SizedBox(height: 15),
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
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 2), // changes position of shadow
                  )
                ],
              ),
              child: MaterialButton(
                onPressed: () =>
                    context.read<ChooseFrameViewModel>().instgramLogin(),
                elevation: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset('assets/images/instagram_colored.png'),
                      padding: const EdgeInsets.all(0),
                      onPressed: () =>
                          context.read<ChooseFrameViewModel>().instgramLogin(),
                    ),
                    const SizedBox(height: 15),
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
    return SizedBox(
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
                            ? const Color(0xFFf4f4f4)
                            : Colors.transparent,
                        child: Column(
                          children: [
                            Image(
                              height: 50,
                              fit: BoxFit.contain,
                              image: AssetImage(
                                  'assets/images/${e.toString().split('.')[1]}.png'),
                            ),
                            const SizedBox(height: 6),
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
          const SizedBox(height: 12),
          const Divider()
        ],
      ),
    );
  }
}

class _FramePreview extends StatelessWidget {
  const _FramePreview({Key? key}) : super(key: key);

  final classicPadding = const EdgeInsets.fromLTRB(24, 24, 49, 46);
  final cleanPadding = const EdgeInsets.fromLTRB(12, 12, 40, 38);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<ChooseFrameViewModel>();

    return Column(
      children: [
        SizedBox(
          height: 300,
          width: 600,
          child: Directionality(
            textDirection: TextDirection.ltr,
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
                  child: SizedBox(
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
                                icon: const Icon(
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
        ),
        const _AddMore()
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
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 2), // changes position of shadow
              )
            ]),
        child: const Icon(
          Icons.add,
          size: 30,
          color: FimtoColors.primaryColor,
        ),
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  final BuildContext buildContext;
  const _BottomSheet({Key? key, required this.buildContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = buildContext.read<ChooseFrameViewModel>();
    return Container(
      height: 280.0,
      color: Colors.white,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0))),
          child: Column(
            children: [
              _SheetRowItem(vm.packageSize + S.of(context).frames,
                  vm.packagePrice + S.of(context).le),
              Visibility(
                  //TODO Show Extra frame or not when no extra
                  visible: true, //vm.isExtraFrames,
                  child: _SheetRowItem(S.of(context).extraFrame,
                      vm.extraFramesPrice + S.of(context).le)),
              _SheetRowItem(S.of(context).delivery, vm.deliveryFees),
              const Divider(),
              _SheetTotal(S.of(context).total, vm.total + S.of(context).le),
              const Spacer(),
              GradientButton(
                  text: S.of(context).addAddress,
                  onTap: () => vm.checkoutAction())
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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: Text(
              S.of(context).delete,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () => vm.removePhoto(index),
          ),
          const Divider(height: 2),
          GestureDetector(
              child: Text(
                S.of(context).dismiss,
                style: const TextStyle(fontSize: 18, color: Colors.black),
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
            style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF737888),
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          Text(
            value,
            style: const TextStyle(
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
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
          Text(
            value,
            style: const TextStyle(
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
  const FacebookPhotos(
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
    return SizedBox(
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
                    child: const Text('Done')),
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
                              ? const Icon(Icons.check_box_outlined,
                                  color: Colors.blue)
                              : const Icon(
                                  Icons.check_box_outline_blank_outlined,
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

class WebViewDialogDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: WebviewScaffold(
        url: InstagramConst.authorizeCodeApiUrl,
        withZoom: true,
        initialChild: Container(
          color: Colors.redAccent,
          child: const Center(
            child: Text("Loading...."),
          ),
        ),
      ),
    );
  }
}
