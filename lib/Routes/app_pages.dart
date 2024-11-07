// lib/routes/app_pages.dart
import 'package:get/get.dart';
import 'package:kasir_mobile_5/app/modules/home/bindings/home_binding.dart';
import 'package:kasir_mobile_5/app/modules/login/bindings/login_binding.dart';
import 'package:kasir_mobile_5/app/modules/login/bindings/lupa_password_binding.dart';
import 'package:kasir_mobile_5/app/modules/login/bindings/sign_up_binding.dart';
import 'package:kasir_mobile_5/app/modules/profile/bindings/profile_binding.dart';
import 'package:kasir_mobile_5/app/modules/storage/bindings/storage_binding.dart';
import 'package:kasir_mobile_5/app/modules/storage/bindings/tambah_produk_binding.dart';
import 'package:kasir_mobile_5/app/modules/transaksi/bindings/transaksi_binding.dart';

// IMPORT SEMUA HALAMAN
// LOGIN
import '../app/modules/login/views/login_page.dart';
import '../app/modules/login/views/lupa_password_page.dart';
import '../app/modules/login/views/sign_up_page.dart';
import '../app/modules/landing_page/views/pilih_mode_page.dart';
import '../app/modules/landing_page/views/pilih_toko_page.dart';
import '../app/modules/landing_page/views/buat_toko_page.dart';
import '../app/modules/landing_page/views/buka_undangan_page.dart';
import '../app/modules/landing_page/views/terima_undangan_page.dart';
import '../app/modules/landing_page/views/pilih_tempat_kerja_page.dart';

// HOMEPAGE
import '../app/modules/home/views/home_page.dart';

// KELOLA AKUN PEGAWAI
import '../app/modules/kelola_akun_pegawai/views/activity_pegawai_page.dart';
import '../app/modules/kelola_akun_pegawai/views/detail_karyawan_page.dart';
import '../app/modules/kelola_akun_pegawai/views/hapus_akun_page.dart';
import '../app/modules/kelola_akun_pegawai/views/kelola_akun_pegawai_page.dart';
import '../app/modules/kelola_akun_pegawai/views/tambah_pegawai_page.dart';

// OTHER
import '../app/modules/others/views/all_activity_page.dart';
import '../app/modules/others/views/mail_open_page.dart';
import '../app/modules/others/views/mail_page.dart';

// PROFILE
import '../app/modules/profile/views/activity_page.dart';
import '../app/modules/profile/views/change_password_page.dart';
import '../app/modules/profile/views/change_profile_page.dart';
import '../app/modules/profile/views/profile_page.dart';

// STORAGE
import '../app/modules/storage/bindings/edit_produk_binding.dart';
import '../app/modules/storage/views/edit_produk_page.dart';
import '../app/modules/storage/views/hapus_produk_page.dart';
import '../app/modules/storage/views/storage_page.dart';
import '../app/modules/storage/views/tambah_produk_page.dart';

// TRANSAKSI
import '../app/modules/pembayaran/views/cek_pembelian_page.dart';
import '../app/modules/pembayaran/views/konfirmasi_cash_page.dart';
import '../app/modules/pembayaran/views/konfirmasi_debit_page.dart';
import '../app/modules/pembayaran/views/memilih_pembayaran_page.dart';
import '../app/modules/pembayaran/views/pembayaran_berhasil_page.dart';
import '../app/modules/pembayaran/views/struk_page.dart';
import '../app/modules/transaksi/views/transaksi_page.dart';

import 'app_routes.dart'; // Import file rute

class AppPages {
  static final List<GetPage> pages = [
    // LOGIN
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding()
    ),
    GetPage(
      name: AppRoutes.lupaPassword,
      page: () => LupaPasswordPage(),
      binding: LupaPasswordBinding()
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => SignUpPage(),
      binding: SignUpBinding()
    ),
    GetPage(
      name: AppRoutes.pilihMode,
      page: () => const PilihModePage(),
    ),
    GetPage(
      name: AppRoutes.pilihToko,
      page: () =>  const PilihTokoPage(),
    ),
    GetPage(
      name: AppRoutes.buatToko,
      page: () =>  const BuatTokoPage(),
    ),
    GetPage(
      name: AppRoutes.bukaUndangan,
      page: () => const BukaUndanganPage(),
    ),
    GetPage(
      name: AppRoutes.terimaUndangan,
      page: () => const TerimaUndanganPage(),
    ),
    GetPage(
      name: AppRoutes.pilihTempatKerja,
      page: () => const PilihTempatKerjaPage(),
    ),

    // HOMEPAGE
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding()
    ),

    // KELOLA AKUN PEGAWAI
    GetPage(
      name: AppRoutes.kelolaAkun,
      page: () => const KelolaAkunPegawaiPage(),
    ),
    GetPage(
      name: AppRoutes.tambahPegawai,
      page: () => const TambahPegawaiPage(),
    ),
    GetPage(
      name: AppRoutes.activityPegawai,
      page: () => const ActivityPegawaiPage(),
    ),
    GetPage(
      name: AppRoutes.detailKaryawan,
      page: () => const DetailKaryawanPage(),
    ),
    GetPage(
      name: AppRoutes.hapusAkun,
      page: () => const HapusAkunPage(),
    ),

    // OTHER
    GetPage(
      name: AppRoutes.allActivity,
      page: () => const AllActivityPage(),
    ),
    GetPage(
      name: AppRoutes.mailOpen,
      page: () => const MailOpenPage(),
    ),
    GetPage(
      name: AppRoutes.mail,
      page: () => const MailPage(),
    ),

    // PROFILE
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfilePage(),
      binding: ProfileBinding()
    ),
    GetPage(
      name: AppRoutes.changeProfile,
      page: () => const ChangeProfilePage(),
      binding: ProfileBinding()
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => const ChangePasswordPage(),
    ),
    GetPage(
      name: AppRoutes.activityProfile,
      page: () => const ActivityPage(),
    ),

    // STORAGE
    GetPage(
      name: AppRoutes.storage,
      page: () => const StoragePage(),
      binding: StorageBinding()
    ),
    GetPage(
      name: AppRoutes.editProduk,
      page: () => const EditProdukPage(),
      binding: EditProdukBinding(),
    ),
    GetPage(
      name: AppRoutes.hapusProduk,
      page: () => const HapusProdukPage(),
    ),
    GetPage(
      name: AppRoutes.tambahProduk,
      page: () => const TambahProdukPage(),
      binding: TambahProdukBinding(),
    ),

    // TRANSAKSI
    GetPage(
      name: AppRoutes.cekPembelian,
      page: () => const CekPembelianPage(),
    ),
    GetPage(
      name: AppRoutes.konfirmasiCash,
      page: () => const KonfirmasiCashPage(),
    ),
    GetPage(
      name: AppRoutes.konfirmasiDebit,
      page: () => const KonfirmasiDebitPage(),
    ),
    GetPage(
      name: AppRoutes.memilihPembayaran,
      page: () => const MemilihPembayaranPage(),
    ),
    GetPage(
      name: AppRoutes.pembayaranBerhasil,
      page: () => const PembayaranBerhasilPage(),
    ),
    GetPage(
      name: AppRoutes.struk,
      page: () => const StrukPage(),
    ),
    GetPage(
      name: AppRoutes.transaksi,
      page: () => const TransaksiPage(),
      binding: TransaksiBinding()
    ),
  ];
}
