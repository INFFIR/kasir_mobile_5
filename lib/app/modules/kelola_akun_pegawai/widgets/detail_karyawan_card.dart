import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_mobile_5/app/modules/components/widgets/button_small.dart';
import '../controllers/detail_karyawan_controller.dart';

class DetailKaryawanCard extends StatelessWidget {
  final DetailKaryawanController controller;

  const DetailKaryawanCard({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Building DetailKaryawanCard with employeeId: ${controller.employeeId}');
    return Column(
      children: [
        const SizedBox(height: 75),
        ButtonSmall(
          icon: Icons.manage_accounts,
          label: 'AKTIVITAS AKUN',
          onPressed: () {
            print('Navigating to /ActivityPegawai');
            Get.toNamed('/ActivityPegawai', arguments: {
              'employeeId': controller.employeeId,
              'shopId': controller.shopId,
            });
          },
        ),
        const SizedBox(height: 10),
        ButtonSmall(
          icon: Icons.message,
          label: 'KIRIM PESAN',
          onPressed: () {
            print('KIRIM PESAN button pressed');
            // TODO: Implement Kirim Pesan functionality
          },
        ),
        const SizedBox(height: 10),
        ButtonSmall(
          icon: Icons.delete_outline,
          label: 'HAPUS KARYAWAN',
          onPressed: () {
            print('HAPUS KARYAWAN button pressed');
            controller.deleteEmployee(context);
          },
        ),
        const SizedBox(height: 300),
      ],
    );
  }
}
