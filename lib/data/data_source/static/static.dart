import 'package:easycut/core/constant/image_asset.dart';
import 'package:easycut/data/model/onboarding_model.dart';
import 'package:get/get.dart';

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
    title: "View Products".tr,
    body: "Now you can buy products sold in the salon and add them to your bill"
        .tr,
    image: AppImageAsset.onboardingOne,
  ),
  OnBoardingModel(
    title: "Track invoice".tr,
    body:
        "You can see how much your haircut will cost. Also, if you want to buy a product"
            .tr,
    image: AppImageAsset.onboardingTwo,
  ),
  OnBoardingModel(
    title: "trackReceipt".tr,
    body:
        "Now you can book at any time. We also provide you with the nearest salons to you"
            .tr,
    image: AppImageAsset.onboardingThree,
  ),
  OnBoardingModel(
    title: "Easy Cut".tr,
    body: "Your start will be easier because we will save your time".tr,
    image: AppImageAsset.onboardingFour,
  ),
];
