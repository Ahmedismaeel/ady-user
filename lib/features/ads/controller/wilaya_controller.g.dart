// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wilaya_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$wilayaListHash() => r'2f09a3457c7d72f075c7304c1f49f428118396bd';

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

/// See also [wilayaList].
@ProviderFor(wilayaList)
const wilayaListProvider = WilayaListFamily();

/// See also [wilayaList].
class WilayaListFamily extends Family<AsyncValue<List<WilayaModel>>> {
  /// See also [wilayaList].
  const WilayaListFamily();

  /// See also [wilayaList].
  WilayaListProvider call(
    int id,
  ) {
    return WilayaListProvider(
      id,
    );
  }

  @override
  WilayaListProvider getProviderOverride(
    covariant WilayaListProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'wilayaListProvider';
}

/// See also [wilayaList].
class WilayaListProvider extends AutoDisposeFutureProvider<List<WilayaModel>> {
  /// See also [wilayaList].
  WilayaListProvider(
    int id,
  ) : this._internal(
          (ref) => wilayaList(
            ref as WilayaListRef,
            id,
          ),
          from: wilayaListProvider,
          name: r'wilayaListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$wilayaListHash,
          dependencies: WilayaListFamily._dependencies,
          allTransitiveDependencies:
              WilayaListFamily._allTransitiveDependencies,
          id: id,
        );

  WilayaListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<List<WilayaModel>> Function(WilayaListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WilayaListProvider._internal(
        (ref) => create(ref as WilayaListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<WilayaModel>> createElement() {
    return _WilayaListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WilayaListProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WilayaListRef on AutoDisposeFutureProviderRef<List<WilayaModel>> {
  /// The parameter `id` of this provider.
  int get id;
}

class _WilayaListProviderElement
    extends AutoDisposeFutureProviderElement<List<WilayaModel>>
    with WilayaListRef {
  _WilayaListProviderElement(super.provider);

  @override
  int get id => (origin as WilayaListProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
