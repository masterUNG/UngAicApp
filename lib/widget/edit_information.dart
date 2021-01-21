import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ungaicapp/models/usermodel.dart';
import 'package:ungaicapp/utility/mystyle.dart';

class EditInformation extends StatefulWidget {
  final UserModel userModel;
  EditInformation({Key key, this.userModel}) : super(key: key);
  @override
  _EditInformationState createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  UserModel model;
  double lat, lng;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.userModel;
    findLatLng();
  }

  Future<Null> findLatLng() async {
    LocationData locationData = await findLocationData();
    setState(() {
      lat = locationData.latitude;
      lng = locationData.longitude;
      print('lat = $lat, lng = $lng');
    });
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Information'),
      ),
      body: Center(
        child: Column(
          children: [
            buildName(),
            buildAddress(),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                // color: Colors.grey,
                child: lat == null
                    ? MyStyle().showProgress()
                    : GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(lat, lng),
                          zoom: 16,
                        ),
                        mapType: MapType.normal,
                        onMapCreated: (controller) {},
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildName() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Name :',
          border: OutlineInputBorder(),
        ),
        initialValue: model.name,
      ),
    );
  }

  Container buildAddress() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      width: 250,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Address :',
          border: OutlineInputBorder(),
        ),
        initialValue:
            model.address.isEmpty ? 'ข้อมูลที่ต้องเพิ่ม' : model.address,
      ),
    );
  }
}
