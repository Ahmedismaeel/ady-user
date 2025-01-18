// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAdListHash() => r'e23027597311ff90aa227307afc03b0e89ae2289';

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

/// See also [getAdList].
@ProviderFor(getAdList)
const getAdListProvider = GetAdListFamily();

/// See also [getAdList].
class GetAdListFamily extends Family<AsyncValue<List<Product>>> {
  /// See also [getAdList].
  const GetAdListFamily();

  /// See also [getAdList].
  GetAdListProvider call({
    int? categoryId,
  }) {
    return GetAdListProvider(
      categoryId: categoryId,
    );
  }

  @override
  GetAdListProvider getProviderOverride(
    covariant GetAdListProvider provider,
  ) {
    return call(
      categoryId: provider.categoryId,
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
  String? get name => r'getAdListProvider';
}

/// See also [getAdList].
class GetAdListProvider extends AutoDisposeFutureProvider<List<Product>> {
  /// See also [getAdList].
  GetAdListProvider({
    int? categoryId,
  }) : this._internal(
          (ref) => getAdList(
            ref as GetAdListRef,
            categoryId: categoryId,
          ),
          from: getAdListProvider,
          name: r'getAdListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAdListHash,
          dependencies: GetAdListFamily._dependencies,
          allTransitiveDependencies: GetAdListFamily._allTransitiveDependencies,
          categoryId: categoryId,
        );

  GetAdListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int? categoryId;

  @override
  Override overrideWith(
    FutureOr<List<Product>> Function(GetAdListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAdListProvider._internal(
        (ref) => create(ref as GetAdListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Product>> createElement() {
    return _GetAdListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAdListProvider && other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetAdListRef on AutoDisposeFutureProviderRef<List<Product>> {
  /// The parameter `categoryId` of this provider.
  int? get categoryId;
}

class _GetAdListProviderElement
    extends AutoDisposeFutureProviderElement<List<Product>> with GetAdListRef {
  _GetAdListProviderElement(super.provider);

  @override
  int? get categoryId => (origin as GetAdListProvider).categoryId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
