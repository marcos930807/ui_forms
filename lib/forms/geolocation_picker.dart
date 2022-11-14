// import 'package:flutter/material.dart';
// import 'package:ikoko_app/core/errors/failures.dart';
// import 'package:ikoko_app/core/services/geolocation_service.dart';
// import 'package:ikoko_app/presentation/components/custom_loading.dart';
// import 'package:oktoast/oktoast.dart';

// import 'input_decoration.dart';

// typedef GeolocationMapInfo = Map<String, dynamic>;

// class GeolocationPicker extends StatefulWidget {
//   const GeolocationPicker({
//     super.key,
//     this.currentLocation,
//     required this.onLocationUpdate,
//     this.label,
//   });
//   final GeolocationMapInfo? currentLocation;
//   final ValueChanged<GeolocationMapInfo> onLocationUpdate;
//   final String? label;

//   @override
//   State<GeolocationPicker> createState() => _GeolocationPickerState();
// }

// class _GeolocationPickerState extends State<GeolocationPicker> {
//   bool isLoading = false;
//   Failure? failure;
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.zero,
//       elevation: 0,
//       child: Theme(
//         data: Theme.of(context).copyWith(useMaterial3: true),
//         child: InkWell(
//           onTap: () async {
//             setState(() {
//               isLoading = true;
//             });
//             final response = await GeolocationService.determinePosition();
//             setState(() {
//               isLoading = false;
//             });
//             response.fold(
//               (failure) {
//                 setState(() {
//                   failure = failure;
//                 });
//               },
//               (position) {
//                 widget.onLocationUpdate.call(position.toJson());
//               },
//             );
//           },
//           child: InputDecorator(
//             decoration: formCustomDecoration(context).copyWith(
//                 labelText: widget.label ??
//                     'Compartir ubicación (presione para actualizar)'),
//             child: isLoading
//                 ? const EndlessLoading()
//                 : failure != null
//                     ? Text(failure?.message ?? 'Error en solicitud')
//                     : Text(
//                         widget.currentLocation != null
//                             ? '${widget.currentLocation.toString()}'
//                             : 'Presione para compartir',
//                       ),
//           ),
//         ),
//       ),
//     );
//   }
// }
