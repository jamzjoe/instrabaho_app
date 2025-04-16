// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';

// class FaceDetectionScreen extends StatefulWidget {
//   const FaceDetectionScreen({super.key});

//   @override
//   _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
// }

// class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
//   File? _image;
//   Map<FaceContourType, FaceContour?> contours = {};
//   List<Rect> boundingBoxes = [];
//   final _picker = ImagePicker();
//   String _resultText = FaceDetector(
//           options: FaceDetectorOptions(
//               enableClassification: true,
//               enableTracking: true,
//               enableContours: true))
//       .toString();

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//       _detectFaces(_image!);
//     }
//   }

//   Future<void> _captureImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//       _detectFaces(_image!);
//     }
//   }

//   Future<void> _detectFaces(File image) async {
//     final faceDetector = FaceDetector(
//       options: FaceDetectorOptions(
//           minFaceSize: 0.1,
//           performanceMode: FaceDetectorMode.fast,
//           enableClassification: true,
//           enableTracking: true,
//           enableContours: true),
//     );

//     // crop image to landscape
//     image = await _cropImageToLandScape(image);

//     final inputImage = InputImage.fromFilePath(image.path);
//     final faces = await faceDetector.processImage(inputImage);

//     if (faces.isEmpty) {
//       setState(() {
//         _resultText = "No face detected.";
//       });
//     } else {
//       setState(() {
//         _resultText =
//             "${faces.length} face(s) detected.\n${faces.first.boundingBox} and ${faces.first.contours.values.map((e) => e?.points).toList()}";
//         contours = faces.first.contours;
//         boundingBoxes = faces.map((face) => face.boundingBox).toList();
//       });
//     }

//     faceDetector.close();
//   }

//   Future<File> _cropImageToLandScape(File image) async {
//     final decodedImage = img.decodeImage(image.readAsBytesSync());
//     if (decodedImage!.width > decodedImage.height) {
//       return image; // Landscape, no cropping needed.
//     }

// // Adjust cropping logic to center the image.
//     final cropHeight = decodedImage.height - decodedImage.width;
//     final croppedImage = img.copyCrop(
//       decodedImage,
//       x: 0,
//       y: cropHeight ~/ 2,
//       width: decodedImage.width,
//       height: decodedImage.width,
//     );

// // Save the cropped image.
//     final croppedFile =
//         File('${image.parent.path}/cropped_${image.uri.pathSegments.last}');
//     await croppedFile.writeAsBytes(img.encodeJpg(croppedImage));
//     return croppedFile;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Face Detection")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             if (_image != null)
//               Expanded(
//                 child: BoundingBoxOverlay(
//                   boundingBoxes: boundingBoxes,
//                   contours: contours,
//                   imagePath: _image!,
//                 ),
//               ),
//             // const SizedBox(height: 16),
//             // Text(_resultText),
//             // const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: const Text("Pick Image"),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _captureImage,
//               child: const Text("Capture Image"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// }

// class BoundingBoxOverlay extends StatelessWidget {
//   final List<Rect> boundingBoxes;
//   final Map<FaceContourType, FaceContour?> contours;
//   final File imagePath;

//   const BoundingBoxOverlay({
//     required this.boundingBoxes,
//     required this.contours,
//     required this.imagePath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return FutureBuilder<Size>(
//           future: _getImageSize(imagePath),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done &&
//                 snapshot.hasData) {
//               final imageSize = snapshot.data!;
//               final scaleX = constraints.maxWidth / imageSize.width;
//               final scaleY = constraints.maxHeight / imageSize.height;
//               final scale = scaleX < scaleY ? scaleX : scaleY;

//               return Stack(
//                 children: [
//                   // Image Display
//                   Image.file(
//                     width: imageSize.width * scale,
//                     height: imageSize.height * scale,
//                     imagePath,
//                     errorBuilder: (context, error, stackTrace) => Center(
//                       child: Text("Error loading image",
//                           style: TextStyle(color: Colors.red)),
//                     ),
//                   ),
//                   // Custom Paint for Overlays
//                   Positioned.fill(
//                     child: CustomPaint(
//                       painter: BoundingBoxPainter(
//                         boundingBoxes: boundingBoxes,
//                         contours: contours,
//                         originalImageSize: imageSize,
//                         scale: scale,
//                         scaleX: scaleX,
//                         scaleY: scaleY,
//                         displaySize: Size(
//                             imageSize.width * scale, imageSize.height * scale),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text(
//                   "Failed to load image size",
//                   style: TextStyle(color: Colors.red),
//                 ),
//               );
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         );
//       },
//     );
//   }

//   Future<Size> _getImageSize(File imageFile) async {
//     final decodedImage = await decodeImageFromList(imageFile.readAsBytesSync());
//     return Size(decodedImage.width.toDouble(), decodedImage.height.toDouble());
//   }
// }

// class BoundingBoxPainter extends CustomPainter {
//   final List<Rect> boundingBoxes;
//   final Map<FaceContourType, FaceContour?> contours;
//   final Size originalImageSize;
//   final Size displaySize;
//   final double scaleX;
//   final double scaleY;
//   final double scale;

//   BoundingBoxPainter(
//       {required this.boundingBoxes,
//       required this.contours,
//       required this.originalImageSize,
//       required this.displaySize,
//       required this.scaleX,
//       required this.scaleY,
//       required this.scale});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.red
//       ..strokeWidth = 3
//       ..style = PaintingStyle.stroke;

//     final offsetX = (size.width - originalImageSize.width * scale) / 2;
//     final offsetY = (size.height - originalImageSize.height * scale) / 2;

//     // Draw bounding boxes
//     for (var box in boundingBoxes) {
//       final scaledBox = Rect.fromLTRB(
//         offsetX + box.left * scale,
//         offsetY + box.top * scale,
//         offsetX + box.right * scale,
//         offsetY + box.bottom * scale,
//       );
//       canvas.drawRect(scaledBox, paint);
//     }

//     // Draw contours
//     for (var contour in contours.values) {
//       if (contour != null) {
//         final path = Path();
//         bool isFirstPoint = true;
//         for (var point in contour.points) {
//           final scaledPoint = Offset(
//             offsetX + point.x.toDouble() * scale,
//             offsetY + point.y.toDouble() * scale,
//           );
//           if (isFirstPoint) {
//             path.moveTo(scaledPoint.dx, scaledPoint.dy);
//             isFirstPoint = false;
//           } else {
//             path.lineTo(scaledPoint.dx, scaledPoint.dy);
//           }
//         }
//         path.close(); // Connect the last point to the first
//         canvas.drawPath(path, paint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
