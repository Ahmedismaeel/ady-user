import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final bool showActionButton;
  final Function()? onBackPressed;
  final bool centerTitle;
  final double? fontSize;
  final bool showResetIcon;
  final Widget? reset;
  final bool showLogo;
  final Color? backGroundColor;
  final Color? textColor;

  const CustomAppBar(
      {super.key,
      required this.title,
      this.isBackButtonExist = true,
      this.onBackPressed,
      this.centerTitle = false,
      this.showActionButton = true,
      this.fontSize,
      this.showResetIcon = false,
      this.reset,
      this.showLogo = false,
      this.backGroundColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
            actions: showResetIcon ? [reset!] : [],
            backgroundColor: backGroundColor ?? Theme.of(context).cardColor,
            toolbarHeight: 50,
            iconTheme: IconThemeData(
                color:
                    textColor ?? Theme.of(context).textTheme.bodyLarge?.color),
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: isBackButtonExist
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                Text(title ?? '',
                    style: textStyle(18).copyWith(
                        color: textColor ?? UiColors.darkBlue,
                        fontWeight: FontWeight.w500),
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
            centerTitle: true,
            excludeHeaderSemantics: true,
            titleSpacing: 0,
            elevation: 1,
            clipBehavior: Clip.none,
            shadowColor: Theme.of(context).primaryColor.withOpacity(.1),
            leadingWidth: isBackButtonExist ? 50 : 0,
            leading: isBackButtonExist
                ? IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 22,
                      color: textColor ?? UiColors.darkBlue,
                    ),
                    onPressed: () => onBackPressed != null
                        ? onBackPressed!()
                        : Navigator.pop(context))
                : showLogo
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: Dimensions.paddingSizeDefault),
                        child: SizedBox(
                            child: Image.asset(Images.logoWithNameImage)))
                    : const SizedBox()));
  }

  @override
  Size get preferredSize => Size(MediaQuery.of(Get.context!).size.width, 50);
}
