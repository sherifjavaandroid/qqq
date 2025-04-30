import 'package:easycut/core/localization/lang_ar.dart';
import 'package:easycut/core/localization/lang_de.dart';
import 'package:easycut/core/localization/lang_en.dart';
import 'package:get/get.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': langAr,
        'en': langEn,
        'de': langDe,
      };
}
