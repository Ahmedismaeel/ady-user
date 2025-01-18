import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/create_ad_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/row_button.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';

class ChooseLocationMap extends StatefulWidget {
  const ChooseLocationMap({
    super.key,
  });
  @override
  State createState() => ChooseLocationMapState();
}

class ChooseLocationMapState extends State<ChooseLocationMap> {
  GoogleMapController? mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    afterBuildCreated(() async {
      SmartDialog.showLoading();
      LocationPermission permission = await Geolocator.requestPermission();
      Position data = await Geolocator.getCurrentPosition();
      position = LatLng(data.latitude, data.longitude);
      mapController?.animateCamera(
        CameraUpdate.newLatLng(LatLng(data.latitude, data.longitude)),
      );
      SmartDialog.dismiss();
    });

    super.initState();
  }

  LatLng? position;
  changePosition(CameraPosition pos) {
    position = LatLng(pos.target.latitude, pos.target.longitude);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Location".translate(context)),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              indoorViewEnabled: true,
              trafficEnabled: true,
              myLocationEnabled: true,
              onMapCreated: _onMapCreated,
              onCameraMove: (position) {
                changePosition(position);
              },
              onCameraIdle: () {},
              initialCameraPosition: const CameraPosition(
                  zoom: 15,
                  target: LatLng(23.602036542892446, 58.35978231654114)),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Spacer(),
                Consumer(builder: (context, ref, child) {
                  return RowButton(
                    text: "Select This Location".translate(context),
                    onTap: () {
                      ref.read(locationAdProvider.notifier).save(
                          latitude: position!.latitude,
                          longitude: position!.longitude);
                      Navigator.pop(context);
                    },
                  );
                }),
                16.height,
              ],
            ),
          ),
          Center(
            child: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: 35,
            ),
          )
        ],
      ),
    );
  }
}
