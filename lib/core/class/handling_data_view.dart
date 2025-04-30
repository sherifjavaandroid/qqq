import 'package:easycut/core/class/status_request.dart';

import 'package:easycut/core/constant/image_asset.dart';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView({
    super.key,
    required this.statusRequest,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(child: Lottie.asset(AppImageAsset.lottie1))
        : statusRequest == StatusRequest.offlineFailure
            ? Center(child: Lottie.asset(AppImageAsset.lottie2))
            : statusRequest == StatusRequest.serverFailure
                ? Center(child: Lottie.asset(AppImageAsset.lottie6))
                : statusRequest == StatusRequest.failure
                    ? Center(child: Lottie.asset(AppImageAsset.lottie6))
                    : widget;
  }
}

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataRequest({
    super.key,
    required this.statusRequest,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(child: Lottie.asset(AppImageAsset.lottie1))
        : statusRequest == StatusRequest.offlineFailure
            ? Center(child: Lottie.asset(AppImageAsset.lottie2))
            : statusRequest == StatusRequest.serverFailure
                ? Center(child: Lottie.asset(AppImageAsset.lottie3))
                : widget;
  }
}
