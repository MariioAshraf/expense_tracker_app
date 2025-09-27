import 'package:flutter_test/flutter_test.dart';

List<T> paginate<T>(List<T> all, int page, int limit) {
  final start = page * limit;
  if (start >= all.length) return <T>[];
  final end = (start + limit) > all.length ? all.length : (start + limit);
  return all.sublist(start, end);
}

void main() {
  test('pagination returns last page with remaining items', () {
    final all = List<int>.generate(28, (i) => i); // 0..27
    final page2 = paginate(all, 2, 10); // page index 2 -> items 20..27
    expect(page2.length, 8);
    expect(page2.first, 20);
    expect(page2.last, 27);
  });

  test('pagination returns empty when page out of range', () {
    final all = List<int>.generate(28, (i) => i);
    final page3 = paginate(all, 3, 10); // start = 30 >= 28 => []
    expect(page3, isEmpty);
  });
}
