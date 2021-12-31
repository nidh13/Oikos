import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customBlueAppBar.dart';
import 'package:oikosmobile/core/Utils/customImputBien.dart';
import 'package:oikosmobile/features/Service/domain/entities/pack_model.dart';
import 'package:oikosmobile/features/Service/presentation/bloc/service_bloc.dart';
import 'package:oikosmobile/features/Service/presentation/bloc/service_event.dart';

class PickLocationDisplay extends StatefulWidget {
  final List<Pack> packs;
  final String token;

  const PickLocationDisplay({Key key, this.packs,this.token}) : super(key: key);
  @override
  _PickLocationDisplayState createState() => _PickLocationDisplayState();
}

class _PickLocationDisplayState extends State<PickLocationDisplay> {
  var markers =HashSet<Marker>();
  @override
  Widget build(BuildContext context) {
    List<Pack> packs=widget.packs;
    return Scaffold(
      body: Column(
        children: [
          CustomBlueAppBar(
            title: "Confirmer le lieu du photoshoot".toUpperCase(),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomInputBien(
                  text: "Préciser l'emplacement de Bien",
                  // initialValue: propLocation,
                  onChanged: (value){
                    //    propLocation = value;
                  },
                  hint: "10 rue AlbertMat - Virigneux 42140",
                  suffixIconConstraints: BoxConstraints(minHeight: 26, minWidth: 26),
                  textInputType: TextInputType.visiblePassword,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SvgPicture.asset("Assets/Images/Locs.svg",),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 400,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(48.866667, 2.333333),
                        zoom: 11.7,
                      ),
                      onMapCreated: (GoogleMapController googleMapController){
                        setState(() {
                          markers.add(
                            Marker(
                              markerId: MarkerId('1'),
                              position:LatLng(48.866667, 2.333333) ,
                              infoWindow: InfoWindow(title: "test",snippet: "this is test"),

                            ),
                          );
                        });
                      },
                      markers: markers,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 80,
            color: Color(0xFF5FAEE5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      dispatchInitialServiceEvent(widget.token);
                    },
                    child: Text(
                      'Annuler'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Multi',
                        height: 1.1,
                        letterSpacing: 0.77,
                      ),
                    )),
                TextButton(
                  onPressed: () {
                    dispatchGoToPickPackEvent(packs);
                  },
                  child: Text(
                    'Suivant'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Multi',
                      height: 1.1,
                      letterSpacing: 0.77,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  void dispatchGoToPickPackEvent(List<Pack>packs) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ServiceBloc>(context)
        .add(GoToPickPackEvent(packs: packs));
  }
  void dispatchInitialServiceEvent(String token) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ServiceBloc>(context)
        .add(InitialServiceEvent(token: token));
  }
}
