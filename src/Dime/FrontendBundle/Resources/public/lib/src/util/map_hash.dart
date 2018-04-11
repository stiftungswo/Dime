/// hashes a Maps content (not the reference like [Map.hashCode] does)
int mapHash(Map map) {
  return _hashObjects(map.keys.map((dynamic key) => _hash2(key.hashCode, map[key].hashCode)).toList(growable: false)..sort());
}

// the following is stolen from https://github.com/google/quiver-dart/blob/747f91d82a6a9e25d75d87c737faf2d937e4ece0/lib/src/core/hash.dart#L17-L45

/// Generates a hash code for multiple [objects].
int _hashObjects(Iterable objects) => _finish(objects.fold(0, (h, dynamic i) => _combine(h, i.hashCode)));

/// Generates a hash code for two objects.
int _hash2(dynamic a, dynamic b) => _finish(_combine(_combine(0, a.hashCode), b.hashCode));

// Jenkins hash functions

int _combine(int hash, int value) {
  hash = 0x1fffffff & (hash + value);
  hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
  return hash ^ (hash >> 6);
}

int _finish(int hash) {
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  hash = hash ^ (hash >> 11);
  return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
}
