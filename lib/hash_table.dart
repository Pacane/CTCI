class HashTable<K extends Object, V> {
  List<List<Tuple<K, V>>> values = [];
  final int initialSize;
  int _size = 0;

  HashTable({this.initialSize = 11}) {
    values = new List(initialSize);
  }

  int get size => _size;

  void insert(K key, V value) {
    final hashedKey = key.hashCode % initialSize;
    final bucket = values[hashedKey];
    final record = new Tuple(key, value);

    if (bucket == null) {
      final sublist = <Tuple<K, V>>[];
      values[hashedKey] = sublist;
      sublist.add(record);
    } else {
      if (bucket.contains(record)) {
        throw new Exception("Can't add duplicate items in table");
      }

      bucket.add(record);
    }

    _size++;
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