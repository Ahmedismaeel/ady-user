// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_product_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$latestProductListHash() => r'dee33f838a2f9e3517925010472e6c12266c76c5';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [latestProductList].
@ProviderFor(latestProductList)
const latestProductListProvider = LatestProductListFamily();

/// See also [latestProductList].
class LatestProductListFamily extends Family<AsyncValue<ProductModel>> {
  /// See also [latestProductList].
  const LatestProductListFamily();

  /// See also [latestProductList].
  LatestProductListProvider call({
    required int page,
  }) {
    return LatestProductListProvider(
      page: page,
    );
  }

  @override
  LatestProductListProvider getProviderOverride(
    covariant LatestProductListProvider provider,
  ) {
    return call(
      page: provider.page,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'latestProductListProvider';
}

/// See also [latestProductList].
class LatestProductListProvider
    extends AutoDisposeFutureProvider<ProductModel> {
  /// See also [latestProductList].
  LatestProductListProvider({
    required int page,
  }) : this._internal(
          (ref) => latestProductList(
            ref as LatestProductListRef,
            page: page,
          ),
          from: latestProductListProvider,
          name: r'latestProductListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$latestProductListHash,
          dependencies: LatestProductListFamily._dependencies,
          allTransitiveDependencies:
              LatestProductListFamily._allTransitiveDependencies,
          page: page,
        );

  LatestProductListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
  }) : super.internal();

  final int page;

  @override
  Override overrideWith(
    FutureOr<ProductModel> Function(LatestProductListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LatestProductListProvider._internal(
        (ref) => create(ref as LatestProductListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ProductModel> createElement() {
    return _LatestProductListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LatestProductListProvider && other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LatestProductListRef on AutoDisposeFutureProviderRef<ProductModel> {
  /// The parameter `page` of this provider.
  int get page;
}

class _LatestProductListProviderElement
    extends AutoDisposeFutureProviderElement<ProductModel>
    with LatestProductListRef {
  _LatestProductListProviderElement(super.provider);

  @override
  int get page => (origin as LatestProductListProvider).page;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
