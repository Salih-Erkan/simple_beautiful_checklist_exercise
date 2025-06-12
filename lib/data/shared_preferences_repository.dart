import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  static const String _key = 'checklist_items';

  Future<List<String>> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  Future<void> saveItems(List<String> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, items);
  }

  @override
  Future<int> getItemCount() async {
    final items = await loadItems();
    return items.length;
  }

  @override
  Future<List<String>> getItems() async {
    return await loadItems();
  }

  @override
  Future<void> addItem(String item) async {
    final items = await loadItems();
    if (item.isNotEmpty && !items.contains(item)) {
      items.add(item);
      await saveItems(items);
    }
  }

  @override
  Future<void> deleteItem(int index) async {
    final items = await loadItems();
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
      await saveItems(items);
    }
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    final items = await loadItems();
    if (newItem.isNotEmpty &&
        !items.contains(newItem) &&
        index >= 0 &&
        index < items.length) {
      items[index] = newItem;
      await saveItems(items);
    }
  }
}
