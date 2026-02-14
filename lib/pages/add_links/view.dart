import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/pages/add_links/controller.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:nb_utils/nb_utils.dart' hide black;
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';

class AddLinksView extends StatelessWidget {
  const AddLinksView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AddLinksController>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30.h),
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: soft,
                  size: 23.w,
                ),
              ),
              SizedBox(width: 7.w),
              Text(
                "Add Links",
                style: Common.textStyle(isSpl: true, size: 22.sp),
              ).expand(),
              Selector<AddLinksController, bool>(
                selector: (p0, p1) => p1.saveLoading,
                builder: (context, saveLoading, child) => saveLoading
                    ? CircularProgressIndicator(strokeWidth: 3)
                          .withSize(width: 23.w, height: 23.h)
                          .paddingOnly(right: 25.w)
                    : IconButton(
                        onPressed: () => controller.saveLinks(context),
                        icon: Icon(Icons.check, color: soft),
                      ).paddingOnly(right: 16.w),
              ),
            ],
          ),
          SizedBox(height: 7.h),
          Selector<AddLinksController, List<TextEditingController>>(
            selector: (p0, p1) => p1.streamLinks,
            builder: (context, streamLinks, child) => ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              itemCount: streamLinks.length + 1,
              itemBuilder: (context, index) => streamLinks.length == index
                  ? Container(
                      width: 402.w,
                      height: 45.h,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 22.h),
                      decoration: BoxDecoration(
                        color: primary50,
                        borderRadius: nb.radius(12.r),
                      ),
                      child: Text(
                        "Add",
                        style: Common.textStyle(
                          color: black,
                          weight: FontWeight.bold,
                          size: 18.sp,
                        ),
                      ),
                    ).onTap(() => controller.addNewTextField())
                  : nb.AppTextField(
                      textFieldType: nb.TextFieldType.URL,
                      controller: streamLinks[index],
                      textStyle: Common.textStyle(weight: FontWeight.bold),
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async => await Clipboard.setData(
                              ClipboardData(text: streamLinks[index].text),
                            ),
                            icon: Icon(Icons.copy, color: text),
                          ),
                          IconButton(
                            onPressed: () async =>
                                await Clipboard.getData('text/plain').then(
                                  (value) => streamLinks[index].text =
                                      value?.text ?? "",
                                ),
                            icon: Icon(Icons.paste, color: text),
                          ),
                        ],
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        fillColor: popUp,
                        filled: true,
                        hintText: "URL",
                        hintStyle: Common.textStyle(color: text),
                        border: InputBorder.none,
                      ),
                    ),
              separatorBuilder: (context, index) => SizedBox(height: 13.h),
            ),
          ).expand(),
        ],
      ),
    );
  }
}
