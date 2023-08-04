import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDeviceListEntry extends StatelessWidget {
  const BluetoothDeviceListEntry({Key? key, required this.onTap, required this.device}) : super(key: key);

  final VoidCallback onTap;
  final BluetoothDevice? device;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: const Icon(Icons.bluetooth),
      title: Text(device!.name ?? "Bluetooth Device"),
      subtitle: Text(device!.address.toString()),
    );
  }
}

class BluetoothDeviceListScreen extends StatefulWidget {
  final List<BluetoothDevice> devices;

  BluetoothDeviceListScreen({required this.devices});

  @override
  _BluetoothDeviceListScreenState createState() => _BluetoothDeviceListScreenState();
}

class _BluetoothDeviceListScreenState extends State<BluetoothDeviceListScreen> {
  BluetoothDevice? _selectedDevice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
      ),
      body: ListView.builder(
        itemCount: widget.devices.length,
        itemBuilder: (context, index) {
          return BluetoothDeviceListEntry(
            device: widget.devices[index],
            onTap: () {
              setState(() {
                _selectedDevice = widget.devices[index];
              });
            },
          );
        },
      ),
    );
  }
}
