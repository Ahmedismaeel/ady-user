import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_field_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/field_couter.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/field_selection_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/select_governorate_view.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:nb_utils/nb_utils.dart';

class CategoryFieldsView extends ConsumerStatefulWidget {
  const CategoryFieldsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoryFieldsViewState();
}

class _CategoryFieldsViewState extends ConsumerState<CategoryFieldsView> {
  @override
  Widget build(BuildContext context) {
    return (ref.watch(getCategoryFieldsProvider).asData?.value ?? []).isEmpty
        ? SelectGovernorateWidget()
        : FieldSelectionView(
            field: ref
                .watch(getCategoryFieldsProvider)
                .asData!
                .value![ref.watch(fieldCounterProvider)],
          );
  }
}

class FieldListWidget extends ConsumerStatefulWidget {
  final List<FieldWithOrder> list;
  const FieldListWidget({
    super.key,
    required this.list,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FieldListWidgetState();
}

class _FieldListWidgetState extends ConsumerState<FieldListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.list.isEmpty
        ? SelectGovernorateWidget()
        : FieldSelectionView(
            field: widget.list[ref.watch(fieldCounterProvider)],
          );
  }
}
