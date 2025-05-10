import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:storyq/common.dart';
import 'package:storyq/provider/detail/story_detail_provider.dart';
import 'package:storyq/screen/common/appbar.dart';
import 'package:storyq/screen/common/skeleton_loading.dart';
import 'package:storyq/static/story_detail_result_state.dart';

class DetailScreen extends StatefulWidget {
  final String storyId;
  final Function() onPop;

  const DetailScreen({super.key, required this.storyId, required this.onPop});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<StoryDetailProvider>().fetchStoryDetail(widget.storyId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(isHomePage: false, title: "Stories", onPop: widget.onPop),
      body: CustomScrollView(
        slivers: [
          Consumer<StoryDetailProvider>(
            builder: (context, value, child) {
              return switch (value.resultState) {
                StoryDetailLoadingState() => SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: SkeletonLoading(count: 1),
                  ),
                ),
                StoryDetailLoadedState(data: var story) => SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 40,
                                minHeight: 40,
                                maxWidth: 40,
                                minWidth: 40,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  "assets/images/user.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox.square(dimension: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    story.name,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox.square(dimension: 5),
                                  Text(
                                    DateFormat(
                                      'dd-MM-yyyy',
                                    ).format(DateTime.parse(story.createdAt)),
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 0.75 * MediaQuery.of(context).size.width,
                          minHeight: 0.25 * MediaQuery.of(context).size.width,
                          maxWidth: MediaQuery.of(context).size.width,
                          minWidth: MediaQuery.of(context).size.width,
                        ),
                        child: Hero(
                          tag: story.id,
                          child: Image.network(
                            story.photoUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/img_default.png',
                                fit: BoxFit.fitWidth,
                              );
                            },
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "${story.name} - ${story.description}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          AppLocalizations.of(context)!.locationSub,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),

                      story.lat != null &&
                              story.lon != null &&
                              (defaultTargetPlatform ==
                                      TargetPlatform.android ||
                                  defaultTargetPlatform == TargetPlatform.iOS ||
                                  kIsWeb)
                          ? Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  bottom: 15,
                                ),
                                child: Text(
                                  value.address ?? '',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    bottom: 15,
                                  ),
                                  child: Stack(
                                    children: [
                                      GoogleMap(
                                        markers: value.markers,
                                        initialCameraPosition: CameraPosition(
                                          zoom: 18,
                                          target: LatLng(
                                            story.lat!,
                                            story.lon!,
                                          ),
                                        ),
                                        onMapCreated: (controller) {
                                          value.setMapController(controller);
                                        },
                                        myLocationButtonEnabled: false,
                                        zoomControlsEnabled: false,
                                        mapToolbarEnabled: false,
                                      ),

                                      Positioned(
                                        bottom: 16,
                                        right: 16,
                                        child: Column(
                                          children: [
                                            FloatingActionButton.small(
                                              heroTag: "zoom-in",
                                              onPressed: () {
                                                if (value.mapController !=
                                                    null) {
                                                  value.mapController!
                                                      .animateCamera(
                                                        CameraUpdate.zoomIn(),
                                                      );
                                                }
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).colorScheme.surface,
                                              ),
                                            ),
                                            FloatingActionButton.small(
                                              heroTag: "zoom-out",
                                              onPressed: () {
                                                if (value.mapController !=
                                                    null) {
                                                  value.mapController!
                                                      .animateCamera(
                                                        CameraUpdate.zoomOut(),
                                                      );
                                                }
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).colorScheme.surface,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                          : Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              bottom: 15,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.not_listed_location_outlined,
                                      size: 40,
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                    ),
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.unsupportedLocationMsg,
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
                StoryDetailErrorState(error: var message) => SliverToBoxAdapter(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/nodata.png', height: 250),
                          const SizedBox.square(dimension: 8),
                          Text(
                            message,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _ => SliverToBoxAdapter(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/empty.png', height: 250),
                          const SizedBox.square(dimension: 8),
                          Text(
                            AppLocalizations.of(context)!.emptyStoryText,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              };
            },
          ),
        ],
      ),
    );
  }
}
