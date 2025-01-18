import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/selected_cateogry_provider.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/model/category_field_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/field_couter.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'category_field_controller.g.dart';

@Riverpod(keepAlive: true)
Future<List<FieldWithOrder>> getCategoryFields(GetCategoryFieldsRef ref) async {
  final list = await AppConstants.categoryFields(
          ref.watch(subcategoryIdProvider).id ?? 0)
      .getList(fromJson: CategoryFieldModel.fromJson);
  list.sort((a, b) => a.order?.compareTo(b.order ?? 0) ?? 0);
  ref.read(fieldsSizeProvider.notifier).setSize(list.length);
  return List.generate(
      list.length, (index) => FieldWithOrder(index, list[index]));
}

class FieldWithOrder {
  final int order;
  final CategoryFieldModel field;
  FieldWithOrder(this.order, this.field);
  log() {
    "order $order \n ${field.toJson()}".log();
  }
}
