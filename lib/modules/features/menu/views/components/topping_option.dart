import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/menu/controllers/menu_controller.dart';

class ToppingOption extends StatelessWidget {
  const ToppingOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataTopping = MenuDetailController.to.topping;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Obx(() => InkWell(
            onTap: dataTopping.isNotEmpty
                ? () {
                    Get.bottomSheet(
                      Container(
                        width: 1.sw,
                        height: 120,
                        padding: EdgeInsets.symmetric(
                          horizontal: 25.w,
                          vertical: 25.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30.r),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "Pilih topping",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  color: MainColor.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 1.sw,
                              height: 24,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: MenuDetailController.to.topping.length,
                                itemBuilder: ((context, index) {
                                  final topping =
                                      MenuDetailController.to.topping[index];
                                  return Material(
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          MenuDetailController.to
                                              .selectedTopping(topping);
                                          Get.back(); // Close the bottom sheet
                                        },
                                        borderRadius: BorderRadius.circular(25.r),
                                        child: Ink(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.r),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: MainColor.primary,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(30.r),
                                            color: MenuDetailController.to
                                                            .selectedTopping.value?.idDetail ==
                                                        topping.idDetail
                                                ? MainColor.primary
                                                : MainColor.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    topping.keterangan!,
                                                    style: GoogleFonts.montserrat(
                                                      color: MenuDetailController
                                                                      .to
                                                                      .selectedTopping.value?.idDetail ==
                                                                  topping.idDetail
                                                          ? MainColor.white
                                                          : MainColor.black,
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                  MenuDetailController
                                                                  .to
                                                                  .selectedTopping.value?.idDetail ==
                                                            topping.idDetail
                                                      ? const Icon(
                                                          Icons.check_rounded,
                                                          size: 14,
                                                          color: MainColor.white,
                                                        )
                                                      : const SizedBox()
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                : () {
                    Get.snackbar(
                      "Topping",
                      "Tidak ada pilihan lain",
                      duration: const Duration(milliseconds: 1000),
                      backgroundColor: MainColor.white,
                      snackPosition: SnackPosition.TOP,
                    );
                  },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.cake_rounded),
                const SizedBox(width: 10,),
                Text(
                  "Topping",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold, fontSize: 16, color: MainColor.black
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Obx(() => Text(
                  MenuDetailController.to.selectedTopping.value?.keterangan ?? "",
                  style: GoogleFonts.montserrat(
                    fontSize: 18, color: MainColor.black
                  ),
                )),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: MainColor.grey
                )
              ],
            ),
          )),
    );
  }
}
