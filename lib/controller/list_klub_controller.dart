import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pas_gasal_02/models/klub_model.dart'; 

class ListKlubController extends GetxController {

  RxList<Team> klubList = <Team>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProduk();
  }

  Future<void> fetchProduk() async {
    try {
      isLoading.value = true;

      final url = Uri.parse(
        "https://www.thesportsdb.com/api/v1/json/123/search_all_teams.php",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = premierLeagueModelFromJson(response.body);

        klubList.assignAll(data.teams);
      } else {
        Get.snackbar("Gagal", "Gagal memuat data klub dari server");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
      print("Error fetch klub: $e");
    } finally {
      isLoading.value = false;
    }
  }
}