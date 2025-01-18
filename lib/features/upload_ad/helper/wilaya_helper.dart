import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/wilaya_model.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';

class WilayatHelperNotifier extends StateNotifier<WilayaModel?> {
  WilayatHelperNotifier() : super(null);
  setWilayat(WilayaModel wilaya) {
    state = wilaya;
  }

  clear() {
    state = null;
  }

  getName() => getLang() ? state?.name ?? null : state?.nameAr ?? null;
}

final wilayatHelperProvider =
    StateNotifierProvider<WilayatHelperNotifier, WilayaModel?>((ref) {
  return WilayatHelperNotifier();
});
