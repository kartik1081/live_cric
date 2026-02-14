import 'package:flutter/material.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/configs.dart';
import 'package:live_cric/utils/const.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class AddLinksController extends ChangeNotifier {
  bool _mounted = false;
  int matchId;
  bool _loading = true;
  bool _saveLoading = false;
  List<TextEditingController> _streamLinks = [];

  bool get loading => _loading;
  bool get saveLoading => _saveLoading;
  List<TextEditingController> get streamLinks => _streamLinks;

  AddLinksController(BuildContext context, {required this.matchId}) {
    _mounted = true;
    getStreamList(context);
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }

  void addNewTextField() {
    final x = List<TextEditingController>.from(_streamLinks);
    x.add(TextEditingController());
    _streamLinks = x;
    notify();
  }

  void getStreamList(BuildContext context, [bool load = false]) async {
    if (!await Common.checkNetwork(context)) return;

    if (load) {
      _loading = true;
      notify();
    }
    try {
      _streamLinks = await Configs.firestore
          .collection(streamLinksFc)
          .doc(matchId.toString())
          .get()
          .then(
            (value) async => ((value.data()?[urlsKey] ?? []) as List<dynamic>)
                .map((e) => TextEditingController(text: e))
                .toList(),
          );
    } catch (e) {
      nb.log("getStreamList: $e");
      if (context.mounted) {
        Common.showSnackbar(context, nb.errorMessage);
      }
    } finally {
      _loading = false;
      notify();
    }
  }

  void saveLinks(BuildContext context) async {
    if (!await Common.checkNetwork(context)) return;

    _saveLoading = true;
    notify();
    try {
      await Configs.firestore
          .collection(streamLinksFc)
          .doc(matchId.toString())
          .update({urlsKey: _streamLinks.map((e) => e.text).toList()});
    } catch (e) {
      nb.log("saveLinks: $e");
      if (context.mounted) {
        Common.showSnackbar(context, nb.errorMessage);
      }
    } finally {
      _saveLoading = false;
      notify();
    }
  }

  void notify() {
    if (_mounted) notifyListeners();
  }
}
