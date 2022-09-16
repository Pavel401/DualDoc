import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../contoller/DialogProgressController.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ViewNews extends StatelessWidget {
  final newsUrl;

  ViewNews({Key? key, this.newsUrl}) : super(key: key);

  DiaLogController diaLogController = Get.put(DiaLogController());
  void openDialog() {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: HexColor("#222222"),
        title: Obx(() => Row(
              children: [
                CircularProgressIndicator(
                  value: diaLogController.progressIndicator.value / 100,
                  //valueColor: AlwaysStoppedAnimation<Color>(theme.neoncolor),
                  color: Colors.white,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  diaLogController.progressIndicator.value == 100
                      ? "News Loaded"
                      : "Loading...",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ],
            )),
        content: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${diaLogController.progressIndicator.value}%",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ],
            )),
        actions: [
          Obx(() {
            return TextButton(
                child: diaLogController.progressIndicator.value == 100
                    ? const Text(
                        "Ok",
                        //  style: GoogleFonts.poppins(color: Colors),
                      )
                    : const Text(
                        "Wait",
                        // style: GoogleFonts.poppins(color: theme.neoncolor),
                      ),
                onPressed: () {
                  diaLogController.progressIndicator.value == 100
                      ? Get.back()
                      : Get.snackbar(
                          "Please wait ",
                          "News is loading",
                          icon: Icon(Icons.error, color: Colors.white),
                          snackPosition: SnackPosition.BOTTOM,
                        );
                });
          })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("News")),
      body: Container(
          child: WebView(
              onPageStarted: (url) {
                openDialog();
              },
              onProgress: (progress) {
                //  print(progress);

                diaLogController.progressIndicator.value = progress;
              },
              onWebResourceError: (error) {
                Container(
                  child: Center(
                    child: Text("Error While Loading!"),
                  ),
                );
              },
              initialUrl: newsUrl,
              javascriptMode: JavascriptMode.unrestricted)),
    );
  }
}
