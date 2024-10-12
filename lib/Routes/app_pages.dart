import 'package:get/get.dart';

// LOGIN
import '../app/modules/home/views/login/login_page.dart';
import '../app/modules/home/views/login/lupa_password_page.dart';
import '../app/modules/home/views/login/sign_up_page.dart';
import '../app/modules/home/views/login/pilih_mode_page.dart';
import '../app/modules/home/views/login/pilih_toko_page.dart';
import '../app/modules/home/views/login/buat_toko_page.dart';
import '../app/modules/home/views/login/buka_undangan_page.dart';
import '../app/modules/home/views/login/terima_undangan_page.dart';
import '../app/modules/home/views/login/pilih_tempat_kerja_page.dart';

// HOMEPAGE
import '../app/modules/home/views/homepage/home_page.dart';

// KELOLA AKUN PEGAWAI
import '../app/modules/home/views/kelola_akun_pegawai/activity_pegawai_page.dart';
import '../app/modules/home/views/kelola_akun_pegawai/detail_karyawan_page.dart';
import '../app/modules/home/views/kelola_akun_pegawai/hapus_akun_page.dart';
import '../app/modules/home/views/kelola_akun_pegawai/kelola_akun_pegawai_page.dart';
import '../app/modules/home/views/kelola_akun_pegawai/tambah_pegawai_page.dart';

// OTHER
import '../app/modules/home/views/other/all_activity_page.dart';
import '../app/modules/home/views/other/mail_open_page.dart';
import '../app/modules/home/views/other/mail_page.dart';

// PROFILE
import '../app/modules/home/views/profile/activity_page.dart';
import '../app/modules/home/views/profile/change_password_page.dart';
import '../app/modules/home/views/profile/change_profile_page.dart';
import '../app/modules/home/views/profile/profile_page.dart';

// STORAGE
import '../app/modules/home/views/storage/edit_produk_page.dart';
import '../app/modules/home/views/storage/hapus_produk_page.dart';
import '../app/modules/home/views/storage/storage_page.dart';
import '../app/modules/home/views/storage/tambah_produk_page.dart';

// TRANSAKSI
import '../app/modules/home/views/transaksi/cek_pembelian_page.dart';
import '../app/modules/home/views/transaksi/konfirmasi_cash_page.dart';
import '../app/modules/home/views/transaksi/konfirmasi_debit_page.dart';
import '../app/modules/home/views/transaksi/memilih_pembayaran_page.dart';
import '../app/modules/home/views/transaksi/pembayaran_berhasil_page.dart';
import '../app/modules/home/views/transaksi/struk_page.dart';
import '../app/modules/home/views/transaksi/transaksi_page.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    // LOGIN
    GetPage(name: AppRoutes.login, page: () => LoginPage()),
    GetPage(name: AppRoutes.lupaPassword, page: () => const LupaPasswordPage()),
    GetPage(name: AppRoutes.signUp, page: () => SignUpPage()),
    GetPage(name: AppRoutes.pilihMode, page: () => const PilihModePage()),
    GetPage(name: AppRoutes.pilihToko, page: () => const PilihTokoPage()),
    GetPage(name: AppRoutes.buatToko, page: () => const BuatTokoPage()),
    GetPage(name: AppRoutes.bukaUndangan, page: () => const BukaUndanganPage()),
    GetPage(name: AppRoutes.terimaUndangan, page: () => const TerimaUndanganPage()),
    GetPage(name: AppRoutes.pilihTempatKerja, page: () => const PilihTempatKerjaPage()),

    // HOMEPAGE
    GetPage(name: AppRoutes.home, page: () => const HomePage()),

    // KELOLA AKUN PEGAWAI
    GetPage(name: AppRoutes.kelolaAkun, page: () => const KelolaAkunPegawaiPage()),
    GetPage(name: AppRoutes.tambahPegawai, page: () => const TambahPegawaiPage()),
    GetPage(name: AppRoutes.activityPegawai, page: () => const ActivityPegawaiPage()),
    GetPage(name: AppRoutes.detailKaryawan, page: () => const DetailKaryawanPage()),
    GetPage(name: AppRoutes.hapusAkun, page: () => const HapusAkunPage()),

    // OTHER
    GetPage(name: AppRoutes.allActivity, page: () => const AllActivityPage()),
    GetPage(name: AppRoutes.mailOpen, page: () => const MailOpenPage()),
    GetPage(name: AppRoutes.mail, page: () => const MailPage()),

    // PROFILE
    GetPage(name: AppRoutes.profile, page: () => const ProfilePage()),
    GetPage(name: AppRoutes.changeProfile, page: () => const ChangeProfilePage()),
    GetPage(name: AppRoutes.changePassword, page: () => const ChangePasswordPage()),
    GetPage(name: AppRoutes.activityProfile, page: () => const ActivityPage()),

    // STORAGE
    GetPage(name: AppRoutes.storage, page: () => const StoragePage()),
    GetPage(name: AppRoutes.editProduk, page: () => const EditProdukPage()),
    GetPage(name: AppRoutes.hapusProduk, page: () => const HapusProdukPage()),
    GetPage(name: AppRoutes.tambahProduk, page: () => const TambahProdukPage()),

    // TRANSAKSI
    GetPage(name: AppRoutes.cekPembelian, page: () => const CekPembelianPage()),
    GetPage(name: AppRoutes.konfirmasiCash, page: () => const KonfirmasiCashPage()),
    GetPage(name: AppRoutes.konfirmasiDebit, page: () => const KonfirmasiDebitPage()),
    GetPage(name: AppRoutes.memilihPembayaran, page: () => const MemilihPembayaranPage()),
    GetPage(name: AppRoutes.pembayaranBerhasil, page: () => const PembayaranBerhasilPage()),
    GetPage(name: AppRoutes.struk, page: () => const StrukPage()),
    GetPage(name: AppRoutes.transaksi, page: () => const TransaksiPage()),
  ];
}
