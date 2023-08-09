import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/checkout/controllers/checkout_controller.dart';
import 'package:trainee/modules/features/checkout/views/componenst/rounded_app_bar.dart';
import 'package:trainee/modules/features/edit_menu/controllers/edit_menu_controller.dart';
import 'package:trainee/modules/features/edit_menu/views/components/adding_note_edit.dart';
import 'package:trainee/modules/features/edit_menu/views/components/level_option_edit.dart';
import 'package:trainee/modules/features/edit_menu/views/components/topping_option_edit.dart';
import 'package:trainee/modules/global_models/cart.dart';
import 'package:trainee/shared/styles/elevated_button_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class EditMenuView extends StatelessWidget {
  const EditMenuView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Edit Menu Screen',
      screenClassOverride: 'Trainee',
    );
    return SafeArea(
        child: Scaffold(
            appBar: RoundedAppBar(title: 'Menu Edit'.tr),
            body: Obx(() {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 24),
                      child: CachedNetworkImage(
                        imageUrl: EditMenuController.to.cart.value.foto ??
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
                                  EditMenuController.to.cart.value.nama ?? '',
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
                                      EditMenuController.to.minMoreQuantity();
                                    },
                                    icon: const Icon(
                                        Icons.indeterminate_check_box_outlined),
                                  ),
                                ),
                                Text(
                                    EditMenuController.to.qty.value.toString()),
                                Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                    onPressed: () {
                                      EditMenuController.to.addMoreQuantity();
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
                          Text(EditMenuController.to.menu.value.deskripsi ?? '',
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        'Rp. ${NumberFormat('#,##0', 'id_ID').format(EditMenuController.to.totalPrice)}',
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
                                const LevelOptionEdit(),
                                const Divider(
                                  color: MainColor.black,
                                  height: 1.5,
                                ),
                                const ToppingOptionEdit(),
                                const Divider(
                                  color: MainColor.black,
                                  height: 1.5,
                                ),
                                const AddingNoteEdit(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
                ],
              );
            }),
            bottomNavigationBar: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 22.w,
              ),
              decoration: BoxDecoration(
                color: MainColor.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.r),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(111, 24, 24, 24),
                    blurRadius: 15,
                    spreadRadius: -1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () async {
                  if (EditMenuController.to.cart.value.harga != 0) {
                    Get.snackbar(
                        "Updating".tr, "Updating order on cart".tr);
                    await EditMenuController.to.saveToCart(
                      Cart(
                          id: EditMenuController.to.cart.value.id,
                          harga: EditMenuController.to.cart.value.harga,
                          level: EditMenuController
                                  .to.selectedLevel.value?.idDetail,
                          catatan: EditMenuController.to.catatan.value,
                          deskripsi: EditMenuController.to.cart.value.deskripsi,
                          foto: EditMenuController.to.cart.value.foto ??
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png",
                          topping: EditMenuController.to.selectedTopping
                              .map((topping) => topping?.idDetail ?? 0)
                              .toList(),
                          jumlah: EditMenuController.to.qty.value,
                          nama: EditMenuController.to.cart.value.nama,
                          kategori:
                              EditMenuController.to.cart.value.kategori,
                          toppingPrice: EditMenuController.to.selectedTopping
                              .map((topping) => topping?.harga ?? 0)
                              .toList(),
                          levelPrice: EditMenuController
                                  .to.selectedLevel.value?.harga),
                    );
                    CheckoutController.to.fetchData();
                  } else {
                    Get.snackbar("Please Wait".tr, "Getting menu data".tr);
                  }

                  Get.offAndToNamed(MainRoute.checkout);
                },
                style: EvelatedButtonStyle.mainRounded.copyWith(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    MainColor.primary,
                  ),
                ),
                child: Text("Save".tr,
                    style: GoogleFonts.montserrat(
                        fontSize: 16.sp, color: MainColor.white, fontWeight: FontWeight.bold)),
              ),
            )));
  }
}
