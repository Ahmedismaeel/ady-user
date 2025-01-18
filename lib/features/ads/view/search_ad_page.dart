import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/controller/search_history_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/search_result_view.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/edit_text.dart';
import 'package:nb_utils/nb_utils.dart';

class SearchAdPage extends ConsumerStatefulWidget {
  final String? searchText;
  const SearchAdPage({super.key, this.searchText});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchAdPageState();
}

class _SearchAdPageState extends ConsumerState<SearchAdPage> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.text = widget.searchText ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), // here the desired height
        child: Container(
          color: UiColors.bgBlue,
          child: Column(
            children: [
              40.height,
              Row(
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width * (1 / 9)) - 15,
                    child: const Icon(
                      Icons.arrow_back,
                      size: 22,
                      color: UiColors.darkBlue,
                    ).onTap(() {
                      Navigator.pop(context);
                    }),
                  ),
                  6.width,
                  SizedBox(
                    width: (MediaQuery.of(context).size.width * (8 / 9)) - 15,
                    child: Hero(
                      tag: "SearchText",
                      child: TextField(
                        controller: controller,
                        decoration: editTextDecoration().copyWith(
                          filled: true,
                          fillColor: UiColors.white,
                          suffixIcon: InkWell(
                              onTap: () async {
                                if (controller.text.isNotEmpty) {
                                  hideKeyboard(context);
                                  controller.text.log();
                                  ref
                                      .read(searchHistoryProvider.notifier)
                                      .saveText(controller.text);

                                  await Navigator.of(context)
                                      .pushReplacement(buildPageRoute(
                                    SearchResultView(
                                        searchText: controller.text),
                                    null,
                                    null,
                                  ));
                                }
                              },
                              child: Container(
                                decoration: boxDecorationDefault(
                                    color: UiColors.bgBlue,
                                    boxShadow: [],
                                    borderRadius: BorderRadius.circular(90)),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 4),
                                child: const Icon(Icons.search,
                                    size: 20, color: UiColors.darkBlue),
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ).paddingSymmetric(horizontal: 12),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration:
              boxDecorationDefault(boxShadow: [], color: UiColors.white),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search History".translate(context),
                    style: titleHeader,
                  ),
                  ref.watch(searchHistoryProvider).isEmpty
                      ? const SizedBox.shrink()
                      : Row(
                          children: [
                            const Icon(Icons.delete, color: UiColors.error),
                            5.width,
                            Text(
                              "Clear all".translate(context),
                              style: textBold.copyWith(color: UiColors.error),
                            )
                          ],
                        ).onTap(() {
                          ref.read(searchHistoryProvider.notifier).clear();
                        })
                ],
              ).paddingOnly(bottom: 12),
              for (var item in ref.watch(searchHistoryProvider))
                Container(
                        decoration: boxDecorationDefault(
                            boxShadow: [], color: UiColors.bgBlue),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Text(item))
                    .paddingAll(6)
                    .onTap(() async {
                  await Navigator.of(context).pushReplacement(buildPageRoute(
                    SearchResultView(searchText: item),
                    null,
                    null,
                  ));
                })
            ],
          ),
        ),
      ),
    );
  }
}
