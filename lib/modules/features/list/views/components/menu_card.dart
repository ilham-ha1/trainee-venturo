import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/list/controllers/list_controller.dart';
import 'package:trainee/modules/global_models/menu_response.dart';

class MenuCard extends StatelessWidget {
  final Menu menu;
  final bool isSelected;
  final void Function()? onTap;

  const MenuCard({
    Key? key,
    required this.menu,
    this.onTap,
    this.isSelected = false,
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
              height: 90.h,
              width: 90.w,
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
                    style: Get.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "Rp. ${menu.harga}",
                    style: Get.textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.edit_note),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Tambahkan Catatan',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

           Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      ListController.to.minMoreQuantity();
                    },
                    icon: const Icon(Icons.indeterminate_check_box_outlined),
                  ),
                ),
                Text(ListController.to.qty.value.toString()),
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      ListController.to.addMoreQuantity();
                    },
                    icon: const Icon(Icons.add_box_outlined),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
