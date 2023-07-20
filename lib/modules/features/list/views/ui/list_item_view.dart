import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/list/controllers/list_controller.dart';
import 'package:trainee/modules/features/list/views/components/menu_card.dart';
import 'package:trainee/modules/features/list/views/components/menu_chip.dart';
import 'package:trainee/modules/features/list/views/components/promo_card.dart';
import 'package:trainee/modules/features/list/views/components/search_app_bar.dart';
import 'package:trainee/modules/features/list/views/components/section_header.dart';
import 'package:trainee/shared/customs/bottom_navigation_custom.dart';

class ListItemView extends StatelessWidget {
  const ListItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: SearchAppBar(
          onChange: (value) => ListController.to.keyword(value),
        ),
        body: NestedScrollView(
            physics: const ClampingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(child: 22.verticalSpace),
                // list of promo
                const SliverToBoxAdapter(
                  child: SectionHeader(
                    icon: Icons.note_alt_outlined,
                    title: 'Promo yang tersedia',
                  ),
                ),
                SliverToBoxAdapter(child: 22.verticalSpace),

                SliverToBoxAdapter(
                  child: Obx( () =>
                    SizedBox(
                      width: 1.sw,
                      height: 188.h,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          itemBuilder: (context, index) {
                            final item = ListController.to.promo[index];
                            return PromoCard(
                                enableShadow: false,
                                promoName: item.nama.toString(),
                                discountNominal: item.nominal.toString(),
                                thumbnailUrl: item.foto ?? "",
                              );
                            
                          },
                          separatorBuilder: (context, index) =>
                              26.horizontalSpace,
                          itemCount: ListController.to.promo.length),
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: 22.verticalSpace),
                // Row of categories
                SliverToBoxAdapter(
                  child: SizedBox(
                    width: 1.sw,
                    height: 45.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: ListController.to.categories.length,
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      itemBuilder: (context, index) {
                        final category = ListController.to.categories[index];
                        return Obx(() => MenuChip(
                              onTap: () {
                                ListController.to
                                    .selectedCategory(category.toLowerCase());
                              },
                              isSelected:
                                  ListController.to.selectedCategory.value ==
                                      category.toLowerCase(),
                              text: category,
                            ));
                      },
                      separatorBuilder: (context, index) => 13.horizontalSpace,
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: 10.verticalSpace),
              ];
            },
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  final currentCategory =
                      ListController.to.selectedCategory.value;
                  return Container(
                    width: 1.sw,
                    height: 35.h,
                    color: Colors.grey[100],
                    margin: EdgeInsets.only(bottom: 10.h),
                    child: SectionHeader(
                      title: currentCategory == 'semua menu'
                          ? 'Semua Menu'
                          : currentCategory == 'makanan'
                              ? 'Makanan'
                              : 'Minuman',
                      icon: currentCategory == 'semua menu'
                          ? Icons.menu_book
                          : currentCategory == 'makanan'
                              ? Icons.food_bank
                              : Icons.local_drink,
                    ),
                  );
                }),
                Expanded(
                  child: Obx(
                    () => SmartRefresher(
                      controller: ListController.to.refreshController,
                      enablePullDown: true,
                      onRefresh: ListController.to.onRefresh,
                      enablePullUp: ListController.to.canLoadMore.isTrue ? true : false,
                      onLoading: ListController.to.getListOfData,
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        itemBuilder: (context, index) {
                          final item = ListController.to.filteredList[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.5.h),
                            child: Slidable(
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          ListController.to.deleteItem(item);
                                        },
                                        borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(10.r),
                                        ),
                                        backgroundColor:
                                            const Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10.r),
                                    elevation: 2,
                                    child: MenuCard(
                                      menu: item,
                                      onTap: () {
                                        Get.toNamed(MainRoute.menu, arguments: item.idMenu);
                                      },
                                    ),
                                  ),
                                )
                          );
                        },
                        itemCount: ListController.to.filteredList.length,
                        itemExtent: 112.h,
                      ),
                    ),
                  ),
                ),
              ],
            )),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}
