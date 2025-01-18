import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/domain/models/login_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/screens/forget_password_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/screens/register_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/features/setting/screens/settings_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/setting/widgets/select_language_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/helper/velidate_check.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/screens/mobile_verify_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/widgets/social_login_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../screens/otp_verification_screen.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  @override
  SignInWidgetState createState() => SignInWidgetState();
}

class SignInWidgetState extends State<SignInWidget> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  GlobalKey<FormState>? _formKeyLogin;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController!.text =
        (Provider.of<AuthController>(context, listen: false).getUserEmail());
    _passwordController!.text =
        (Provider.of<AuthController>(context, listen: false).getUserPassword());
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passNode = FocusNode();
  LoginModel loginBody = LoginModel();

  void loginUser() async {
    if (_formKeyLogin!.currentState!.validate()) {
      _formKeyLogin!.currentState!.save();
      String email = _emailController!.text.trim();
      String password = _passwordController!.text.trim();
      if (!Provider.of<AuthController>(context, listen: false)
          .isGuestIdExist()) {
        Provider.of<AuthController>(context, listen: false).getGuestIdUrl();
      }
      if (Provider.of<AuthController>(context, listen: false).isRemember!) {
        Provider.of<AuthController>(context, listen: false)
            .saveUserEmail(email, password);
      } else {
        Provider.of<AuthController>(context, listen: false)
            .clearUserEmailAndPassword();
      }
      loginBody.email = email;
      loginBody.password = password;

      loginBody.guestId =
          Provider.of<AuthController>(context, listen: false).getGuestToken() ??
              '1';
      if (email.isEmpty) {
        showCustomSnackBar(
            getTranslated('user_name_is_required', context), context);
      } else if (password.isEmpty) {
        showCustomSnackBar(
            getTranslated('password_is_required', context), context);
      } else if (password.length < 8) {
        showCustomSnackBar(
            getTranslated('minimum_password_length', context), context);
      } else {
        await Provider.of<AuthController>(context, listen: false)
            .login(loginBody, route);
      }
    }
  }

  route(bool isRoute, String? token, String? temporaryToken,
      String? errorMessage) async {
    if (isRoute) {
      if (token == null || token.isEmpty) {
        if (Provider.of<SplashController>(context, listen: false)
            .configModel!
            .emailVerification!) {
          Provider.of<AuthController>(context, listen: false)
              .sendOtpToEmail(
                  _emailController!.text.toString(), temporaryToken!)
              .then((value) async {
            if (value.response?.statusCode == 200) {
              Provider.of<AuthController>(context, listen: false)
                  .updateEmail(_emailController!.text.toString());
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => VerificationScreen(temporaryToken, '',
                          _emailController!.text.toString())),
                  (route) => false);
            }
          });
        } else if (Provider.of<SplashController>(context, listen: false)
            .configModel!
            .phoneVerification!) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (_) => MobileVerificationScreen(temporaryToken!)),
              (route) => false);
        }
      } else {
        await Provider.of<ProfileController>(context, listen: false)
            .getUserInfo(context);

        "${Provider.of<SplashController>(context, listen: false).configModel!.phoneVerification!}"
            .log();
        token.log();
        Navigator.pushAndRemoveUntil(
            Get.context!,
            MaterialPageRoute(builder: (_) => const DashBoardScreen()),
            (route) => false);
      }
    } else {
      showCustomSnackBar(errorMessage, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthController>(context, listen: false).isRemember;

    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Form(
        key: _formKeyLogin,
        child: Column(
          children: [
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            CustomTextFieldWidget(
                hintText: "Enter phone number".translate(context),
                labelText: "Phone Number".translate(context),
                focusNode: _emailNode,
                nextFocus: _passNode,
                isRequiredFill: true,
                prefixIcon: Images.fiPhone,
                inputType: TextInputType.phone,
                controller: _emailController,
                showLabelText: true,
                required: true,
                validator: (value) => ValidateCheck.validateEmptyText(
                    value, "Enter phone number".translate(context))),
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            CustomTextFieldWidget(
                showLabelText: true,
                required: true,
                labelText: getTranslated('password', context),
                hintText: getTranslated('enter_your_password', context),
                inputAction: TextInputAction.done,
                isPassword: true,
                prefixIcon: Images.pass,
                focusNode: _passNode,
                controller: _passwordController,
                validator: (value) => ValidateCheck.validateEmptyText(
                    value, 'enter_your_password')),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Consumer<AuthController>(builder: (context, authProvider, child) {
                return InkWell(
                  onTap: () => authProvider.updateRemember(),
                  child: Row(children: [
                    SizedBox(
                        width: 20,
                        height: 20,
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.75),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(6)),
                            child: Icon(CupertinoIcons.checkmark_alt,
                                size: 15,
                                color: authProvider.isRemember!
                                    ? Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.75)
                                    : Colors.transparent))),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeSmall),
                        child: Text(getTranslated('remember', context)!,
                            style: textRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault)))
                  ]),
                );
              }),
              InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ForgetPasswordScreen())),
                  child: Text("forget_password".translate(context) + '?',
                      style: textRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: ColorResources.getPrimary(context))))
            ]),
            Container(
              margin: const EdgeInsets.only(bottom: 20, top: 30),
              child: Provider.of<AuthController>(context).isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : CustomButton(
                      onTap: loginUser,
                      buttonText: getTranslated('login', context)),
            ),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            // const SocialLoginWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have account?".translate(context),
                  style: textStyle(14),
                ),
                12.width,
                Text(
                  "Create Account".translate(context),
                  style: textStyle(14).copyWith(color: UiColors.darkBlue),
                ).onTap(() {
                  RegisterScreen(
                    fromLogout: true,
                  ).launch(context);
                })
              ],
            ),
            12.height,
            Consumer<AuthController>(builder: (context, authProvider, _) {
              return GestureDetector(
                onTap: () {
                  if (!authProvider.isLoading) {
                    Provider.of<AuthController>(context, listen: false)
                        .getGuestIdUrl();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DashBoardScreen()),
                        (route) => false);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(getTranslated('continue_as', context)!,
                          style: titleRegular.copyWith(
                              color: ColorResources.getHint(context))),
                      const SizedBox(
                        width: Dimensions.paddingSizeExtraSmall,
                      ),
                      Text(getTranslated('guest', context)!,
                          style: titleHeader),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    // color: Colors.red,
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Image.asset(
                    Images.language,
                    width: 30,
                  ),
                  7.width,
                  Text(
                    getTranslated('choose_language', context),
                  )
                ])).onTap(() {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (_) => const SelectLanguageBottomSheetWidget());
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
