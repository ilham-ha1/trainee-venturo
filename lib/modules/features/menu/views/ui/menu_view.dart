import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/menu/views/components/adding_note.dart';
import 'package:trainee/modules/features/menu/views/components/app_bar.dart';
import 'package:trainee/modules/features/menu/views/components/level_option.dart';
import 'package:trainee/modules/features/menu/views/components/topping_option.dart';
import 'package:trainee/modules/global_models/cart.dart';
import 'package:trainee/shared/styles/elevated_button_style.dart';
import 'package:trainee/modules/features/menu/controllers/menu_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key, this.qty, this.catatan});
  final int? qty; // Nullable int
  final String? catatan; // Nullable String
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Detail Menu Screen',
      screenClassOverride: 'Trainee',
    );
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarMenu(),
      body: Obx(() {
        final detailMenu = MenuDetailController.to.menu.value;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
                child: CachedNetworkImage(
                  imageUrl: detailMenu.foto ??
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                  useOldImageOnUrlChange: true,
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 25.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(
                      () => Row(
                        children: [
                          Text(
                            detailMenu.nama ?? '',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: MainColor.primary,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Material(
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: () {
                                MenuDetailController.to.minMoreQuantity();
                              },
                              icon: const Icon(
                                  Icons.indeterminate_check_box_outlined),
                            ),
                          ),
                          Text(MenuDetailController.to.qty.value.toString()),
                          Material(
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: () {
                                MenuDetailController.to.addMoreQuantity();
                              },
                              icon: const Icon(Icons.add_box_rounded),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(detailMenu.deskripsi ?? '',
                        style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          color: MainColor.black,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        children: [
                          const Divider(
                            color: MainColor.black,
                            height: 1.5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.money),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text("Price".tr,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: MainColor.black)),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Text(
                                  'Rp. ${NumberFormat('#,##0', 'id_ID').format(MenuDetailController.to.totalPrice)}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: MainColor.primary,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            color: MainColor.black,
                            height: 1.5,
                          ),
                          const LevelOption(),
                          const Divider(
                            color: MainColor.black,
                            height: 1.5,
                          ),
                          const ToppingOption(),
                          const Divider(
                            color: MainColor.black,
                            height: 1.5,
                          ),
                          const AddingNote(),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (MenuDetailController.to.menu.value.harga != 0) {
                          await MenuDetailController.to.saveToCart(Cart(
                              id: MenuDetailController.to.menu.value.idMenu,
                              harga: MenuDetailController.to.menu.value.harga,
                              level: MenuDetailController
                                      .to.selectedLevel?.value.idDetail,
                              catatan: MenuDetailController.to.catatan.value,
                              deskripsi:
                                  MenuDetailController.to.menu.value.deskripsi,
                              foto: MenuDetailController.to.menu.value.foto ??
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png",
                              topping: MenuDetailController.to.selectedTopping?.map((topping) => topping.idDetail ?? 0).toList(),
                              jumlah: MenuDetailController.to.qty.value,
                              nama: MenuDetailController.to.menu.value.nama,
                              kategori: MenuDetailController
                                  .to.menu.value.kategori,
                              toppingPrice: MenuDetailController.to.selectedTopping?.map((topping) => topping.harga ?? 0).toList(),    
                              levelPrice: MenuDetailController.to.selectedLevel?.value.harga 
                                  ),);
                                  
                        } 
                        Get.offAndToNamed(MainRoute.checkout);
                      },
                      style: EvelatedButtonStyle.mainRounded.copyWith(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          MainColor.primary,
                        ),
                      ),
                      child: Text("Adding order".tr,
                          style: GoogleFonts.montserrat(
                              fontSize: 16.sp, color: MainColor.white)),
                    )
                  ],
                ),
              ),
            ))
          ],
        );
      }),
    
    ));
  }
}
