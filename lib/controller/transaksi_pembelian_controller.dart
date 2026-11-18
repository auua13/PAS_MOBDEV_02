import 'package:get/get.dart';
import 'package:pas_gasal_02/models/makanan_model.dart';

class TransaksiPembelianController extends GetxController {
  // Implementation for transaksi pembelian controller
  late String no;
  late String namaMakanan;
  late String hargaMakanan;
  late String deskripsiMakanan;
  late String imageMakanan;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final arguments = Get.arguments; // menangkap data dari tampilan sebelumnya
    no = arguments['no'];
    namaMakanan = arguments['namaMakanan'];
    hargaMakanan = arguments['hargaMakanan'];
    deskripsiMakanan = arguments['deskripsiMakanan'];
    imageMakanan = arguments['imageMakanan']; 
  }
}
