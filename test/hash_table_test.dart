import 'package:test/test.dart';
import 'package:ctci/hash_table.dart';

HashTable<String, int> table;

main() {
  setUp(() {
    table = new HashTable<String, int>();
  });

  group('insert', () {
    test('Table size increments on insertion', () {
      table.insert('a', 13);
      expect(table.size, 1);

      table.insert('b', 14);
      expect(table.size, 2);
    });

    test('throws error when inserting duplicate key', () {
      table.insert('a', 13);
      expect(() => table.insert('a', 14), throwsArgumentError);
    });
  });

  group('get', () {
    test('returns null when item is absent', () {
      final result = table.get('someKey');

      expect(result, isNull);
    });

    test('returns null when item is absent', () {
      final key = 'someKey';
      final value = 16;
      table.insert(key, value);

      final result = table.get(key);

      expect(result, value);
    });
  });
}
