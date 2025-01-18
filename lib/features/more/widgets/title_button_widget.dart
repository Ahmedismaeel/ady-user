import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/controllers/notification_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class MenuButtonWidget extends StatelessWidget {
  final String image;
  final String? title;
  final Widget navigateTo;
  final bool isNotification;
  final bool isProfile;
  const MenuButtonWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.navigateTo,
      this.isNotification = false,
      this.isProfile = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => navigateTo));
      },
      child: Container(
          margin: const EdgeInsets.only(bottom: 16, left: 12, right: 12),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: boxDecorationDefault(
              color: UiColors.bgBlue,
              boxShadow: [],
              borderRadius: BorderRadius.circular(90),
              border: Border.all(color: UiColors.borderBlue)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    image,
                    width: 32,
                    height: 32,
                    fit: BoxFit.contain,
                    color: UiColors.darkBlue,
                  ),
                  9.width,
                  Text(title!,
                      style: textStyle(20).copyWith(color: UiColors.darkBlue))
                ],
              ),
              isNotification
                  ? Consumer<NotificationController>(
                      builder: (context, notificationController, _) {
                      return CircleAvatar(
                        radius: 12,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                            notificationController
                                    .notificationModel?.newNotificationItem
                                    .toString() ??
                                '0',
                            style: textRegular.copyWith(
                                color: ColorResources.white,
                                fontSize: Dimensions.fontSizeSmall)),
                      );
                    })
                  : SizedBox.shrink()
            ],
          )

          //  ListTile(
          //     trailing: isNotification
          //         ? Consumer<NotificationController>(
          //             builder: (context, notificationController, _) {
          //             return CircleAvatar(
          //               radius: 12,
          //               backgroundColor: Theme.of(context).primaryColor,
          //               child: Text(
          //                   notificationController
          //                           .notificationModel?.newNotificationItem
          //                           .toString() ??
          //                       '0',
          //                   style: textRegular.copyWith(
          //                       color: ColorResources.white,
          //                       fontSize: Dimensions.fontSizeSmall)),
          //             );
          //           })
          //         : isProfile
          //             ? Consumer<ProfileController>(
          //                 builder: (context, profileProvider, _) {
          //                 return CircleAvatar(
          //                     radius: 12,
          //                     backgroundColor: Theme.of(context).primaryColor,
          //                     child: Text(
          //                         profileProvider.userInfoModel?.referCount
          //                                 .toString() ??
          //                             '0',
          //                         style: textRegular.copyWith(
          //                             color: ColorResources.white,
          //                             fontSize: Dimensions.fontSizeSmall)));
          //               })
          //             : const SizedBox(),
          //     leading: Image.asset(
          //       image,
          //       width: 32,
          //       height: 32,
          //       fit: BoxFit.fill,
          //       color: UiColors.darkBlue,
          //     ),
          //     title: Text(title!,
          //         style: textStyle(20).copyWith(color: UiColors.darkBlue)),
          //     onTap: () => Navigator.push(
          //         context, MaterialPageRoute(builder: (_) => navigateTo))),
          ),
    );
  }
}
