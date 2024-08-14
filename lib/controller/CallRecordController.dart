import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

/// this is not used in app
/// also this is incomplete code
class CallRecordController extends GetxController {
  late AudioRecorder record;
  bool isRecording = false;
  String audioPath = '';
  bool hasPermission = false;

  //initState
  @override
  void onInit() {
    super.onInit();
    record = AudioRecorder();
  }

  //on dispose
  @override
  void onClose() {
    record.dispose();
    super.onClose();
  }

  Future<void> startRec() async {
    try {
      if (!await Permission.storage.isGranted) {
        await Permission.storage.request();
      }

      var directory = await getApplicationDocumentsDirectory();
      print("directory: $directory");
      var path = directory.path + '/${DateTime.now()}.aac';
      update();
      print("path 01: $path");
      if (await record.hasPermission()) {
        await record.start(
            RecordConfig(
              encoder: AudioEncoder.aacLc,
            ),
            path: path);
        print("Recording started ");
        isRecording = true;
        update();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> stopRec() async {
    String? path = await record.stop();

    isRecording = false;
    // audioPath = path!;
    print("recording stopped");
    print('Audio path: $audioPath');
    update();
  }
}
