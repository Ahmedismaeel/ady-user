import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/widgets/sign_in_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/widgets/sign_up_widget.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final bool fromLogout;
  const RegisterScreen({super.key, this.fromLogout = false});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    Provider.of<AuthController>(context, listen: false)
        .updateSelectedIndex(0, notify: false);
    super.initState();
  }

  bool scrolled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthController>(builder: (context, authProvider, _) {
        return Column(
          children: [
            Stack(children: [
              Container(
                  height: 230,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor)),
              Image.asset(Images.loginBg,
                  fit: BoxFit.cover,
                  height: 200,
                  opacity: const AlwaysStoppedAnimation(.15)),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .1),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Images.fiLogoWhite, width: 81, height: 81)
                      ])),
              Positioned(
                  top: Dimensions.paddingSizeThirtyFive,
                  left: Provider.of<LocalizationController>(context,
                              listen: false)
                          .isLtr
                      ? Dimensions.paddingSizeLarge
                      : null,
                  right: Provider.of<LocalizationController>(context,
                              listen: false)
                          .isLtr
                      ? null
                      : Dimensions.paddingSizeLarge,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios,
                        size: 30, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )),
            ]),
            AnimatedContainer(
              transform: Matrix4.translationValues(0, -20, 0),
              curve: Curves.fastOutSlowIn,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(Dimensions.radiusExtraLarge))),
              duration: const Duration(seconds: 2),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(getTranslated('sign_up', context),
                              style: textStyle(22).copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: UiColors.darkBlue)),
                        ],
                      ),
                    )
                    // Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Expanded(
                    //         child: InkWell(
                    //             onTap: () =>
                    //                 authProvider.updateSelectedIndex(0),
                    //             child: Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.center,
                    //                 children: [
                    //                   Text(
                    //                       getTranslated('login', context),
                    //                       style: authProvider
                    //                                   .selectedIndex ==
                    //                               0
                    //                           ? textRegular.copyWith(
                    //                               color: Theme.of(context)
                    //                                   .primaryColor,
                    //                               fontSize: Dimensions
                    //                                   .fontSizeLarge)
                    //                           : textRegular.copyWith(
                    //                               fontSize: Dimensions
                    //                                   .fontSizeLarge)),
                    //                   Container(
                    //                     height: 3,
                    //                     margin:
                    //                         const EdgeInsets.only(top: 8),
                    //                     decoration: BoxDecoration(
                    //                         borderRadius: BorderRadius
                    //                             .circular(
                    //                                 Dimensions
                    //                                     .paddingSizeSmall),
                    //                         color: authProvider
                    //                                     .selectedIndex ==
                    //                                 0
                    //                             ? Theme.of(context)
                    //                                 .primaryColor
                    //                             : UiColors.lightGrey),
                    //                     child: const Row(
                    //                       mainAxisSize: MainAxisSize.max,
                    //                       children: [Spacer()],
                    //                     ),
                    //                   )
                    //                 ])),
                    //       ),
                    //       // const SizedBox(width: 20),
                    //       Expanded(
                    //         child: InkWell(
                    //             onTap: () =>
                    //                 authProvider.updateSelectedIndex(1),
                    //             child: Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.center,
                    //                 children: [
                    //                   Text(
                    //                       getTranslated(
                    //                           'sign_up', context),
                    //                       style: authProvider
                    //                                   .selectedIndex ==
                    //                               1
                    //                           ? titleRegular.copyWith(
                    //                               color: Theme.of(context)
                    //                                   .primaryColor,
                    //                               fontSize: Dimensions
                    //                                   .fontSizeLarge)
                    //                           : titleRegular.copyWith(
                    //                               fontSize: Dimensions
                    //                                   .fontSizeLarge)),
                    //                   Container(
                    //                     height: 3,
                    //                     // width: 150,
                    //                     margin:
                    //                         const EdgeInsets.only(top: 8),
                    //                     decoration: BoxDecoration(
                    //                         borderRadius: BorderRadius
                    //                             .circular(
                    //                                 Dimensions
                    //                                     .paddingSizeSmall),
                    //                         color: authProvider
                    //                                     .selectedIndex ==
                    //                                 1
                    //                             ? Theme.of(context)
                    //                                 .primaryColor
                    //                             : UiColors.lightGrey),
                    //                     child: const Row(
                    //                       mainAxisSize: MainAxisSize.max,
                    //                       children: [Spacer()],
                    //                     ),
                    //                   )
                    //                 ])),
                    //       ),
                    //     ])),
                  ],
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: const SignUpWidget(),
            )),
          ],
        );
      }),
    );
  }
}
