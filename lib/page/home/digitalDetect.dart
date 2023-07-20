import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:learning_digital_ink_recognition/learning_digital_ink_recognition.dart';
import 'package:musicapp/page/home/home_controller.dart';
import 'package:musicapp/painter.dart';
import 'package:musicapp/util/MPColors.dart';
import 'package:provider/provider.dart';

class DigitalInkRecognitionPage extends StatefulWidget {
  @override
  _DigitalInkRecognitionPageState createState() => _DigitalInkRecognitionPageState();
}

class _DigitalInkRecognitionPageState extends State<DigitalInkRecognitionPage> {
  final HomeController homeController = Get.find<HomeController>();
  final String _model = 'en-US';

  DigitalInkRecognitionState get state => Provider.of(context, listen: false);
  late DigitalInkRecognition _recognition;

  double get _width => MediaQuery.of(context).size.width;
  double _height = 500;

  @override
  void initState() {
    _recognition = DigitalInkRecognition(model: _model);
    super.initState();
  }

  @override
  void dispose() {
    _recognition.dispose();
    super.dispose();
  }

  // need to call start() at the first time before painting the ink
  Future<void> _init() async {
    //print('Writing Area: ($_width, $_height)');
    await _recognition.start(writingArea: Size(_width, _height));
    // always check the availability of model before being used for recognition
    await _checkModel();
  }

  // reset the ink recognition
  Future<void> _reset() async {
    state.reset();
    homeController.searchController.text = '';
    await _recognition.start(writingArea: Size(_width, _height));
  }

  Future<void> _checkModel() async {
    bool isDownloaded = await DigitalInkModelManager.isDownloaded(_model);

    if (!isDownloaded) {
      await DigitalInkModelManager.download(_model);
    }
  }

  Future<void> _actionDown(Offset point) async {
    state.startWriting(point);
    await _recognition.actionDown(point);
  }

  Future<void> _actionMove(Offset point) async {
    state.writePoint(point);
    await _recognition.actionMove(point);
  }

  Future<void> _actionUp() async {
    state.stopWriting();
    await _recognition.actionUp();
  }

  Future<void> _startRecognition() async {
    if (state.isNotProcessing) {
      EasyLoading.show();
      state.startProcessing();
      // always check the availability of model before being used for recognition
      await _checkModel();
      state.data = await _recognition.process();
      EasyLoading.dismiss();
      state.stopProcessing();
      homeController.searchController.text = state.toCompleteString();
      homeController.isPainting.value = false;
      homeController.searchTrackByKeyword(homeController.searchController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Builder(
          builder: (_) {
            _init();

            return Expanded(
              flex: 3,
              child: GestureDetector(
                onScaleStart: (details) async => await _actionDown(details.localFocalPoint),
                onScaleUpdate: (details) async => await _actionMove(details.localFocalPoint),
                onScaleEnd: (details) async => await _actionUp(),
                child: Consumer<DigitalInkRecognitionState>(
                  builder: (_, state, __) => CustomPaint(
                    painter: DigitalInkPainter(writings: state.writings),
                    child: Container(
                      width: _width,
                      height: _height,
                      decoration: BoxDecoration(
                          // color: Colors.transparent,
                          border: Border.all(
                        color: mpAppButtonColor,
                      )),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: mpAppBackGroundColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: mpAppButtonColor,
            ),
          ),
          child: IconButton(
            icon: const Icon(Icons.check, color: mpAppButtonColor),
            onPressed: _startRecognition,
          ),
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: mpAppBackGroundColor,
            border: Border.all(
              color: mpAppButtonColor,
            ),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.replay_outlined, color: mpAppButtonColor),
            onPressed: _reset,
          ),
        ),
        // Center(
        //   child: Consumer<DigitalInkRecognitionState>(builder: (_, state, __) {
        //     if (state.isNotProcessing && state.isNotEmpty) {
        //       return Center(
        //         child: Container(
        //           padding: EdgeInsets.symmetric(horizontal: 18),
        //           child: Text(
        //             state.toCompleteString(),
        //             textAlign: TextAlign.center,
        //             style: TextStyle(
        //               fontSize: 18,
        //             ),
        //           ),
        //         ),
        //       );
        //     }

        //     if (state.isProcessing) {
        //       return Center(
        //         child: Container(
        //           width: 36,
        //           height: 36,
        //           color: Colors.transparent,
        //           child: CircularProgressIndicator(strokeWidth: 2),
        //         ),
        //       );
        //     }

        //     return Container();
        //   }),
        // ),
        Expanded(child: Container(), flex: 1),
      ],
    );
  }
}

class DigitalInkRecognitionState extends ChangeNotifier {
  List<List<Offset>> _writings = [];
  List<RecognitionCandidate> _data = [];
  bool isProcessing = false;

  List<List<Offset>> get writings => _writings;
  List<RecognitionCandidate> get data => _data;
  bool get isNotProcessing => !isProcessing;
  bool get isEmpty => _data.isEmpty;
  bool get isNotEmpty => _data.isNotEmpty;

  List<Offset> _writing = [];

  void reset() {
    _writings = [];
    notifyListeners();
  }

  void startWriting(Offset point) {
    _writing = [point];
    _writings.add(_writing);
    notifyListeners();
  }

  void writePoint(Offset point) {
    if (_writings.isNotEmpty) {
      _writings[_writings.length - 1].add(point);
      notifyListeners();
    }
  }

  void stopWriting() {
    _writing = [];
    notifyListeners();
  }

  void startProcessing() {
    isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    isProcessing = false;
    notifyListeners();
  }

  set data(List<RecognitionCandidate> data) {
    _data = data;
    notifyListeners();
  }

  @override
  String toString() {
    return isNotEmpty ? _data.first.text : '';
  }

  String toCompleteString() {
    String result = _data.map((c) => c.text).toList().first;
    return isNotEmpty ? result : "";
  }
}
