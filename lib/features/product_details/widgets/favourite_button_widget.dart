import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/controllers/wishlist_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/not_logged_in_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:provider/provider.dart';

class FavouriteButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final int? productId;
  const FavouriteButtonWidget(
      {super.key, this.backgroundColor = Colors.black, this.productId});
  @override
  Widget build(BuildContext context) {
    bool isGuestMode =
        !Provider.of<AuthController>(context, listen: false).isLoggedIn();

    return Consumer<WishListController>(builder: (context, wishProvider, _) {
      return GestureDetector(
          onTap: () {
            if (isGuestMode) {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => const NotLoggedInBottomSheetWidget());
            } else {
              wishProvider.addedIntoWish.contains(productId)
                  ? wishProvider.removeWishList(
                      productId,
                    )
                  : wishProvider.addWishList(productId);
            }
          },
          child: Padding(
              padding: const EdgeInsets.all(6),
              child: Container(
                transform: Matrix4.translationValues(0, 1, 0),
                child: Icon(
                    wishProvider.addedIntoWish.contains(productId)
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                    color: wishProvider.addedIntoWish.contains(productId)
                        ? const Color(0xFFFF5050)
                        : Theme.of(context).primaryColor,
                    size: 20),
              )));
    });
  }
}

class FavouriteDetailsWidget extends StatelessWidget {
  final Color backgroundColor;
  final int? productId;
  const FavouriteDetailsWidget(
      {super.key, this.backgroundColor = Colors.black, this.productId});
  @override
  Widget build(BuildContext context) {
    bool isGuestMode =
        !Provider.of<AuthController>(context, listen: false).isLoggedIn();

    return Consumer<WishListController>(builder: (context, wishProvider, _) {
      return GestureDetector(
          onTap: () {
            if (isGuestMode) {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => const NotLoggedInBottomSheetWidget());
            } else {
              wishProvider.addedIntoWish.contains(productId)
                  ? wishProvider.removeWishList(
                      productId,
                    )
                  : wishProvider.addWishList(productId);
            }
          },
          child: Padding(
              padding: const EdgeInsets.all(6),
              child: Container(
                transform: Matrix4.translationValues(0, 1, 0),
                child: Icon(
                    wishProvider.addedIntoWish.contains(productId)
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                    color: wishProvider.addedIntoWish.contains(productId)
                        ? const Color(0xFFFF5050)
                        : Theme.of(context).primaryColor,
                    size: 30),
              )));
    });
  }
}
