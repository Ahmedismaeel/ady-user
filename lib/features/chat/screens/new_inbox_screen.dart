import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/not_loggedin_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/controllers/chat_type_enum.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/controllers/get_chat_list_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/domain/models/chat_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/screens/chat_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/widgets/chat_item_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:search_page/search_page.dart';

class InboxScreenNew extends ConsumerStatefulWidget {
  final bool isBackButtonExist;
  const InboxScreenNew({super.key, this.isBackButtonExist = true});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InboxScreenNewState();
}

class _InboxScreenNewState extends ConsumerState<InboxScreenNew> {
  int page = 0;
  setPage(int value) {
    setState(() {
      page = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: Navigator.of(context).canPop(),
      onPopInvoked: (val) async {
        if (Navigator.of(context).canPop()) {
          return;
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const DashBoardScreen()));
        }
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: CustomAppBar(
              title: getTranslated('inbox', context),
              isBackButtonExist: widget.isBackButtonExist,
              onBackPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const DashBoardScreen()));
                }
              }),
          body: !isLoggedIn
              ? const NotLoggedInWidget()
              : Column(
                  children: [
                    // TabBar(
                    //   unselectedLabelColor: Colors.grey,
                    //   isScrollable: true,
                    //   dividerColor: Colors.transparent,
                    //   indicatorColor: Theme.of(context).primaryColor,
                    //   labelColor: Theme.of(context).primaryColor,
                    //   labelStyle: textMedium,
                    //   indicatorWeight: 1,
                    //   tabAlignment: TabAlignment.start,
                    //   // labelPadding: EdgeInsets.only(

                    //   // ),
                    //   indicatorPadding: const EdgeInsets.only(right: 10),
                    //   tabs: [
                    //     Tab(
                    //       text: 'customer'.translate(context),
                    //     ),
                    //     Tab(
                    //       text: getTranslated('vendor', context),
                    //     ),
                    //     Tab(text: 'Advertiser'.translate(context)),
                    //   ],
                    // ),
                    12.height,
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CustomSlidingSegmentedControl<int>(
                          // key: UniqueKey(),
                          padding: 7,
                          fromMax: true,
                          isStretch: true,
                          children: {
                            0: Text(
                              "customer".translate(context),
                              textAlign: TextAlign.center,
                              style: textStyle(15).copyWith(
                                  color: page == 0
                                      ? UiColors.white
                                      : UiColors.medGrey),
                            ),
                            1: Text(
                              "vendor".translate(context),
                              textAlign: TextAlign.center,
                              style: textStyle(15).copyWith(
                                  color: page == 1
                                      ? UiColors.white
                                      : UiColors.medGrey),
                            ),
                            2: Text(
                              "Advertiser".translate(context),
                              textAlign: TextAlign.center,
                              style: textStyle(15).copyWith(
                                  color: page == 2
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
                            setPage(value);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                        child: switch (page) {
                      0 => ProviderHelperWidget(
                          function: (list) {
                            return ChatPageWidget(
                              list: list,
                              type: ChatType.customer,
                            );
                          },
                          listener: ref.watch(getChatListProvider(
                              offset: 1, type: ChatType.customer))),
                      1 => ProviderHelperWidget(
                          function: (list) {
                            return ChatPageWidget(
                              list: list,
                              type: ChatType.seller,
                            );
                          },
                          listener: ref.watch(getChatListProvider(
                              offset: 1, type: ChatType.seller))),
                      2 => ProviderHelperWidget(
                          function: (list) {
                            return ChatPageWidget(
                              list: list,
                              type: ChatType.ader,
                            );
                          },
                          listener: ref.watch(getChatListProvider(
                              offset: 1, type: ChatType.ader))),
                      // TODO: Handle this case.
                      int() => SizedBox(),
                    }),
                  ],
                ),
        ),
      ),
    );
  }
}

class ChatPageWidget extends ConsumerWidget {
  final ChatModel list;
  final ChatType type;
  const ChatPageWidget({super.key, required this.list, required this.type});

  @override
  Widget build(BuildContext context, ref) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(getChatListProvider(offset: 1, type: ChatType.customer));
      },
      child: ListView(
        children: [
          Container(
            decoration: boxDecorationDefault(),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(getTranslated('search', context)),
                Icon(Icons.search)
              ],
            ),
          ).paddingAll(12).onTap(() => showSearch(
                context: context,
                delegate: SearchPage(
                  onQueryUpdate: print,
                  items: list.chat ?? [],
                  searchLabel: 'Search Chat',
                  suggestion: const Center(
                    child:
                        Text('Filter chat by name, last name or last Message'),
                  ),
                  failure: const Center(
                    child: Text('No chat found'),
                  ),
                  filter: (chat) => [
                    chat.message,
                    chat.user?.fName,
                    chat.user?.lName,
                  ],
                  // sort: (a, b) => a.compareTo(b),
                  builder: (chat) => ChatWidget(chat: chat, type: type),
                ),
              )),
          // Text("data").onTap(() async {}),
          ListView.builder(
            itemCount: list.chat?.length ?? 0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return ChatWidget(chat: list.chat![index], type: type);
            },
          ),
        ],
      ),
    );
  }
}

class ChatWidget extends StatefulWidget {
  final Chat chat;
  final ChatType type;
  const ChatWidget({super.key, required this.chat, required this.type});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  bool vacationIsOn = false;
  @override
  void initState() {
    // TODO: implement initState
    afterBuildCreated((() {
      if (widget.chat?.sellerInfo?.shops![0].vacationEndDate != null) {
        DateTime vacationDate =
            DateTime.parse(widget.chat!.sellerInfo!.shops![0].vacationEndDate!);
        DateTime vacationStartDate = DateTime.parse(
            widget.chat!.sellerInfo!.shops![0].vacationStartDate!);
        final today = DateTime.now();
        final difference = vacationDate.difference(today).inDays;
        final startDate = vacationStartDate.difference(today).inDays;

        if ((difference >= 0 &&
                widget.chat!.sellerInfo!.shops![0].vacationStatus! &&
                startDate <= 0) ||
            widget.chat!.sellerInfo!.shops![0].temporaryClose!) {
          vacationIsOn = true;
        } else {
          vacationIsOn = false;
        }
        setState(() {});
      }
    }));
    super.initState();
  }

  getTypeId() {
    switch (widget.type) {
      case ChatType.customer:
        return 0;
      case ChatType.seller:
        return 1;
      case ChatType.ader:
        return 2;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            Get.context!,
            MaterialPageRoute(
                builder: (_) => ChatScreen(
                      userType: getTypeId(),
                      id: widget.chat.sellerId ??
                          widget.chat.adminId ??
                          widget.chat.user?.id,
                      name: widget.type == ChatType.seller
                          ? (widget.chat.sellerInfo?.shops?[0].name ??
                              "No Shop Found")
                          : "${widget.chat.user?.fName ?? "--"} ${widget.chat.user?.lName ?? "--"}",
                      image: widget.type == ChatType.seller
                          ? (widget.chat?.sellerInfo?.shops?[0].imageFullUrl
                                  ?.path ??
                              "")
                          : (widget.chat.user?.imageFullUrl?.path ?? ""),
                      isDelivery: false,
                      phone: widget.type != ChatType.seller
                          ? ("${widget.chat.user?.phone}")
                          : null,
                      shopClose: vacationIsOn,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            color: (widget.chat.unseenMessageCount != null &&
                    (widget.chat.unseenMessageCount ?? 0) > 0)
                ? Theme.of(context).primaryColor.withOpacity(.05)
                : Theme.of(context).cardColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Dimensions.paddingSizeDefault,
              horizontal: Dimensions.paddingSizeDefault),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.25),
                              width: .5),
                          borderRadius: BorderRadius.circular(100)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CustomImageWidget(
                              image: widget.type == ChatType.seller
                                  ? (widget.chat?.sellerInfo?.shops?[0]
                                          .imageFullUrl?.path ??
                                      "")
                                  : (widget.chat.user?.imageFullUrl?.path ??
                                      ""),
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover))),
                  if (vacationIsOn)
                    Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Colors.black54.withOpacity(.65),
                            borderRadius: BorderRadius.circular(100)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Center(
                                child: Text(
                              getTranslated("close", context) ?? '',
                              style: textMedium.copyWith(color: Colors.white),
                            ))))
                ],
              ),
              const SizedBox(
                width: Dimensions.paddingSizeDefault,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        (widget.chat?.adminId == 0)
                            ? Expanded(
                                child: Text("Admin",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textBold.copyWith(
                                        fontSize: Dimensions.fontSizeDefault)))
                            : Expanded(
                                child: Text(
                                    widget.type == ChatType.seller
                                        ? (widget.chat.sellerInfo?.shops?[0]
                                                .name ??
                                            "No Shop Found")
                                        : "${widget.chat.user?.fName ?? "--"} ${widget.chat.user?.lName ?? "--"}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textBold.copyWith(
                                        fontSize: Dimensions.fontSizeDefault))),
                        const SizedBox(width: Dimensions.paddingSizeSmall),
                        Text(
                            DateConverter.compareDates(
                                widget.chat?.createdAt ?? ""),
                            style: titilliumRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).hintColor)),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    Row(children: [
                      Expanded(
                        child: Text(
                            widget.chat?.message ??
                                getTranslated('sent_attachment', context),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault)),
                      ),
                      if (widget.chat?.unseenMessageCount != null &&
                          (widget.chat?.unseenMessageCount ?? 0) > 0)
                        const SizedBox(width: Dimensions.paddingSizeSmall),
                      if (widget.chat?.unseenMessageCount != null &&
                          (widget.chat?.unseenMessageCount ?? 0) > 0)
                        CircleAvatar(
                            radius: 12,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text('${widget.chat?.unseenMessageCount}',
                                style: textRegular.copyWith(
                                    color: Colors.white,
                                    fontSize: Dimensions.fontSizeSmall)))
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
