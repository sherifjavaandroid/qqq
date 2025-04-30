import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get/get.dart';

class QRCodeHelper {
  static const String baseUrl = "https://easycuteg.com/salon/";

  /// Creates a salon share URL
  static String createSalonUrl(int salonId) {
    return '$baseUrl$salonId';
  }

  /// Generates a QR code widget for the given salon ID
  static Widget generateQRCode(int salonId, {double size = 200.0}) {
    final String url = createSalonUrl(salonId);

    // Wrap the QR code in a SizedBox with fixed dimensions
    return SizedBox(
      width: size,
      height: size,
      child: QrImageView(
        data: url,
        version: QrVersions.auto,
        size: size,
        backgroundColor: Colors.white,
        gapless: false,
        errorStateBuilder: (context, error) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Text(
                'Something went wrong!'.tr,
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }

  /// Shares the salon link to social media and other apps
  static void shareSalon(BuildContext context, int salonId, String salonName) {
    final String url = createSalonUrl(salonId);
    final String shareText = 'Check out $salonName on EasyCut!\n$url'.tr;

    Share.share(
      shareText,
      subject: 'EasyCut - $salonName'.tr,
    );
  }

  /// Shows a QR code dialog
  static Future<void> showQRCodeDialog(BuildContext context, int salonId, String salonName) async {
    // Creating the URL to display as text under the QR code
    final String url = createSalonUrl(salonId);

    // Use a fixed size for the dialog content
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // Use Material instead of AlertDialog directly
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$salonName QR Code'.tr,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // QR Code in a Container with fixed size
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.white,
                    child: QrImageView(
                      data: url,
                      version: QrVersions.auto,
                      size: 200,
                      backgroundColor: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Scan this code to view salon details'.tr,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 10),

                  // Display the URL
                  Text(
                    url,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Close'.tr),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          shareSalon(context, salonId, salonName);
                        },
                        child: Text('Share'.tr),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}