// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easycut/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/data/model/products_model.dart';
import 'package:easycut/data/model/salon_model.dart';
import 'package:easycut/linkapi.dart';

class ShowProductsSalonController extends GetxController {
  RxSet<int> selectedIndices = <int>{}.obs;
  final List<ProductModel>? productModel;
  ShowProductsSalonController({
    this.productModel,
  });
  toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      print(selectedIndices);
      selectedIndices.add(index);
      print(selectedIndices);
    }
    update();
  }
}

class ShowProductsSalon extends StatelessWidget {
  final List<ProductModel> products;
  ShowProductsSalon({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowProductsSalonController>(
      init: ShowProductsSalonController(),
      builder: (controller) {
        return LayoutBuilder(
          builder: (context, constr) {
            return Padding(
              padding: EdgeInsets.only(
                right: Dimensions.width20.w,
                left: Dimensions.width20.w,
                top: 5.h,
              ),
              child: SizedBox(
                height: 178.h,
                width: 221.w,
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(vertical: 0.0.h),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    bool isSelected =
                        controller.selectedIndices.contains(index);
                    return GestureDetector(
                      onTap: () => controller.toggleSelection(index),
                      child: Card(
                        color: isSelected
                            ? AppColor.selectedColor
                            : AppColor.unselectedservies,
                        child: Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 100.h,
                                width: 158.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.r),
                                  child: Image.network(
                                    "${AppLink.imageServices}${products[index].image}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              _buildProductInfo(products[index]),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildProductInfo(ProductModel product) {
    return Column(
      children: [
        SmallText(
          fontWeight: FontWeight.w700,
          maxline: 2,
          text: product.name!,
          size: 18.sp,
        ),
        SmallText(
          text: "${'Number:'.tr}: ${product.number}",
          size: Dimensions.font16.sp,
        ),
        SmallText(
          text: "${'Price:'.tr} ${product.price} \$",
          size: Dimensions.font16.sp,
        ),
      ],
    );
  }
}
