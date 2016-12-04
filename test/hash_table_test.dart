import 'package:test/test.dart';
import 'package:ctci/hash_table.dart';

main() {
  test('Table size increments on insertion', () {
    final table = new HashTable<String, int>();

    table.insert('a', 13);
    expect(table.size, 1);

    table.insert('b', 14);
    expect(table.size, 2);
  });
}
