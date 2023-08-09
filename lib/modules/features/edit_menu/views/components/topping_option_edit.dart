import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/edit_menu/controllers/edit_menu_controller.dart';

class ToppingOptionEdit extends StatelessWidget {
  const ToppingOptionEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataTopping = EditMenuController.to.topping;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Obx(() => InkWell(
            onTap: dataTopping.isNotEmpty
                ? () {
                    Get.bottomSheet(
                      Container(
                        width: 1.sw,
                        height: 160,
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
                                "Choose Topping".tr,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  color: MainColor.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 1.sw,
                              height: 60.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    EditMenuController.to.topping.length,
                                itemBuilder: ((context, index) {
                                  final topping =
                                      EditMenuController.to.topping[index];
                                  return Material(
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          final EditMenuController
                                              editMenuController =
                                              EditMenuController.to;
                                          // Check if the currently selected level is the same as the level being tapped

                                          // Check if the topping is already selected
                                          if (editMenuController
                                              .selectedTopping
                                              .contains(topping)) {
                                            // If it's selected, remove it from the list
                                            editMenuController.selectedTopping
                                                .remove(topping);
                                          } else {
                                            // If it's not selected, add it to the list
                                            editMenuController.selectedTopping
                                                .add(topping);
                                          }
                                          Get.back(); // Close the bottom sheet
                                        },
                                        borderRadius:
                                            BorderRadius.circular(25.r),
                                        child: Ink(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.r),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: MainColor.primary,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                            color: EditMenuController
                                                        .to.selectedTopping
                                                        .contains(topping) ==
                                                    true
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
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: EditMenuController
                                                                  .to
                                                                  .selectedTopping
                                                                  .contains(
                                                                      topping) ==
                                                              true
                                                          ? MainColor.white
                                                          : MainColor.black,
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                  EditMenuController.to
                                                              .selectedTopping
                                                              .contains(
                                                                  topping) ==
                                                          true
                                                      ? const Icon(
                                                          Icons.check_rounded,
                                                          size: 14,
                                                          color:
                                                              MainColor.white,
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
                      "No Option Available".tr,
                      duration: const Duration(milliseconds: 1000),
                      backgroundColor: MainColor.white,
                      snackPosition: SnackPosition.TOP,
                    );
                  },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.cake_rounded),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Topping",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: MainColor.black),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Obx(() => Text(
                      (EditMenuController.to.selectedTopping.isNotEmpty
                          ? EditMenuController.to.selectedTopping
                              .map((topping) => topping?.keterangan ?? '')
                              .join(', ')
                          : "Choose Topping".tr),
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: MainColor.black,
                      ),
                    )),
                const Icon(Icons.keyboard_arrow_right, color: MainColor.grey)
              ],
            ),
          )),
    );
  }
}
