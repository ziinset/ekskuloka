import 'package:get/get.dart';
import '../modules/akun/bindings/akun_binding.dart';
import '../modules/akun/views/akun_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/informasi/bindings/informasi_binding.dart';
import '../modules/informasi/views/informasi_view.dart';
import '../modules/jadwal/bindings/jadwal_binding.dart';
import '../modules/jadwal/views/jadwal_view.dart';
import '../modules/komunitas/bindings/komunitas_binding.dart';
import '../modules/komunitas/views/komunitas_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notifikasi/bindings/notifikasi_binding.dart';
import '../modules/notifikasi/views/notifikasi_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/pendaftaran_ekskul/bindings/pendaftaran_ekskul_binding.dart';
import '../modules/pendaftaran_ekskul/views/pendaftaran_ekskul_view.dart';
import '../modules/presensi/bindings/presensi_binding.dart';
import '../modules/presensi/views/presensi_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.JADWAL,
      page: () => const JadwalView(),
      binding: JadwalBinding(),
    ),
    GetPage(
      name: _Paths.PRESENSI,
      page: () => const PresensiView(),
      binding: PresensiBinding(),
    ),
    GetPage(
      name: _Paths.INFORMASI,
      page: () => const InformasiView(),
      binding: InformasiBinding(),
    ),
    GetPage(
      name: _Paths.PENDAFTARAN_EKSKUL,
      page: () => const PendaftaranEkskulView(),
      binding: PendaftaranEkskulBinding(),
    ),
    GetPage(
      name: _Paths.AKUN,
      page: () => const AkunView(),
      binding: AkunBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFIKASI,
      page: () => const NotificationView(),
      binding: NotifikasiBinding(),
    ),
    GetPage(
      name: _Paths.KOMUNITAS,
      page: () => const KomunitasView(),
      binding: KomunitasBinding(),
    ),
  ];
}
