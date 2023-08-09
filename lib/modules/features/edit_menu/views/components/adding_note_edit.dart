import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/edit_menu/controllers/edit_menu_controller.dart';
import 'package:trainee/shared/customs/text_form_field_custom.dart';

class AddingNoteEdit extends StatelessWidget {
  const AddingNoteEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: () => Get.bottomSheet(
            Container(
            width: double.infinity,
            height: 150.h,
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
                Text("Create Note".tr,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 18.sp, color: MainColor.black)),
                Row(
                  children: [
                    Expanded(
                        child: TextFormFieldCustoms(
                            controller: EditMenuController
                                .to.catatanDetailTextController,
                            label: "",
                            keyboardType: TextInputType.text,
                            initialValue: EditMenuController.to.catatan.value,
                            hint: "Note".tr)),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        EditMenuController.to.catatan.value = 
                          EditMenuController.to.catatanDetailTextController.text;
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(26, 26),
                        shape: const CircleBorder(),
                        backgroundColor: MainColor.primary,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 10,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Icon(Icons.edit_note),
          const SizedBox(
            width: 8,
          ),
          Text("Note".tr,
              style:
                  GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 16, color: MainColor.black)),
          const Expanded(
            child: SizedBox(),
          ),
          SizedBox(
            width: 150,
            child: Obx(
              () => Text(
                EditMenuController.to.catatan.value != '' ?  EditMenuController.to.catatan.value :'Tambahkan Catatan',
                style: GoogleFonts.montserrat(
                    fontSize: 14, color: MainColor.black),
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_right,
            color: MainColor.grey,
          ),
        ]),
      ),
    );
  }
}
