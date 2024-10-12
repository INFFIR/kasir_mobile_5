import 'package:flutter/material.dart';

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
// import '../app/modules/home/views/homepage/homepage_pegawai_page.dart';

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

import 'app_routes.dart'; // Import file rute

class AppPages {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // LOGIN
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case AppRoutes.lupaPassword:
        return MaterialPageRoute(builder: (_) => LupaPasswordPage());
      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case AppRoutes.pilihMode:
        return MaterialPageRoute(builder: (_) => PilihModePage());
      case AppRoutes.pilihToko:
        return MaterialPageRoute(builder: (_) => PilihTokoPage());
      case AppRoutes.buatToko:
        return MaterialPageRoute(builder: (_) => BuatTokoPage());
      case AppRoutes.bukaUndangan:
        return MaterialPageRoute(builder: (_) => BukaUndanganPage());
      case AppRoutes.terimaUndangan:
        return MaterialPageRoute(builder: (_) => TerimaUndanganPage());
      case AppRoutes.pilihTempatKerja:
        return MaterialPageRoute(builder: (_) => PilihTempatKerjaPage());

      // HOMEPAGE
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => HomePage());
      // case AppRoutes.homepagePegawai:
      //   return MaterialPageRoute(builder: (_) => HomepagePegawaiPage());

      // KELOLA AKUN PEGAWAI
      case AppRoutes.kelolaAkun:
        return MaterialPageRoute(builder: (_) => KelolaAkunPegawaiPage());
      case AppRoutes.tambahPegawai:
        return MaterialPageRoute(builder: (_) => TambahPegawaiPage());
      case AppRoutes.activityPegawai:
        return MaterialPageRoute(builder: (_) => ActivityPegawaiPage());
      case AppRoutes.detailKaryawan:
        return MaterialPageRoute(builder: (_) => DetailKaryawanPage());
      case AppRoutes.hapusAkun:
        return MaterialPageRoute(builder: (_) => HapusAkunPage());

      // OTHER
      case AppRoutes.allActivity:
        return MaterialPageRoute(builder: (_) => AllActivityPage());
      case AppRoutes.mailOpen:
        return MaterialPageRoute(builder: (_) => MailOpenPage());
      case AppRoutes.mail:
        return MaterialPageRoute(builder: (_) => MailPage());

      // PROFILE
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case AppRoutes.changeProfile:
        return MaterialPageRoute(builder: (_) => ChangeProfilePage());
      case AppRoutes.changePassword:
        return MaterialPageRoute(builder: (_) => ChangePasswordPage());
      case AppRoutes.activityProfile:
        return MaterialPageRoute(builder: (_) => ActivityPage());

      // STORAGE
      case AppRoutes.storage:
        return MaterialPageRoute(builder: (_) => StoragePage());
      case AppRoutes.editProduk:
        return MaterialPageRoute(builder: (_) => EditProdukPage());
      case AppRoutes.hapusProduk:
        return MaterialPageRoute(builder: (_) => HapusProdukPage());
      case AppRoutes.tambahProduk:
        return MaterialPageRoute(builder: (_) => TambahProdukPage());

      // TRANSAKSI
      case AppRoutes.cekPembelian:
        return MaterialPageRoute(builder: (_) => CekPembelianPage());
      case AppRoutes.konfirmasiCash:
        return MaterialPageRoute(builder: (_) => KonfirmasiCashPage());
      case AppRoutes.konfirmasiDebit:
        return MaterialPageRoute(builder: (_) => KonfirmasiDebitPage());
      case AppRoutes.memilihPembayaran:
        return MaterialPageRoute(builder: (_) => MemilihPembayaranPage());
      case AppRoutes.pembayaranBerhasil:
        return MaterialPageRoute(builder: (_) => PembayaranBerhasilPage());
      case AppRoutes.struk:
        return MaterialPageRoute(builder: (_) => StrukPage());
      case AppRoutes.transaksi:
        return MaterialPageRoute(builder: (_) => TransaksiPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
