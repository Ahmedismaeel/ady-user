// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_ad_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adSearchHash() => r'fdba084253b49df79d804c984fbcca924b2fa636';

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

/// See also [adSearch].
@ProviderFor(adSearch)
const adSearchProvider = AdSearchFamily();

/// See also [adSearch].
class AdSearchFamily extends Family<AsyncValue<FilterResponse>> {
  /// See also [adSearch].
  const AdSearchFamily();

  /// See also [adSearch].
  AdSearchProvider call({
    required FilterRequest request,
  }) {
    return AdSearchProvider(
      request: request,
    );
  }

  @override
  AdSearchProvider getProviderOverride(
    covariant AdSearchProvider provider,
  ) {
    return call(
      request: provider.request,
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
  String? get name => r'adSearchProvider';
}

/// See also [adSearch].
class AdSearchProvider extends AutoDisposeFutureProvider<FilterResponse> {
  /// See also [adSearch].
  AdSearchProvider({
    required FilterRequest request,
  }) : this._internal(
          (ref) => adSearch(
            ref as AdSearchRef,
            request: request,
          ),
          from: adSearchProvider,
          name: r'adSearchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$adSearchHash,
          dependencies: AdSearchFamily._dependencies,
          allTransitiveDependencies: AdSearchFamily._allTransitiveDependencies,
          request: request,
        );

  AdSearchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.request,
  }) : super.internal();

  final FilterRequest request;

  @override
  Override overrideWith(
    FutureOr<FilterResponse> Function(AdSearchRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AdSearchProvider._internal(
        (ref) => create(ref as AdSearchRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        request: request,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<FilterResponse> createElement() {
    return _AdSearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AdSearchProvider && other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AdSearchRef on AutoDisposeFutureProviderRef<FilterResponse> {
  /// The parameter `request` of this provider.
  FilterRequest get request;
}

class _AdSearchProviderElement
    extends AutoDisposeFutureProviderElement<FilterResponse> with AdSearchRef {
  _AdSearchProviderElement(super.provider);

  @override
  FilterRequest get request => (origin as AdSearchProvider).request;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
