
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


///二维码扫描
class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isHttp = false;
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: GlobalKey(debugLabel: 'QR'),
            overlay: QrScannerOverlayShape(),
            onQRViewCreated: (qrViewController) {
              controller = qrViewController;
              qrViewController.scannedDataStream.listen((barcode) async {
                String code = barcode.code ?? '';
                if (code.isNotEmpty && !isHttp) {
                  isHttp = true;
                  qrViewController.pauseCamera();
                  Navigator.of(context).pop(code);
                }
              });
            },
            onPermissionSet: (qrViewController, isPermission) {
              if (!isPermission) {
                qrViewController.dispose();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('无法访问您的相机'),
                      content: const Text('开启相机权限，才可以使用相机进行二维码扫描，前往系统设置进行授权'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('取消'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            openAppSettings();
                          },
                          child: const Text(
                            '去设置',
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text('扫码',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
