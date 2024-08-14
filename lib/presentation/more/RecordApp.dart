import 'dart:developer';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/CallRecordController.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:phone_state_background/phone_state_background.dart';

CallRecordController callRecordController = Get.put(CallRecordController());

class RecordApp extends StatefulWidget {
  const RecordApp({Key? key}) : super(key: key);

  @override
  State<RecordApp> createState() => _RecordAppState();
}

class _RecordAppState extends State<RecordApp> with WidgetsBindingObserver {
  late AudioRecorder record;
  bool isRecording = false;
  String audioPath = '';
  bool hasPermission = false;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await _hasPermission();
    }
  }

  Future<void> _hasPermission() async {
    final permission = await PhoneStateBackground.checkPermission();
    if (mounted) {
      setState(() => hasPermission = permission);
    }
  }

  Future<void> _requestPermission() async {
    await PhoneStateBackground.requestPermissions();
  }

  Future<void> _stop() async {
    await PhoneStateBackground.stopPhoneStateBackground();
  }

  //
  // Future<void> _init() async {
  //   if (!hasPermission) {
  //     await _requestPermission();
  //   }
  //   // Initialize phone state background listener
  //   await PhoneStateBackground.initialize(phoneStateBackgroundCallbackHandler);
  //
  //   //call the number 8380009222
  //   makingPhoneCall("+918554931251");
  //
  //   // Check and request audio recording permission if needed
  //   if (await record.hasPermission()) {
  //     // Get the directory for storing recordings
  //     final appDocumentsDirectory = await getApplicationDocumentsDirectory();
  //     final recordingsPath = appDocumentsDirectory.path;
  //
  //     // Start recording to file
  //     await record.start(
  //       const RecordConfig(),
  //       path: '$recordingsPath/${DateTime.now()}.aac',
  //     );
  //   }
  // }
  Future<void> _init() async {
    if (!hasPermission) {
      await _requestPermission();
    }
    // Initialize recorder
    record = AudioRecorder();

    // Initialize phone state background listener
    await PhoneStateBackground.initialize(phoneStateBackgroundCallbackHandler);

    //call the number 8380009222
    makingPhoneCall("+918554931251");

    // Check and request audio recording permission if needed
    if (await record.hasPermission()) {
      // Get the directory for storing recordings
      final appDocumentsDirectory = await getApplicationDocumentsDirectory();
      final recordingsPath = appDocumentsDirectory.path;

      // Start recording to file
      await record.start(
        const RecordConfig(encoder: AudioEncoder.wav),
        path: '$recordingsPath/${DateTime.now()}.aac',
      );
    }
  }

  makingPhoneCall(number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _hasPermission();
    record = AudioRecorder();
    _init();
  }

  @override
  void dispose() {
    record.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> startRec() async {
    try {
      if (!await Permission.storage.isGranted) {
        await Permission.storage.request();
      }

      var directory = await getApplicationDocumentsDirectory();
      print("directory: $directory");
      var path = directory.path + '/${DateTime.now()}.aac';
      print("path 01: $path");
      if (await record.hasPermission()) {
        await record.start(
            RecordConfig(
              encoder: AudioEncoder.aacLc,
            ),
            path: path);
        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> stopRec() async {
    String? path = await record.stop();

    setState(() {
      isRecording = false;
      audioPath = path!;
      print('Audio path: $audioPath');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record'),
      ),
      body: Center(
        child: Column(
          children: [
            isRecording ? Text("Recording in progress") : Text("Not Recording"),

            ElevatedButton(
              onPressed: () {
                if (isRecording) {
                  stopRec();
                } else {
                  startRec();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  isRecording ? "Stop Recording" : "Start Recording",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),

            ///background call work starts here
            const SizedBox(
              height: 20,
            ),
            Divider(),
            Text("background call listeners"),
            Text(
              'Has Permission: $hasPermission',
              style: TextStyle(
                fontSize: 16,
                color: hasPermission ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 180,
              child: ElevatedButton(
                onPressed: () => _requestPermission(),
                child: const Text('Check Permission'),
                //change size of button
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.all(20), // foreground
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: 180,
                child: ElevatedButton(
                  onPressed: () => _init(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Background color
                  ),
                  child: const Text('Start Listener'),
                ),
              ),
            ),
            SizedBox(
              width: 180,
              child: ElevatedButton(
                onPressed: () => _stop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Background color
                ),
                child: const Text('Stop Listener'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Be sure to annotate @pragma('vm:entry-point') your callback function to avoid issues in release mode on Flutter >= 3.3.0
@pragma('vm:entry-point')

/// Defines a callback that will handle all background incoming events
Future<void> phoneStateBackgroundCallbackHandler(
  PhoneStateBackgroundEvent event,
  String number,
  int duration,
) async {
  AudioRecorder record = AudioRecorder();
  Future<void> startRec() async {
    try {
      if (!await Permission.storage.isGranted) {
        await Permission.storage.request();
      }

      var directory = await getApplicationDocumentsDirectory();
      print("directory: $directory");
      var path = directory.path + '/${DateTime.now()}.aac';
      print("path 01: $path");
      if (await record.hasPermission()) {
        await record.start(
            RecordConfig(
              encoder: AudioEncoder.aacLc,
            ),
            path: path);
        print("recording started");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> stopRec() async {
    String? path = await record.stop();
    if (path != null && path.isNotEmpty) {
      // Process the recorded file or perform additional tasks
      print('Audio path: $path');
    } else {
      // Handle the case where the recording stopped prematurely
      print('Recording stopped prematurely or encountered an error.');
    }
  }

  switch (event) {
    case PhoneStateBackgroundEvent.incomingstart:
      // start the recording using mic
      await startRec();
      log('Incoming call start, number: $number, duration: $duration s');
      break;
    case PhoneStateBackgroundEvent.incomingmissed:
      log('Incoming call missed, number: $number, duration: $duration s');
      break;
    case PhoneStateBackgroundEvent.incomingreceived:
      stopRec();
      log('Incoming call received, number: $number, duration: $duration s');
      break;
    case PhoneStateBackgroundEvent.incomingend:
      stopRec();
      log('Incoming call ended, number: $number, duration $duration s');
      break;
    case PhoneStateBackgroundEvent.outgoingstart:
      await startRec();
      log('Outgoing call start, number: $number, duration: $duration s');
      break;
    case PhoneStateBackgroundEvent.outgoingend:
      await stopRec();
      log('Outgoing call ended, number: $number, duration: $duration s');
      break;
  }
}
