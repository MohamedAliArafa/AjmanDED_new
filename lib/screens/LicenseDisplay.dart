import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/colors/colors.dart';
import 'package:flutter_app/screens/EstablishmentHome.dart';
import 'package:flutter_fullpdfview/flutter_fullpdfview.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class LicenseDisplayPage extends StatefulWidget {
  final String path;

  LicenseDisplayPage({Key? key, required this.path}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _MyLicenseDisplayPageState createState() => _MyLicenseDisplayPageState();
}

class _MyLicenseDisplayPageState extends State<LicenseDisplayPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  int pages = 0;
  bool isReady = false;
  String errorMessage = '';
  GlobalKey pdfKey = GlobalKey();
  bool isActive = true;
  double scale = 1.0;
  double top = 200.0;
  late double initialLocalFocalPoint;

  @override
  void initState() {
    super.initState();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (orientation == Orientation.portrait) {
        final Completer<PDFViewController> _controller =
            Completer<PDFViewController>();
        return Scaffold(
          // appBar: AppBar(
          //   title: Text("Document"),
          //   actions: <Widget>[
          //     IconButton(
          //       icon: Icon(Icons.share),
          //       onPressed: () {},
          //     ),
          //   ],
          // ),
          body: Stack(
            children: <Widget>[
              Container(
                color: Colors.black,
                child: PDFView(
                    key: pdfKey,
                    filePath: widget.path,
                    fitEachPage: true,
                    fitPolicy: FitPolicy.BOTH,
                    dualPageMode: false,
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: true,
                    pageFling: true,
                    defaultPage: 0,
                    pageSnap: true,
                    backgroundColor: bgcolors.BLACK,
                    onRender: (_pages) {
                      print("OK RENDERED!!!!!");
                      setState(() {
                        pages = _pages;
                        isReady = true;
                      });
                    },
                    onError: (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                      print(error.toString());
                    },
                    onPageError: (page, error) {
                      setState(() {
                        errorMessage = '$page: ${error.toString()}';
                      });
                      print('$page: ${error.toString()}');
                    },
                    onViewCreated: (PDFViewController pdfViewController) {
                      _controller.complete(pdfViewController);
                    },
                    onPageChanged: (int page, int total) {
                      print('page change: $page/$total');
                    },
                    onZoomChanged: (double zoom) {
                      print("Zoom is now $zoom");
                    }),
              ),
              errorMessage.isEmpty
                  ? !isReady
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container()
                  : Center(child: Text(errorMessage))
            ],
          ),
          floatingActionButton: FutureBuilder<PDFViewController>(
            future: _controller.future,
            builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
              if (snapshot.hasData) {
                return FloatingActionButton.extended(
                  label: Text("Go to ${pages ~/ 2}"),
                  onPressed: () async {
                    print(await snapshot.data!.getZoom());
                    print(await snapshot.data!.getPageWidth(1));
                    print(await snapshot.data!.getPageHeight(1));
                    //await snapshot.data.setPage(pages ~/ 2);
                    await snapshot.data!.resetZoom(1);
                    await snapshot.data!.setZoom(3.0);
                    //print(await snapshot.data.getScreenWidth());
                  },
                );
              }

              return Container();
            },
          ),
        );
      } else {
        final Completer<PDFViewController> _controller =
            Completer<PDFViewController>();
        return PDFView(
          filePath: widget.path,
          fitEachPage: false,
          dualPageMode: true,
          displayAsBook: true,
          dualPageWithBreak: true,
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageFling: true,
          defaultPage: 0,
          pageSnap: true,
          backgroundColor: bgcolors.BLACK,
          onRender: (_pages) {
            print("OK RENDERED!!!!!");
            setState(() {
              pages = _pages;
              isReady = true;
            });
          },
          onError: (error) {
            setState(() {
              errorMessage = error.toString();
            });
            print(error.toString());
          },
          onPageError: (page, error) {
            setState(() {
              errorMessage = '$page: ${error.toString()}';
            });
            print('$page: ${error.toString()}');
          },
          onViewCreated: (PDFViewController pdfViewController) {
            _controller.complete(pdfViewController);
          },
          onPageChanged: (int page, int total) {
            print('page change: $page/$total');
          },
        );
      }
    });
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 350.0
        : 450.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: CustomColors.navy,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        // result = scanData;
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return EstablishmentHomePage(title: "User Home Page");
        }));
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
