import 'package:cached_network_image/cached_network_image.dart';
import 'package:fimto_frame/models/instagram_page.dart';
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
        builder: (context, child) => const _Body(),
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
    return const _ImagesListView();
  }
}

class _ImagesListView extends StatelessWidget {
  const _ImagesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 5, //widget.medias.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext _, index) {
          //final Media media = widget.medias[index];
          return _ImageListItem(
            media: Media(caption: '',id: '',mediaType: '',mediaUrl: '',timestamp: '',username: '',),
            onChanged: (v)=>{},
          );
        });
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
  final Function onChanged;

  const _ImageListItem({
    Key? key,
    required this.media,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          _ZoomImage(imageUrl: media.mediaUrl),
          Positioned(
              bottom: 0,
              right: 0,
              child: Checkbox(
                value: false, //media.selected,
                onChanged: (value) => {},
              )),
        ],
      ),
    );
  }
}
