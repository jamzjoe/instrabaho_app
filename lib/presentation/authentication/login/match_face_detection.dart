// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';

// class MatchFaceDetection extends StatefulWidget {
//   const MatchFaceDetection({super.key});

//   @override
//   _MatchFaceDetectionState createState() => _MatchFaceDetectionState();
// }

// class _MatchFaceDetectionState extends State<MatchFaceDetection> {
//   File? _image1;
//   File? _image2;
//   final ImagePicker _picker = ImagePicker();
//   double _matchPercentage = 0.0;
//   String _resultText = "";
//   Map<FaceContourType, FaceContour?> contours = {};
//   List<Face> facesResult = [];

//   Future<void> _pickImage(int imageNumber) async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         if (imageNumber == 1) {
//           _image1 = File(pickedFile.path);
//         } else {
//           _image2 = File(pickedFile.path);
//         }
//       });
//     }
//   }

//   Future<void> _captureImage(int imageNumber) async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       setState(() {
//         if (imageNumber == 1) {
//           _image1 = File(pickedFile.path);
//         } else {
//           _image2 = File(pickedFile.path);
//         }
//       });
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
//         facesResult = faces;
//       });
//     }

//     faceDetector.close();
//   }

//   Future<File> _cropImageToLandScape(File image) async {
//     final decodedImage = img.decodeImage(image.readAsBytesSync());
//     if (decodedImage!.width > decodedImage.height) {
//       return image; // Landscape, no cropping needed.
//     }

//     // Adjust cropping logic to center the image.
//     final cropHeight = decodedImage.height - decodedImage.width;
//     final croppedImage = img.copyCrop(
//       decodedImage,
//       x: 0,
//       y: cropHeight ~/ 2,
//       width: decodedImage.width,
//       height: decodedImage.width,
//     );

//     // Save the cropped image.
//     final croppedFile =
//         File('${image.parent.path}/cropped_${image.uri.pathSegments.last}');
//     await croppedFile.writeAsBytes(img.encodeJpg(croppedImage));
//     return croppedFile;
//   }

//   Future<void> _matchFaces() async {
//     if (_image1 == null || _image2 == null) return;

//     await _detectFaces(_image1!);
//     final faces1 = facesResult.first;

//     await _detectFaces(_image2!);
//     final faces2 = facesResult.last;

//     setState(() {
//       _matchPercentage = calculateSimilarity(faces1, faces2);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Text("Image 1"),
//                       _image1 != null
//                           ? Image.file(_image1!)
//                           : Placeholder(fallbackHeight: 100),
//                       ElevatedButton(
//                         onPressed: () => _pickImage(1),
//                         child: Text("Import Image"),
//                       ),
//                       ElevatedButton(
//                         onPressed: () => _captureImage(1),
//                         child: Text("Capture Image"),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Text("Image 2"),
//                       _image2 != null
//                           ? Image.file(_image2!)
//                           : Placeholder(fallbackHeight: 100),
//                       ElevatedButton(
//                         onPressed: () => _pickImage(2),
//                         child: Text("Import Image"),
//                       ),
//                       ElevatedButton(
//                         onPressed: () => _captureImage(2),
//                         child: Text("Capture Image"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             ElevatedButton(
//               onPressed: _matchFaces,
//               child: Text("Match Face"),
//             ),
//             Text("Percentage: ${_matchPercentage.toStringAsFixed(2)}%"),
//             Text(_resultText),
//           ],
//         ),
//       ),
//     );
//   }

//   double calculateSimilarity(Face face1, Face face2) {
//     // Extract points (e.g., left eye)
//     final point1 = face1.landmarks[FaceLandmarkType.leftEye]?.position;
//     final point2 = face2.landmarks[FaceLandmarkType.leftEye]?.position;

//     if (point1 == null || point2 == null) return 0.0;

//     // Euclidean Distance
//     final distance = sqrt(
//       pow(point1.x - point2.x, 2) + pow(point1.y - point2.y, 2),
//     );

//     // Convert distance to similarity (0.0 to 1.0)
//     final similarity = 1 / (1 + distance);

//     // Convert to percentage (0% to 100%)
//     return similarity * 100;
//   }
// }
