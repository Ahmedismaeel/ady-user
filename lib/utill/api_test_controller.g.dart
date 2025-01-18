// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_test_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$apiTesterHash() => r'24ee4adf6436384a65f4fe9ae280c0e9b0aacd84';

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

/// See also [apiTester].
@ProviderFor(apiTester)
const apiTesterProvider = ApiTesterFamily();

/// See also [apiTester].
class ApiTesterFamily extends Family<AsyncValue<dynamic>> {
  /// See also [apiTester].
  const ApiTesterFamily();

  /// See also [apiTester].
  ApiTesterProvider call({
    required String url,
  }) {
    return ApiTesterProvider(
      url: url,
    );
  }

  @override
  ApiTesterProvider getProviderOverride(
    covariant ApiTesterProvider provider,
  ) {
    return call(
      url: provider.url,
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
  String? get name => r'apiTesterProvider';
}

/// See also [apiTester].
class ApiTesterProvider extends AutoDisposeFutureProvider<dynamic> {
  /// See also [apiTester].
  ApiTesterProvider({
    required String url,
  }) : this._internal(
          (ref) => apiTester(
            ref as ApiTesterRef,
            url: url,
          ),
          from: apiTesterProvider,
          name: r'apiTesterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$apiTesterHash,
          dependencies: ApiTesterFamily._dependencies,
          allTransitiveDependencies: ApiTesterFamily._allTransitiveDependencies,
          url: url,
        );

  ApiTesterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.url,
  }) : super.internal();

  final String url;

  @override
  Override overrideWith(
    FutureOr<dynamic> Function(ApiTesterRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ApiTesterProvider._internal(
        (ref) => create(ref as ApiTesterRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        url: url,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<dynamic> createElement() {
    return _ApiTesterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ApiTesterProvider && other.url == url;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ApiTesterRef on AutoDisposeFutureProviderRef<dynamic> {
  /// The parameter `url` of this provider.
  String get url;
}

class _ApiTesterProviderElement
    extends AutoDisposeFutureProviderElement<dynamic> with ApiTesterRef {
  _ApiTesterProviderElement(super.provider);

  @override
  String get url => (origin as ApiTesterProvider).url;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
