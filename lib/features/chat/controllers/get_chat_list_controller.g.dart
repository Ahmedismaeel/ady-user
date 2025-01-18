// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_chat_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getChatListHash() => r'c05962d70f20a90d3d21fdcd18bb3cdd134b399a';

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

/// See also [getChatList].
@ProviderFor(getChatList)
const getChatListProvider = GetChatListFamily();

/// See also [getChatList].
class GetChatListFamily extends Family<AsyncValue<ChatModel>> {
  /// See also [getChatList].
  const GetChatListFamily();

  /// See also [getChatList].
  GetChatListProvider call({
    required ChatType type,
    required int offset,
  }) {
    return GetChatListProvider(
      type: type,
      offset: offset,
    );
  }

  @override
  GetChatListProvider getProviderOverride(
    covariant GetChatListProvider provider,
  ) {
    return call(
      type: provider.type,
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
  String? get name => r'getChatListProvider';
}

/// See also [getChatList].
class GetChatListProvider extends AutoDisposeFutureProvider<ChatModel> {
  /// See also [getChatList].
  GetChatListProvider({
    required ChatType type,
    required int offset,
  }) : this._internal(
          (ref) => getChatList(
            ref as GetChatListRef,
            type: type,
            offset: offset,
          ),
          from: getChatListProvider,
          name: r'getChatListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getChatListHash,
          dependencies: GetChatListFamily._dependencies,
          allTransitiveDependencies:
              GetChatListFamily._allTransitiveDependencies,
          type: type,
          offset: offset,
        );

  GetChatListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
    required this.offset,
  }) : super.internal();

  final ChatType type;
  final int offset;

  @override
  Override overrideWith(
    FutureOr<ChatModel> Function(GetChatListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetChatListProvider._internal(
        (ref) => create(ref as GetChatListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
        offset: offset,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ChatModel> createElement() {
    return _GetChatListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetChatListProvider &&
        other.type == type &&
        other.offset == offset;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetChatListRef on AutoDisposeFutureProviderRef<ChatModel> {
  /// The parameter `type` of this provider.
  ChatType get type;

  /// The parameter `offset` of this provider.
  int get offset;
}

class _GetChatListProviderElement
    extends AutoDisposeFutureProviderElement<ChatModel> with GetChatListRef {
  _GetChatListProviderElement(super.provider);

  @override
  ChatType get type => (origin as GetChatListProvider).type;
  @override
  int get offset => (origin as GetChatListProvider).offset;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
