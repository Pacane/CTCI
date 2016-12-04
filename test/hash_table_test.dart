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

  group('size', () {
    test('empty = 0', () {
      expect(table.size, 0);
    });

    test('insert 1 = 1', () {
      table.insert('k', 10);

      expect(table.size, 1);
    });

    test('insert n = n', () {
      final n = 100;
      for (int i = 0; i < n; ++i) {
        table.insert(i.toString(), i);
      }

      expect(table.size, n);
    });

    group('collisions', () {
      test('0 item, 0 collision', () {
        final nbCollisions = table.collisions;

        expect(nbCollisions, 0);
      });

      test('1 item, 0 collision', () {
        table.insert('a', 12);

        final nbCollisions = table.collisions;

        expect(nbCollisions, 0);
      });
    });

    group('load percentage', () {
      test('0 = 0', () {
        print(12);
        final load = table.loadPercentage;

        expect(load, 0);
      });

      test('1/11% with 1 inserted when default capacity in place', () {
        table.insert('a', 2);

        final load = table.loadPercentage;

        expect(load, 1 / 11 * 100);
      });

      test('200% with 22 inserted when default capacity in place', () {
        for (int i = 0; i < 22; ++i) {
          table.insert(i.toString(), i);
        }

        final load = table.loadPercentage;

        expect(load, 200);
      });
    });
  });
}
