import 'package:cached_network_image/cached_network_image.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/instagram_page.dart';
import 'package:fimto_frame/repository/remote/instagram_repository.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/themes/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'instagram_picker_viewmodel.dart';

class InstgramPicker extends StatelessWidget {
  final String code;
  const InstgramPicker({required this.code, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider<InstagramPickerViewModel>(
          create: (_) => InstagramPickerViewModel(
            instagramAcessTokenCode: code,
            instagramRepository: context.read<InstagramRepository>(),
            messageService: context.read<MessageService>(),
          ),
          builder: (context, child) => const _Body(),
        ),
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
    return Stack(
      children: [
        Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              elevation: 4.0,
              title: Text(
                S.of(context).importFromInstagram,
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
              ),
              iconTheme: const IconThemeData(color: Colors.black),
              centerTitle: true,
            ),
            const _ImagesListView(),
            const _ConfirmButton(),
          ],
        ),
        Center(
          child: Visibility(
            visible: context.watch<InstagramPickerViewModel>().isLoading,
            child: const CircularProgressIndicator(),
          ),
        )
      ],
    );
  }
}

class _ImagesListView extends StatelessWidget {
  const _ImagesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var medias = context.watch<InstagramPickerViewModel>().medias;

    return Expanded(
      child: GridView.builder(
          itemCount: medias.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (BuildContext _, index) {
            final media = medias[index];
            return _ImageListItem(media: media);
          }),
    );
  }
}

class _ZoomImage extends StatelessWidget {
  final String imageUrl;

  const _ZoomImage({required this.imageUrl});

  Future<void> _showImage(BuildContext context, ImageProvider provider) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image(
                  image: provider,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider provider = CachedNetworkImageProvider(imageUrl);

    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      elevation: 8.0,
      child: InkWell(
        child: Image(
          image: provider,
          fit: BoxFit.cover,
        ),
        onTap: () {
          _showImage(context, provider);
        },
      ),
    );
  }
}

class _ImageListItem extends StatelessWidget {
  final Media media;

  const _ImageListItem({
    Key? key,
    required this.media,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isSelected = context
        .watch<InstagramPickerViewModel>()
        .selectedMedias
        .any((element) => element == media);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          _ZoomImage(imageUrl: media.mediaUrl),
          Positioned(
            bottom: 0,
            right: 0,
            child: Checkbox(
              value: isSelected,
              onChanged: (value) => context
                  .read<InstagramPickerViewModel>()
                  .onMediaSelectedAction(media),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      text: S.of(context).continueBTN,
      onTap: () =>
          context.read<InstagramPickerViewModel>().onConfirmSelectionAction(),
    );
  }
}
