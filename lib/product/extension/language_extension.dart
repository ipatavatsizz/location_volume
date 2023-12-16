import 'dart:ui';

import 'package:location_volume/product/enum/language_enums.dart';

extension IterableLanguageExtensions on Iterable<Languages> {
  List<Locale> toLocale() => map((e) => e.toLocale()).toList();
}
