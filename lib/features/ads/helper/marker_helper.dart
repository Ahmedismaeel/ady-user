import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerNotifier extends StateNotifier<Set<Marker>> {
  MarkerNotifier() : super({});
  setProducts(List<Product> list) {
    ">>>>>>>>>>> setProducts ${list}".log();
    state = List.generate(list.length, (index) {
      return Marker(
          // onTap: () {},
          // icon: BitmapDescriptor.defaultMarkerWithHue(
          //     BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(
            onTap: () {},
            title: "${list[index].name}",
            snippet: "${list[index].details}",
          ),
          onTap: () {},
          markerId: MarkerId("$index"),
          position: LatLng((list[index].latitude ?? 0.00) + index,
              (list[index].longitude ?? 00) + index),
          icon: BitmapDescriptor.defaultMarker);
    }).toSet();
  }
}

final markerProvider = StateNotifierProvider<MarkerNotifier, Set<Marker>>(
    (ref) => MarkerNotifier());
