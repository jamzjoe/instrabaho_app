import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_back_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_text.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/work_status_bloc.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/work_status_event.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  bool isScanning = true;
  MobileScannerController controller = MobileScannerController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText.appBar(context, "Scan QR Code"),
        leading: CustomBackButton(),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: MobileScanner(
              controller: controller,
              onDetect: (capture) {
                if (isScanning) {
                  isScanning = false;
                  // Check if QR is already verified
                  if (!context.read<WorkStatusBloc>().state.isQRVerified) {
                    context.read<WorkStatusBloc>().add(ScanQRVerify());
                  }
                  Navigator.pop(context);
                }
              },
              overlay: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: C.orange600,
                        width: 10,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Position the QR code within the frame',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
