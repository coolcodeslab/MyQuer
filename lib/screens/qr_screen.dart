import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:my_qr_code/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

import 'dart:async';
import 'package:path_provider/path_provider.dart';

class QRScreen extends StatefulWidget {
  QRScreen({this.data});
  final String data;
  static const id = 'qr screen';

  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      await Share.file(
          widget.data, '${widget.data}.png', pngBytes, 'image/png');
    } catch (e) {
      print(e.toString());
    }
  }

  GlobalKey globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: _captureAndSharePng,
            child: Container(
              margin: EdgeInsets.only(right: 20),
              width: 40,
              color: Colors.white,
              child: Icon(
                Icons.share,
                color: kMainColor,
                size: 30,
              ),
            ),
          )
        ],
        iconTheme: IconThemeData(
          color: kMainColor,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Your QR code',
          style: TextStyle(
            color: kMainColor,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 20,
          right: 20,
        ),
        child: RepaintBoundary(
          key: globalKey,
          child: QrImage(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            data: widget.data,
          ),
        ),
      ),
    );
  }
}
