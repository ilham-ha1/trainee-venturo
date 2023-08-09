import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/shared/customs/text_form_field_custom.dart';

class MenuCard extends StatelessWidget {
  final dynamic menu;
  final bool isSelected;
  final void Function()? onTap;
  final RxInt qty; // Add qty as a parameter
  final RxString catatan; // Add catatan as a parameter
  final void Function() add;
  final void Function() min;
  final TextEditingController catatanDetailTextController;

  const MenuCard({
    Key? key,
    required this.menu,
    this.onTap,
    this.isSelected = false,
    required this.qty,
    required this.catatan,
    required this.add,
    required this.min,
    required this.catatanDetailTextController,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        padding: EdgeInsets.all(7.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            width: 2.w,
          ),
        ),
        child: Row(
          children: [
            // menu image
            Container(
              height: 80.h,
              width: 80.w,
              margin: EdgeInsets.only(right: 12.r),
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.grey[100],
              ),
              child: CachedNetworkImage(
                imageUrl: menu.foto ??
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                useOldImageOnUrlChange: true,
                fit: BoxFit.contain,
                errorWidget: ((context, url, error) => Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                      fit: BoxFit.contain,
                    )),
              ),
            ),

            // menu info
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                     menu.nama ?? '',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "Rp. ${NumberFormat('#,##0', 'id_ID').format(menu.harga)}",
                    style: Get.textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                    color: MainColor.black)),
                            Row(
                              children: [
                                Expanded(
                                    child: TextFormFieldCustoms(
                                        controller: catatanDetailTextController,
                                        label: "",
                                        keyboardType: TextInputType.text,
                                        initialValue: catatan.value,
                                        hint: "Catatan")),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    catatan.value = catatanDetailTextController.text;
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
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.edit_note),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              catatan.toString() != ''
                                  ? catatan.toString()
                                  : "Add Note".tr,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Obx(
              () => Row(
                children: [
                  if (qty.value != 0)
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () {
                          min();
                        },
                        icon:
                            const Icon(Icons.indeterminate_check_box_outlined),
                      ),
                    ),
                  if (qty.value != 0) Obx(() => Text(qty.value.toString())),
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                        add();
                      },
                      icon: const Icon(Icons.add_box_rounded),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
