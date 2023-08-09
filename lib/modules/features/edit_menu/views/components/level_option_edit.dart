import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/edit_menu/controllers/edit_menu_controller.dart';
import 'package:trainee/modules/global_models/detail_menu_response.dart';

class LevelOptionEdit extends StatelessWidget {
  const LevelOptionEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataLevel = EditMenuController.to.level;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Obx(() => InkWell(
            onTap: dataLevel.isNotEmpty
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
                              blurRadius: 10,
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
                                "Choose Level".tr,
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
                                itemCount: EditMenuController.to.level.length,
                                itemBuilder: ((context, index) {
                                  final level =
                                      EditMenuController.to.level[index];
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
                                          if (editMenuController
                                                  .selectedLevel.value ==
                                              level) {
                                            // If they are the same, clear the selectedLevel by setting it to null
                                            editMenuController.selectedLevel.value = Level();

                                          } else {
                                            // If they are different, set the new level as the selectedLevel
                                            editMenuController
                                                .selectedLevel(level);
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
                                            color: level.idDetail ==
                                                    EditMenuController
                                                        .to
                                                        .selectedLevel
                                                        .value
                                                        ?.idDetail
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
                                                    level.keterangan!,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: level.idDetail ==
                                                              EditMenuController
                                                                  .to
                                                                  .selectedLevel
                                                                  .value
                                                                  ?.idDetail
                                                          ? MainColor.white
                                                          : MainColor.black,
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                  level.idDetail ==
                                                          EditMenuController
                                                              .to
                                                              .selectedLevel
                                                              .value
                                                              ?.idDetail
                                                      ? const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 2.0),
                                                          child: Icon(
                                                            Icons.check_rounded,
                                                            size: 12,
                                                            color:
                                                                MainColor.white,
                                                          ),
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
                      "Level",
                      "No Option Available".tr,
                      duration: const Duration(milliseconds: 1000),
                      backgroundColor: MainColor.white,
                      snackPosition: SnackPosition.TOP,
                    );
                  },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.local_fire_department),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Level",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: MainColor.black),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Obx(() => Text(
                      EditMenuController.to.selectedLevel.value?.keterangan ??
                          "Choose Level".tr,
                      style: GoogleFonts.montserrat(
                          fontSize: 14, color: MainColor.black),
                    )),
                const Icon(Icons.keyboard_arrow_right, color: MainColor.grey)
              ],
            ),
          )),
    );
  }
}
