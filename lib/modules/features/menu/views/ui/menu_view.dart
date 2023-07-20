import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/menu/views/components/app_bar.dart';
import 'package:trainee/shared/styles/elevated_button_style.dart';
import 'package:trainee/modules/features/menu/controllers/menu_controller.dart';

class MenuView extends StatelessWidget {
  const MenuView({required this.idMenu, super.key});
  final int idMenu;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarMenu(),
      body: Obx(() {
        final detailMenu = MenuDetailController.to.detailMenu.value;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
                child: CachedNetworkImage(
                  imageUrl:
                      detailMenu.menu?.foto ?? 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
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
                    Row(
                      children: [
                        Text(detailMenu.menu?.nama ?? '',
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: MainColor.primary,
                            )),
                        const Expanded(child: SizedBox()),
                        Material(
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                                Icons.indeterminate_check_box_outlined),
                          ),
                        ),
                        const Text("1"),
                        Material(
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add_box_outlined),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                        detailMenu.menu?.deskripsi ?? '',
                        style: TextStyle(
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
                                const Text("Harga",
                                    style: TextStyle(
                                        fontSize: 16, color: MainColor.black)),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Text(
                                  'Rp. ${detailMenu.menu?.harga.toString() ?? ''}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: MainColor.primary,
                                  ),)
                              ],
                            ),
                          ),
                          const Divider(
                            color: MainColor.black,
                            height: 1.5,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.local_fire_department),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("Level",
                                    style: TextStyle(
                                        fontSize: 16, color: MainColor.black)),
                                Expanded(
                                  child: SizedBox(),
                                ),
                                Text(
                                  "1",
                                  style: TextStyle(
                                      fontSize: 18, color: MainColor.black),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: MainColor.grey,
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: MainColor.black,
                            height: 1.5,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.local_pizza_outlined),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("Toping",
                                    style: TextStyle(
                                        fontSize: 16, color: MainColor.black)),
                                Expanded(
                                  child: SizedBox(),
                                ),
                                Text("Mozarella",
                                    style: TextStyle(
                                        fontSize: 18, color: MainColor.black)),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: MainColor.grey,
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: MainColor.black,
                            height: 1.5,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.edit_note),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("Catatan",
                                    style: TextStyle(
                                        fontSize: 16, color: MainColor.black)),
                                Expanded(
                                  child: SizedBox(),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    "Lorem Ipsum sitdolor amet as asii",
                                    style: TextStyle(
                                        fontSize: 18, color: MainColor.black),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: MainColor.grey,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: EvelatedButtonStyle.mainRounded.copyWith(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          MainColor.primary,
                        ),
                      ),
                      child: Text("Tambahkan Ke Pesanan",
                          style: TextStyle(
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
