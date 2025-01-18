import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/screens/inbox_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/models/navigation_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/widgets/dashboard_menu_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/screens/home_screens.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/screens/more_screen_view.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:nb_utils/nb_utils.dart';

List<Widget> getBottomWidget(
    {required List<NavigationModel> screens,
    required int pageIndex,
    required void Function(int) setPage}) {
  List<Widget> list = [
    Column(
      children: [80.width],
    )
  ];

  for (int index = 0; index < screens.length; index++) {
    list.add(Expanded(
        child: CustomMenuWidget(
            isSelected: pageIndex == index,
            name: screens[index].name,
            icon: screens[index].icon,
            showCartCount: false,
            onTap: () => {setPage(index)})));
  }
  return list;
}
