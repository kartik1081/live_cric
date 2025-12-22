import 'package:countries_utils/countries.dart';
import 'package:flutter/material.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/routes.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class SelectCountryController extends ChangeNotifier {
  bool _mounted = false;
  List<String?> countries = [];
  String? _selectedCountry;

  String? get selectedCountry => _selectedCountry;

  SelectCountryController() {
    _mounted = true;
    final x = Countries.all().map((e) => e.name).toList();
    x.retainWhere((e) => e != null);
    countries = x;
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }

  void selectCountry(String countryName) {
    _selectedCountry = countryName;
    notify();
  }

  void saveCountry(BuildContext context) {
    if (_selectedCountry == null || _selectedCountry!.isEmpty) {
      Common.showSnackbar(context, "Please select your country.");
      return;
    }
    nb.setValue(selectedCountryKey, _selectedCountry);
    Navigator.pushNamedAndRemoveUntil(context, Routes.homeRt, (route) => false);
  }

  void notify() {
    if (_mounted) notifyListeners();
  }
}
