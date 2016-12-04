class HashTable<K extends Object, V> {
  List<List<Tuple<K, V>>> buckets = [];
  int capacity;
  int _size = 0;

  HashTable({this.capacity = 11}) {
    buckets = new List(capacity);
  }

  int get size => _size;
  int get collisions => buckets.fold(
      0,
      (prev, bucket) =>
          bucket != null && bucket.length > 1 ? prev + bucket.length : 0);
  num get loadPercentage {
    return size * 100 / capacity;
  }

  void insert(K key, V value) {
    final hashedKey = key.hashCode % capacity;
    final bucket = buckets[hashedKey];
    final record = new Tuple(key, value);

    if (bucket == null) {
      final sublist = <Tuple<K, V>>[];
      buckets[hashedKey] = sublist;
      sublist.add(record);
    } else {
      if (bucket.any((Tuple<K, V> t) => t.first == record.first)) {
        throw new ArgumentError.value(
            "Can't add duplicate items in table : $key, $value");
      }

      bucket.add(record);
    }

    _size++;
  }

  V get(K key) {
    final hashedKey = key.hashCode % capacity;
    final matchingRecord =
        buckets[hashedKey]?.firstWhere((Tuple<K, V> t) => t.first == key);
    return matchingRecord?.second;
  }
}

class Tuple<T1, T2> {
  final T1 first;
  final T2 second;

  Tuple(this.first, this.second);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Tuple &&
        this.first == other.first &&
        this.second == other.second;
  }

  @override
  int get hashCode {
    return first.hashCode ^ second.hashCode;
  }
}
