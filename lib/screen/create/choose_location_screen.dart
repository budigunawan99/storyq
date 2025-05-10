import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:storyq/common.dart';
import 'package:storyq/provider/create/create_story_provider.dart';
import 'package:storyq/screen/common/appbar.dart';

class ChooseLocationScreen extends StatefulWidget {
  final Function() onSubmit;
  final Function() onPop;

  const ChooseLocationScreen({
    super.key,
    required this.onSubmit,
    required this.onPop,
  });

  @override
  State<ChooseLocationScreen> createState() => _ChooseLocationScreenState();
}

class _ChooseLocationScreenState extends State<ChooseLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        isHomePage: false,
        title: AppLocalizations.of(context)!.chooseLocationMenu,
        onPop: widget.onPop,
      ),
      body: Consumer<CreateStoryProvider>(
        builder: (context, value, child) {
          return Stack(
            children: [
              GoogleMap(
                markers: value.markers,
                initialCameraPosition: CameraPosition(
                  zoom: 18,
                  target: value.myLatLng!,
                ),
                onMapCreated: (controller) {
                  final marker = Marker(
                    markerId: const MarkerId("choose-location"),
                    position: value.myLatLng!,
                  );
                  value.setMapController(controller);
                  value.setMarkers(marker);
                },
                onTap: (LatLng latLng) {
                  final marker = Marker(
                    markerId: const MarkerId("choose-location"),
                    position: latLng,
                  );
                  value.setMarkers(marker);
                  value.setTempAddressAndLatLng(latLng);
                  if (value.mapController != null) {
                    value.mapController!.animateCamera(
                      CameraUpdate.newLatLng(latLng),
                    );
                  }
                },
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
              ),
              Positioned(
                bottom: -10,
                left: -4,
                right: -4,
                height: 140,
                child: Card(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            value.tempAddress ?? value.myAddress ?? "",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        SizedBox.square(dimension: 6),
                        SizedBox(
                          width: 0.5 * MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              value.setMyLocation();
                              widget.onSubmit();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.onSurface,
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.nextMenu,
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall?.copyWith(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
