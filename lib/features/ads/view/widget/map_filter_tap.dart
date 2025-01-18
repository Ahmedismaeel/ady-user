import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/helper/filter_data_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/filter_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/filter_reponse.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/shop_response_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/add_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/screens/shop_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/create_ad_controller.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utill/images.dart';

class MapFilterTapView extends ConsumerStatefulWidget {
  final String? name;
  const MapFilterTapView({super.key, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MapFilterTapViewState();
}

class _MapFilterTapViewState extends ConsumerState<MapFilterTapView> {
  GoogleMapController? mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Position? data;
  AssetMapBitmap? logo;
  AssetMapBitmap? shopLogo;
  @override
  void initState() {
    afterBuildCreated(() async {
      // position = LatLng(ref.watch(locationAdProvider)?.latitude ?? 0.00,
      //     ref.watch(locationAdProvider)?.longitude ?? 0.00);
      mapController?.animateCamera(
        CameraUpdate.newLatLng(LatLng(
            ref.watch(locationAdProvider)?.latitude ?? 0.00,
            ref.watch(locationAdProvider)?.longitude ?? 0.00)),
      );
      setState(() {});
      SmartDialog.dismiss();
      logo = await BitmapDescriptor.asset(
          ImageConfiguration(size: Size(48, 48)), Images.fiad);
      shopLogo = await BitmapDescriptor.asset(
          ImageConfiguration(size: Size(48, 48)), Images.fiShop);
    });

    super.initState();
  }

  LatLng? position = LatLng(homeRef.watch(locationAdProvider)?.latitude ?? 0.00,
      homeRef.watch(locationAdProvider)?.longitude ?? 0.00);
  changePosition(CameraPosition pos) {
    position = LatLng(pos.target.latitude, pos.target.longitude);
    setState(() {});
  }

  List<Product> productList = [];
  List<Shops> shopList = [];
  getMarkers() async {
    try {
      if (ref.watch(filterDataProvider).categoryId == null) {
        final list = await AppConstants.shopByLocation
            .get(fromJson: ShopResponse.fromJson, data: {
          "name": widget.name,
          "offset": 1,
          "limit": 100,
          "radius": 60,
          "latitude": position!.latitude,
          "longitude": position!.longitude,
        });
        // "${list.toJson()}".log();
        shopList = list.shops ?? [];
      } else {
        "ads".log();
        final list = await AppConstants.searchAd.get(
            fromJson: FilterResponse.fromJson,
            data: FilterRequest(
                    name: widget.name,
                    latitude: position!.latitude,
                    categoryId: ref.watch(filterDataProvider).categoryId?.id,
                    longitude: position!.longitude,
                    location: true,
                    offset: 0,
                    limit: 30,
                    productType: ['ad'],
                    radius: 40)
                .toJson());
        " >>>>>>>>>>>>>>>>>>>>>>>>> ${list.totalSize}".log();
        productList = list.products;
      }
    } catch (e) {
      productList = [];
      shopList = [];
      e.toString().log();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration:
                    boxDecorationDefault(color: UiColors.white, boxShadow: []),
                padding: const EdgeInsets.all(8.0),
                child: Consumer(builder: (context, ref, w) {
                  return ProviderHelperWidget(
                      function: (categoryList) {
                        final selectedCategory =
                            ref.watch(filterDataProvider).categoryId;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                decoration: boxDecorationDefault(
                                    color: selectedCategory == null
                                        ? UiColors.darkBlue
                                        : UiColors.extraLightGrey,
                                    // boxShadow: [],
                                    borderRadius: BorderRadius.circular(90)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 11),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Text("Shops".translate(context),
                                    style: textStyle(14).copyWith(
                                        color: selectedCategory == null
                                            ? UiColors.white
                                            : UiColors.medGrey)),
                              ).onTap(() async {
                                ref
                                    .read(filterDataProvider.notifier)
                                    .updateCategory(null);
                                await getMarkers();
                                setState(() {});
                              }),
                              for (var element in categoryList)
                                Container(
                                  decoration: boxDecorationDefault(
                                      color: selectedCategory?.id == element.id
                                          ? UiColors.darkBlue
                                          : UiColors.extraLightGrey,
                                      // boxShadow: [],
                                      borderRadius: BorderRadius.circular(90)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 11),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  child: Text("${element.name}",
                                      style: textStyle(14).copyWith(
                                          color:
                                              selectedCategory?.id == element.id
                                                  ? UiColors.white
                                                  : UiColors.medGrey)),
                                ).onTap(() async {
                                  ref
                                      .read(filterDataProvider.notifier)
                                      .updateCategory(element);
                                  await getMarkers();
                                  setState(() {});
                                })
                            ],
                          ),
                        );
                      },
                      listener: ref.watch(categoryListProvider));
                }),
              ),
              Expanded(
                child: SizedBox(
                  // height: MediaQuery.of(context).size.height * 0.90,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    indoorViewEnabled: true,
                    trafficEnabled: true,
                    myLocationEnabled: true,
                    onMapCreated: _onMapCreated,
                    markers: ref.watch(filterDataProvider).categoryId == null
                        ? List.generate(shopList.length ?? 0, (index) {
                            "${shopList[index].id} ${shopList[index].latitude} ${shopList[index].longitude}"
                                .log();
                            return Marker(
                                // onTap: () {},
                                // icon: BitmapDescriptor.defaultMarkerWithHue(
                                //     BitmapDescriptor.hueGreen),
                                infoWindow: InfoWindow(
                                  onTap: () {},
                                  title: "${shopList[index].name}",
                                  snippet: "${shopList[index].name}",
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              TopSellerProductScreen(
                                                sellerId:
                                                    shopList[index].sellerId,
                                                // temporaryClose: shopList[index]
                                                //         .temporaryClose ??
                                                //     false,
                                                // vacationStatus: shopList[index]
                                                //         .vacationStatus ??
                                                //     false,
                                                // vacationEndDate: shopList[index]
                                                //     .vacationEndDate,
                                                // vacationStartDate: shopList[index]
                                                //     .vacationStartDate,
                                                // name: shopList[index].name,
                                                // banner: shopList[index]
                                                //     .bannerFullUrl
                                                //     ?.path,
                                                // image: shopList[index].image
                                              )));
                                },
                                markerId: MarkerId("$index"),
                                position: LatLng(
                                    (shopList[index].latitude ?? 00),
                                    (shopList[index].longitude ?? 00)),
                                icon:
                                    shopLogo ?? BitmapDescriptor.defaultMarker);
                          }).toSet()
                        : List.generate(productList.length, (index) {
                            "${productList[index].id} ${productList[index].latitude} ${productList[index].longitude}"
                                .log();
                            return Marker(
                                // onTap: () {},
                                // icon: BitmapDescriptor.defaultMarkerWithHue(
                                //     BitmapDescriptor.hueGreen),
                                infoWindow: InfoWindow(
                                  onTap: () {},
                                  title: "${productList[index].name}",
                                  snippet: "${productList[index].details}",
                                ),
                                onTap: () {
                                  AdDetails(
                                          productId: productList[index].id,
                                          slug: productList[index].slug)
                                      .launch(context);
                                },
                                markerId: MarkerId("$index"),
                                position: LatLng(
                                    (productList[index].latitude ?? 00),
                                    (productList[index].longitude ?? 00)),
                                icon: logo ?? BitmapDescriptor.defaultMarker);
                          }).toSet(),
                    onCameraMove: (pos) {
                      position =
                          LatLng(pos.target.latitude, pos.target.longitude);
                      "onCameraMove ${position}".log();
                    },
                    onCameraIdle: () async {
                      " onCameraIdle ${position}".log();
                      await getMarkers();
                      setState(() {});
                    },
                    initialCameraPosition: const CameraPosition(
                        zoom: 12,
                        target: LatLng(23.602036542892446, 58.35978231654114)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
