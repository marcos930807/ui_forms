// import 'package:ikoko_app/presentation/components/forms/geolocation_picker.dart';
// import 'package:reactive_forms/reactive_forms.dart';

// class ReactiveGeolocationPicker
//     extends ReactiveFormField<GeolocationMapInfo, GeolocationMapInfo> {
//   ReactiveGeolocationPicker({
//     required String super.formControlName,
//     super.validationMessages,
//     String? label,
//   }) : super(
//           builder:
//               (ReactiveFormFieldState<GeolocationMapInfo, GeolocationMapInfo>
//                   field) {
//             return GeolocationPicker(
//               currentLocation: field.value,
//               onLocationUpdate: (value) => field.didChange(value),
//               label: label,
//             );
//           },
//         );
//   @override
//   ReactiveFormFieldState<GeolocationMapInfo, GeolocationMapInfo>
//       createState() =>
//           ReactiveFormFieldState<GeolocationMapInfo, GeolocationMapInfo>();
// }
