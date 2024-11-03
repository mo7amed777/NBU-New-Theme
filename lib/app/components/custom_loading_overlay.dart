import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showLoadingOverlay({
  required Future<void> Function() asyncFunction, // Set minimum display time
}) async {
  await Get.showOverlay(
    asyncFunction: () async {
      // Start both the async function and timer
      await asyncFunction();
    },
    loadingWidget: Center(
      child: Image.asset(
        'assets/images/loading.gif',
        height: 100,
        width: 100,
      ),
    ),
  );
}
