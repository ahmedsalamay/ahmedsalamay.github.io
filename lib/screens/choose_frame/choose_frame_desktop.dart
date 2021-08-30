import 'package:fimto_frame/models/facebook_photo.dart';
import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/repository/remote/facebook_repository.dart';
import 'package:fimto_frame/repository/remote/order_repository.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'choose_frame_viewmodel.dart';
import '../../models/constants.dart';
import 'package:fimto_frame/themes/appBar.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:fimto_frame/themes/drawer.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class ChooseFrameDesktop extends StatelessWidget {
  const ChooseFrameDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChooseFrameViewModel>(
        create: (_) => ChooseFrameViewModel(
              facebookRepository: context.read<FacebookRepository>(),
              connectionService: context.read<ConnectionService>(),
              orderRepository: context.read<OrderRepository>(),
              messageService: context.read<MessageService>(),
              order: context.read<Order>(),
            ),
        child: const Scaffold(
          backgroundColor: Colors.white,
          endDrawer: CustomDrawer(),
          body: _Body(),
        ));
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAppBar(title: S.of(context).chooseYourFrame),
          Expanded(
            child: Row(
              children: const [
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
      color: const Color(0xFFf9f9f9),
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 130),
          vm.isImagesPicked ? const _FramePreview() : const _PickPhotos(),
          const SizedBox(height: 25),
          vm.isWallVisible ? const _Walls() : const SizedBox(),
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
      padding: const EdgeInsets.symmetric(horizontal: 25),
      width: 200,
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: frames.values
                  .toList()
                  .map((e) => MaterialButton(
                        onPressed: () => vm.selectFrameAction(e),
                        splashColor: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          color: vm.selectedFrame == e
                              ? const Color(0xFFf4f4f4)
                              : Colors.transparent,
                          child: Row(
                            children: [
                              Image(
                                height: 50,
                                fit: BoxFit.contain,
                                filterQuality: FilterQuality.high,
                                image: AssetImage(
                                    'assets/images/${e.toString().split('.')[1]}.png'),
                              ),
                              const SizedBox(width: 6),
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
              child: vm.showCheckOutButton
                  ? GradientButton(
                      text: S.of(context).checkout,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (builder) {
                              return _CheckoutDialog(
                                buildContext: context,
                              );
                            });
                      })
                  : Padding(
                      padding: const EdgeInsets.all(25.0),
                      child:
                          Text('${vm.pickedFiles.length} / ${vm.packageSize}'),
                    ))
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
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _UploadPhoto(),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    S.of(context).or,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                const _ImportPhoto()
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
        borderRadius: const BorderRadius.all(Radius.circular(6)),
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

    return MaterialButton(
      onPressed: () => vm.facebookLogin().then((value) => value != null
          ? Get.dialog(FacebookPhotos(
              photos: value,
              buildContext: context,
              addFacebookPhoto: vm.addFacebookPhoto,
            ))
          : () {}),
      child: SizedBox(
        height: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 250,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
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
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset('assets/images/facebook.png'),
                    padding: const EdgeInsets.all(0),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 15),
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
            const Spacer(),
            Container(
              height: 80,
              width: 250,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
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
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset('assets/images/instagram_colored.png'),
                    padding: const EdgeInsets.all(0),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 15),
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
      ),
    );
  }
}

class _FramePreview extends StatelessWidget {
  const _FramePreview({Key? key}) : super(key: key);

  final classicPadding = const EdgeInsets.fromLTRB(24, 24, 200, 46);
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
                return MouseRegion(
                  onEnter: (_) => vm.showDeleteButton(),
                  onExit: (_) => vm.hideDeleteButton(),
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
                            width: vm.selectedFrame == frames.classic ||
                                    vm.selectedFrame == frames.permise
                                ? 220
                                : 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Visibility(
                          visible: vm.isDeleteButtonVisible,
                          child: Positioned(
                              left: 30,
                              top: 30,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                child: IconButton(
                                  onPressed: () => vm.removePhoto(index),
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 25,
                                    color: Colors.black,
                                  ),
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
        const SizedBox(height: 20),
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
        height: 80,
        width: 80,
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
          size: 45,
          color: FimtoColors.primaryColor,
        ),
      ),
    );
  }
}

class _CheckoutDialog extends StatelessWidget {
  final BuildContext buildContext;
  const _CheckoutDialog({Key? key, required this.buildContext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = buildContext.read<ChooseFrameViewModel>();
    return SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          height: 250.0,
          width: 350,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
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
              SizedBox(
                width: 120,
                child: GradientButton(
                    text: S.of(context).addAddress,
                    onTap: () => vm.checkoutAction()),
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
                  child: Stack(
                    children: [
                      Image.network(
                        widget.photos.data![index].source,
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150,
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

class _Walls extends StatelessWidget {
  const _Walls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<ChooseFrameViewModel>();
    return Center(
      child: SizedBox(
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
                            index: image.key >= vm.pickedFiles.length
                                ? 0
                                : image.key)
                        // Image.memory(
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
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
