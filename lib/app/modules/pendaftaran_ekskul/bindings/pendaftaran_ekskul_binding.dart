import 'package:get/get.dart';

import '../controllers/pendaftaran_ekskul_controller.dart';

class PendaftaranEkskulBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendaftaranEkskulController>(
      () => PendaftaranEkskulController(),
    );
  }
}
