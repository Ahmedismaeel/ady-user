import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/controllers/order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/widgets/order_shimmer_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/widgets/order_type_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/widgets/order_widget.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/not_loggedin_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/paginated_list_view_widget.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  final bool isBacButtonExist;
  const OrderScreen({super.key, this.isBacButtonExist = true});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  ScrollController scrollController = ScrollController();
  bool isGuestMode =
      !Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn();
  @override
  void initState() {
    if (!isGuestMode) {
      Provider.of<OrderController>(context, listen: false)
          .setIndex(0, notify: false);
      Provider.of<OrderController>(context, listen: false)
          .getOrderList(1, 'ongoing');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: getTranslated('orders', context),
          isBackButtonExist: widget.isBacButtonExist),
      body: isGuestMode
          ? NotLoggedInWidget(
              message: getTranslated('to_view_the_order_history', context))
          : Consumer<OrderController>(
              builder: (context, orderController, child) {
              return Column(
                children: [
                  // Padding(
                  //     padding:
                  //         const EdgeInsets.all(Dimensions.paddingSizeLarge),
                  //     child: Row(children: [
                  //       OrderTypeButton(
                  //           text: getTranslated('RUNNING', context), index: 0),
                  //       const SizedBox(width: Dimensions.paddingSizeSmall),
                  //       OrderTypeButton(
                  //           text: getTranslated('DELIVERED', context),
                  //           index: 1),
                  //       const SizedBox(width: Dimensions.paddingSizeSmall),
                  //       OrderTypeButton(
                  //           text: getTranslated('CANCELED', context), index: 2)
                  //     ])),
                  6.height,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                      child: CustomSlidingSegmentedControl<int>(
                        // key: UniqueKey(),
                        padding: 7,
                        fromMax: true,
                        isStretch: true,
                        children: {
                          0: Text(
                            "RUNNING".translate(context),
                            textAlign: TextAlign.center,
                            style: textStyle(15).copyWith(
                                color: orderController.orderTypeIndex == 0
                                    ? UiColors.white
                                    : UiColors.medGrey),
                          ),
                          1: Text(
                            "DELIVERED".translate(context),
                            textAlign: TextAlign.center,
                            style: textStyle(15).copyWith(
                                color: orderController.orderTypeIndex == 1
                                    ? UiColors.white
                                    : UiColors.medGrey),
                          ),
                          2: Text(
                            "CANCELED".translate(context),
                            textAlign: TextAlign.center,
                            style: textStyle(15).copyWith(
                                color: orderController.orderTypeIndex == 2
                                    ? UiColors.white
                                    : UiColors.medGrey),
                          ),
                        },
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        thumbDecoration: BoxDecoration(
                          color: UiColors.darkBlue,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        onValueChanged: (int value) {
                          print(value);
                          orderController.setIndex(value);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                      child: orderController.orderModel != null
                          ? (orderController.orderModel!.orders != null &&
                                  orderController
                                      .orderModel!.orders!.isNotEmpty)
                              ? SingleChildScrollView(
                                  controller: scrollController,
                                  child: PaginatedListView(
                                    scrollController: scrollController,
                                    onPaginate: (int? offset) async {
                                      await orderController.getOrderList(
                                          offset!,
                                          orderController.selectedType);
                                    },
                                    totalSize:
                                        orderController.orderModel?.totalSize,
                                    offset: orderController
                                                .orderModel?.offset !=
                                            null
                                        ? int.parse(
                                            orderController.orderModel!.offset!)
                                        : 1,
                                    itemView: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: orderController
                                          .orderModel?.orders!.length,
                                      padding: const EdgeInsets.all(0),
                                      itemBuilder: (context, index) =>
                                          OrderWidget(
                                              orderModel: orderController
                                                  .orderModel?.orders![index]),
                                    ),
                                  ),
                                )
                              : const NoInternetOrDataScreenWidget(
                                  isNoInternet: false,
                                  icon: Images.noOrder,
                                  message: 'no_order_found',
                                )
                          : const OrderShimmerWidget())
                ],
              );
            }),
    );
  }
}
