import 'package:trainee/modules/global_models/menu_response.dart';
import 'package:trainee/utils/services/http_service.dart';

class ListRepository {
  // Dummy list of data
  final List<Menu> menu = [];
  // Get list of data

  Future<Map<String, dynamic>> getListOfData({int offset = 0}) async {
    int limit = 5 + offset;

    final response = await HttpService.dioService.getAllMenu();
    menu.clear();
    if (response?.data != null) {
      menu.addAll(response!.data!);
    }

    if (limit > menu.length) limit = menu.length;
    return {
      'data': menu.getRange(offset, limit).toList(),
      'next': limit < menu.length ? true : null,
      'previous': offset > 0 ? true : null,
    };
  }

  // Delete item
  void deleteItem(int id) {
    menu.removeWhere((element) => element.idMenu == id);
  }
}
