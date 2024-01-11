import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ReadController extends GetxController {
  PdfViewerController pdfController = PdfViewerController();

  Rx<int> currentPage = 1.obs;

  void onPageChanged(int page) {
    currentPage.value = page;
  }

  void search() {
    pdfController.searchText("publiser");
  }
}
