import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  CameraScreen({
    Key key,
    this.cameras,
  }) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  Future<void> _initializeControllerFuture;
  CameraController _controller;
  int _selectedCameraIndex = -1;

  Future<void> initCamera(CameraDescription camera) async {
    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    if (_controller.value.hasError) {
      print('Camera Error ${_controller.value.errorDescription}');
    }

    _initializeControllerFuture = _controller.initialize();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _cameraToggle() async {
    setState(() {
      _selectedCameraIndex = _selectedCameraIndex > -1
          ? _selectedCameraIndex == 0
              ? 1
              : 0
          : 0;
    });

    await initCamera(widget.cameras[_selectedCameraIndex]);
  }

  @override
  void initState() {
    super.initState();

    _cameraToggle();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  CameraPreview(_controller),
                  Positioned(
                    left: 50.0,
                    bottom: 50.0,
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3.0,
                          color: Colors.white,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          customBorder: CircleBorder(),
                          onTap: () => print('gallery access'),
                          child: Icon(
                            Icons.photo_size_select_actual,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 50.0,
                    bottom: 50.0,
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3.0,
                          color: Colors.white,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          customBorder: CircleBorder(),
                          onTap: _cameraToggle,
                          child: Icon(
                            Icons.loop,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return Center(
              child: Text('Loading'),
            );
          },
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(
            bottom: 30.0,
          ),
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 3.0,
              color: Colors.white,
            ),
          ),
          child: FittedBox(
            child: InkWell(
              onLongPress: () => print('take video'),
              child: FloatingActionButton(
                onPressed: () => print('take photo'),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
