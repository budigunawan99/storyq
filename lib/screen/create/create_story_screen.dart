import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:storyq/common.dart';
import 'package:storyq/provider/create/create_story_provider.dart';
import 'package:storyq/provider/home/story_list_provider.dart';
import 'package:storyq/screen/common/appbar.dart';
import 'package:storyq/static/create_story_result_state.dart';

class CreateStoryScreen extends StatefulWidget {
  final Function onPosted;
  final Function() onPop;

  const CreateStoryScreen({
    super.key,
    required this.onPosted,
    required this.onPop,
  });

  @override
  State<CreateStoryScreen> createState() => _CreateStoryScreenState();
}

class _CreateStoryScreenState extends State<CreateStoryScreen> {
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<CreateStoryProvider>();
    Future.microtask(() {
      provider.getMyLocation();
      addressController.text =
          provider.myAddress ?? "Lokasi Anda tidak terdeteksi";
    });
  }

  @override
  void dispose() {
    descriptionController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        isHomePage: false,
        title: AppLocalizations.of(context)!.createStoryMenu,
        onPop: widget.onPop,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 0.75 * MediaQuery.of(context).size.width,
                    minHeight: 0.25 * MediaQuery.of(context).size.width,
                    maxWidth: MediaQuery.of(context).size.width,
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 0.75 * MediaQuery.of(context).size.width,
                            minHeight: 0.25 * MediaQuery.of(context).size.width,
                            maxWidth: MediaQuery.of(context).size.width,
                            minWidth: MediaQuery.of(context).size.width,
                          ),
                          child:
                              context.watch<CreateStoryProvider>().imagePath ==
                                      null
                                  ? Image.asset(
                                    'assets/images/img_default.png',
                                    fit: BoxFit.cover,
                                  )
                                  : _showImage(),
                        ),
                      ),

                      if (!isNotMobile())
                        Positioned(
                          left: 15,
                          bottom: 15,
                          child: IconButton(
                            tooltip:
                                AppLocalizations.of(context)!.cameraTooltip,
                            onPressed: () => _onCameraView(),
                            style: IconButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.onSurface,
                            ),
                            icon: Icon(
                              Icons.add_a_photo_outlined,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                        ),

                      Positioned(
                        right: 15,
                        bottom: 15,
                        child: IconButton(
                          tooltip: AppLocalizations.of(context)!.galleryTooltip,
                          onPressed: () => _onGalleryView(),
                          style: IconButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.onSurface,
                          ),
                          icon: Icon(
                            Icons.browse_gallery_outlined,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Consumer<CreateStoryProvider>(
                  builder: (context, value, child) {
                    if (value.myAddress != null) {
                      addressController.text = value.myAddress!;
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      child: TextField(
                        controller: addressController,
                        enabled: false,
                        maxLines: null,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    );
                  },
                ),

                SizedBox(
                  height: 0.3 * MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 15,
                    ),
                    child: TextField(
                      controller: descriptionController,
                      maxLines: 6,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: AppLocalizations.of(context)!.descriptionHint,
                        hintStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15),
                  child:
                      context.watch<CreateStoryProvider>().resultState
                              is CreateStoryLoadingState
                          ? Shimmer.fromColors(
                            baseColor: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.5),
                            highlightColor: Colors.grey.withValues(alpha: 0.5),
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          )
                          : ElevatedButton(
                            onPressed: () => _onUpload(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.onSurface,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.save_alt_outlined,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                SizedBox.square(dimension: 8),
                                Text(
                                  AppLocalizations.of(context)!.saveButton,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleSmall?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _onGalleryView() async {
    final provider = context.read<CreateStoryProvider>();

    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;

    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  bool isNotMobile() {
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    return !(isAndroid || isiOS);
  }

  Future _onCameraView() async {
    final provider = context.read<CreateStoryProvider>();

    if (isNotMobile()) return;

    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  Widget _showImage() {
    final imagePath = context.read<CreateStoryProvider>().imagePath;
    return kIsWeb
        ? Image.network(imagePath.toString(), fit: BoxFit.cover)
        : Image.file(File(imagePath.toString()), fit: BoxFit.cover);
  }

  _onUpload() async {
    final ScaffoldMessengerState scaffoldMessengerState = ScaffoldMessenger.of(
      context,
    );
    final provider = context.read<CreateStoryProvider>();
    final storyProvider = context.read<StoryListProvider>();
    final imagePath = provider.imagePath;
    final imageFile = provider.imageFile;
    if (imagePath == null || imageFile == null) {
      scaffoldMessengerState.showSnackBar(
        SnackBar(content: Text("Tidak ada data yang diupload")),
      );
      return;
    } else if (descriptionController.text.isEmpty) {
      scaffoldMessengerState.showSnackBar(
        SnackBar(content: Text("Masukkan deskripsi terlebih dahulu!")),
      );
      return;
    }

    final filename = imageFile.name;
    final bytes = await imageFile.readAsBytes();
    final newBytes = await provider.compressImage(bytes);

    await provider.uploadStory(
      newBytes,
      filename,
      descriptionController.text,
      provider.myLatLng,
    );

    switch (provider.resultState) {
      case CreateStoryErrorState(error: var message):
        scaffoldMessengerState.showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
      case CreateStoryLoadedState():
        provider.setImageFile(null);
        provider.setImagePath(null);
        descriptionController.clear();
        storyProvider.fetchStoryList();
        widget.onPosted();
        scaffoldMessengerState.showSnackBar(
          SnackBar(content: Text("Data berhasil diupload!")),
        );
      default:
    }
  }
}
