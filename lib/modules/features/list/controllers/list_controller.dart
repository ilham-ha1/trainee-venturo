import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trainee/modules/global_models/menu_response.dart';
import 'package:trainee/utils/services/http_service.dart';
import '../repositories/list_repository.dart';
import 'package:trainee/modules/global_models/promo_response.dart';

class ListController extends GetxController {
  static ListController get to => Get.find<ListController>();
  late final ListRepository repository;
  final RxInt page = 0.obs;
  final RxList<Menu> items = <Menu>[].obs;
  final RxList<Menu> selectedItems = <Menu>[].obs;
  final RxBool canLoadMore = true.obs;
  final RxString selectedCategory = 'semua menu'.obs;
  final RxString keyword = ''.obs;
  final List<String> categories = [
    'Semua Menu',
    'Makanan',
    'Minuman',
  ];
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final RxInt qty = 1.obs;

  @override
  void onInit() async {
    super.onInit();
    repository = ListRepository();
    await observePromos();
    await getListOfData();
  }

  void onRefresh() async {
    page(0);
    canLoadMore(true);
    final result = await getListOfData();
    if (result) {
      refreshController.refreshCompleted();
    } else {
      refreshController.refreshFailed();
    }
  }

  final RxList<Promo> promo = <Promo>[].obs;

  void addMoreQuantity() {
    qty.value += 1;
  }

  void minMoreQuantity() {
    if (qty > 1) qty.value -= 1;
  }

  Future observePromos() async {
    try {
      final promoResponse = await HttpService.dioService.getAllUserPromo();
      promo.clear();
      if (promoResponse?.data != null) {
        promo.addAll(promoResponse!.data!.toList());
      }
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
    }
  }

  List<Menu> get filteredList => items
      .where((element) =>
          element.nama
              .toString()
              .toLowerCase()
              .contains(keyword.value.toLowerCase()) &&
          (selectedCategory.value == 'semua menu' ||
              element.kategori == selectedCategory.value))
      .toList();

  Future<bool> getListOfData() async {
    try {
      final result = await repository.getListOfData(
        offset: page.value * 5,
      );

      if (result['previous'] == null) {
        items.clear();
      }

      if (result['next'] == null) {
        canLoadMore(false);
        refreshController.loadNoData();
      }

      items.addAll(result['data']);
      page.value++;
      refreshController.loadComplete();
      return true;
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      refreshController.loadFailed();
      return false;
    }
  }

  Future<void> deleteItem(Menu item) async {
    try {
      repository.deleteItem(item.idMenu ?? 0);
      items.remove(item);
      selectedItems.remove(item);
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
    }
  }
}
