import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';

class MapView extends ConsumerStatefulWidget {
  const MapView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<MapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Map View"),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      ),
    );
  }
}
