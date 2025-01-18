// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_message_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getMessageListHash() => r'5408c440bf67cd2fe4cbdf62df0e66ba51ac7961';

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

/// See also [getMessageList].
@ProviderFor(getMessageList)
const getMessageListProvider = GetMessageListFamily();

/// See also [getMessageList].
class GetMessageListFamily extends Family<AsyncValue<List<MessageModel>>> {
  /// See also [getMessageList].
  const GetMessageListFamily();

  /// See also [getMessageList].
  GetMessageListProvider call({
    required String type,
    required int? id,
    required int offset,
  }) {
    return GetMessageListProvider(
      type: type,
      id: id,
      offset: offset,
    );
  }

  @override
  GetMessageListProvider getProviderOverride(
    covariant GetMessageListProvider provider,
  ) {
    return call(
      type: provider.type,
      id: provider.id,
      offset: provider.offset,
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
  String? get name => r'getMessageListProvider';
}

/// See also [getMessageList].
class GetMessageListProvider
    extends AutoDisposeFutureProvider<List<MessageModel>> {
  /// See also [getMessageList].
  GetMessageListProvider({
    required String type,
    required int? id,
    required int offset,
  }) : this._internal(
          (ref) => getMessageList(
            ref as GetMessageListRef,
            type: type,
            id: id,
            offset: offset,
          ),
          from: getMessageListProvider,
          name: r'getMessageListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMessageListHash,
          dependencies: GetMessageListFamily._dependencies,
          allTransitiveDependencies:
              GetMessageListFamily._allTransitiveDependencies,
          type: type,
          id: id,
          offset: offset,
        );

  GetMessageListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
    required this.id,
    required this.offset,
  }) : super.internal();

  final String type;
  final int? id;
  final int offset;

  @override
  Override overrideWith(
    FutureOr<List<MessageModel>> Function(GetMessageListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetMessageListProvider._internal(
        (ref) => create(ref as GetMessageListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
        id: id,
        offset: offset,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<MessageModel>> createElement() {
    return _GetMessageListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMessageListProvider &&
        other.type == type &&
        other.id == id &&
        other.offset == offset;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetMessageListRef on AutoDisposeFutureProviderRef<List<MessageModel>> {
  /// The parameter `type` of this provider.
  String get type;

  /// The parameter `id` of this provider.
  int? get id;

  /// The parameter `offset` of this provider.
  int get offset;
}

class _GetMessageListProviderElement
    extends AutoDisposeFutureProviderElement<List<MessageModel>>
    with GetMessageListRef {
  _GetMessageListProviderElement(super.provider);

  @override
  String get type => (origin as GetMessageListProvider).type;
  @override
  int? get id => (origin as GetMessageListProvider).id;
  @override
  int get offset => (origin as GetMessageListProvider).offset;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
