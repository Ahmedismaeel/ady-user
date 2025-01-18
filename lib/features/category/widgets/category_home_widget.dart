import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/models/category_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/screens/category_new_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/cach_image.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:animate_do/animate_do.dart';

class CategoryHomeList extends ConsumerWidget {
  const CategoryHomeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        child: ProviderHelperWidget(
            function: (list) => _CategoryListWidget(
                  list: list,
                ),
            loadingShape: _CategoryListWidget(
              list: [
                CategoryModel(),
                CategoryModel(),
                CategoryModel(),
                CategoryModel(),
              ],
            ),
            listener: ref.watch(categoryListProvider)));
  }
}

class _CategoryListWidget extends ConsumerWidget {
  final List<CategoryModel> list;
  const _CategoryListWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
        child: ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return CategoryBaseWidget(category: list[index])
            .paddingBottom(12)
            .onTap(() async {
          ref.read(categoryProvider.notifier).state = list[index];
          await const CategoryNewScreen()
              .launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
        });
      },
    ));
  }
}

class CategoryBaseWidget extends StatelessWidget {
  const CategoryBaseWidget({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationDefault(
        boxShadow: [],
        border: Border.all(
          width: 1,
          color: Colors.white,
          // (switch (category.id) {
          //   // 1 => Color(0xFFFFCC01),
          //   // 2 => Color(0xFF00A60B),
          //   // 3 => Color(0xFF014BAC),
          //   // 4 => Color(0xFFB70000),
          //   1 => Colors.yellow,
          //   2 => Colors.green,
          //   3 => Colors.blue,
          //   4 => Colors.red,
          //   // TODO: Handle this case.
          //   int() => UiColors.cBlue,
          //   // TODO: Handle this case.
          //   null => UiColors.cBlue,
          // })
          // // .withOpacity(0.4),
        ),
        color: (switch (category.id) {
          // 1 => Color(0xFFFFCC01),
          // 2 => Color(0xFF00A60B),
          // 3 => Color(0xFF014BAC),
          // 4 => Color(0xFFB70000),
          1 => const Color(0xFFFFCC01),
          2 => Color(0xFF00A60B),
          3 => UiColors.darkBlue,
          4 => UiColors.darkRed,
          // TODO: Handle this case.
          int() => UiColors.cBlue,
          // TODO: Handle this case.
          null => UiColors.cBlue,
        }),
        // color: Colors.white.withOpacity(0.88),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          CacheImage(
            height: 60,
            width: 60,
            image: category.imageFullUrl?.path ?? "",
            radius: 12,
          ),
          12.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.name ?? "",
                style: textStyle(16).copyWith(
                  color: (switch (category.id) {
                    // 1 => Color(0xFFFFCC01),
                    // 2 => Color(0xFF00A60B),
                    // 3 => Color(0xFF014BAC),
                    // 4 => Color(0xFFB70000),
                    1 => Colors.white,
                    2 => Colors.white,
                    3 => Colors.white,
                    4 => Colors.white,
                    // TODO: Handle this case.
                    int() => UiColors.cBlue,
                    // TODO: Handle this case.
                    null => UiColors.cBlue,
                  }),
                  fontWeight: FontWeight.bold,
                ),
              ),
              8.height,
              SizedBox(
                width: 220,
                child: Text(
                  category.description ?? "",
                  style: textStyle(14).copyWith(
                    color: (switch (category.id) {
                      1 => Colors.white,
                      2 => Colors.white,
                      3 => Colors.white,
                      4 => Colors.white,
                      int() => UiColors.cBlue,
                      null => UiColors.cBlue,
                    }),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
