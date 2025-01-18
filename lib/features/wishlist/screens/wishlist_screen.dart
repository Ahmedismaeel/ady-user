import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/controllers/wishlist_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/domain/models/wishlist_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/widgets/wishlist_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/widgets/wishlist_widget.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/not_loggedin_widget.dart';
// import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});
  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
    if (Provider.of<AuthController>(context, listen: false).isLoggedIn()) {
      Provider.of<WishListController>(context, listen: false).getWishList();
    }
  }

  int page = 1;
  setPage(int id) {
    page = id;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('wishList', context)),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          12.height,
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: CustomSlidingSegmentedControl<int>(
                // key: UniqueKey(),
                padding: 7,
                fromMax: true,
                children: {
                  1: Text(
                    categoryById(1),
                    textAlign: TextAlign.center,
                    style: textStyle(15).copyWith(
                        color: page == 1 ? UiColors.white : UiColors.medGrey),
                  ),
                  2: Text(
                    categoryById(2),
                    textAlign: TextAlign.center,
                    style: textStyle(15).copyWith(
                        color: page == 2 ? UiColors.white : UiColors.medGrey),
                  ),
                  3: Text(
                    categoryById(3),
                    textAlign: TextAlign.center,
                    style: textStyle(15).copyWith(
                        color: page == 3 ? UiColors.white : UiColors.medGrey),
                  ),
                  4: Text(
                    categoryById(4),
                    textAlign: TextAlign.center,
                    style: textStyle(15).copyWith(
                        color: page == 4 ? UiColors.white : UiColors.medGrey),
                  ),
                },
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                thumbDecoration: BoxDecoration(
                  color: UiColors.darkBlue,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    // BoxShadow(
                    //   color: Colors.black.withOpacity(.3),
                    //   blurRadius: 4.0,
                    //   spreadRadius: 1.0,
                    //   offset: const Offset(
                    //     0.0,
                    //     2.0,
                    //   ),
                    // ),
                  ],
                ),
                onValueChanged: (int value) {
                  print(value);
                  setPage(value);
                },
              ),
            ),
          ),
          Expanded(
            child: !Provider.of<AuthController>(context, listen: false)
                    .isLoggedIn()
                ? const NotLoggedInWidget()
                : Consumer<WishListController>(
                    builder: (context, wishListProvider, child) {
                    List<WishlistModel>? list = [];
                    try {
                      list = wishListProvider.wishList
                          ?.where((item) =>
                              item.productFullInfo?.categoryId == page)
                          .toList();
                    } catch (e) {}
                    return list != null
                        ? list!.isNotEmpty
                            ? RefreshIndicator(
                                onRefresh: () async =>
                                    await wishListProvider.getWishList(),
                                child: ListView.builder(
                                    padding: const EdgeInsets.all(0),
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      return WishListWidget(
                                          wishlistModel: list![index],
                                          index: index);
                                    }))
                            : const NoInternetOrDataScreenWidget(
                                isNoInternet: false,
                                message: 'no_wishlist_product',
                                icon: Images.noWishlist,
                              )
                        : const WishListShimmer();
                  }),
          ),
          // TODO: Handle this case.
        ],
      ),
    );
  }
}
