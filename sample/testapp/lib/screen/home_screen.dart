import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geojson/geojson.dart';
import 'package:geopoint/geopoint.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math' as math;


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final LatLng initLatLng = LatLng(
    37.5125,
    127.0719,
  );

  /// Data for the Flutter map polylines layer
  final polygons = <Polygon>[];

  Future<void> processData() async {
    final geojson = GeoJson();
    geojson.processedMultiPolygons.listen((GeoJsonMultiPolygon multiPolygon) {
      for (final polygon in multiPolygon.polygons) {
        final geoSerie = GeoSerie(
            type: GeoSerieType.polygon,
            name: polygon.geoSeries[0].name,
            geoPoints: <GeoPoint>[]);
        for (final serie in polygon.geoSeries) {
          if (serie.geoPoints != null) {
            geoSerie.geoPoints?.addAll(serie.geoPoints!);
          }
        }
        final color =
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
            .withOpacity(0.3);
        final poly = Polygon(
            points: geoSerie.toLatLng(ignoreErrors: true), color: color);
        setState(() => polygons.add(poly));
      }
    });
    geojson.endSignal.listen((bool _) => geojson.dispose());
    final data = await rootBundle.loadString('assets/SGG.json');
    // final data = await rootBundle.loadString('assets/countries.geojson');
    await geojson.parse(data, verbose: true);
  }

  @override
  void initState() {
    super.initState();
    processData();
  }


  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: MapController(),
      options: MapOptions(
        center: initLatLng,
        zoom: 12.0,
      ),
      // nonRotatedChildren: [
      //   AttributionWidget.defaultWidget(
      //     source: '© OpenStreetMap contributors',
      //     onSourceTapped: () {},
      //   ),
      // ],
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        PolygonLayer(
          polygons: polygons,
        ),
      ],
    );
  }
}
