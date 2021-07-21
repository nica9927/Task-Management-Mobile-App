
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MenuImageProfile extends StatefulWidget {
  final ValueChanged<ImageSource>? onSelectImageSource;
  final VoidCallback? onViewImage;
  final VoidCallback? cancelFunc;

  const MenuImageProfile({Key? key, @required this.onSelectImageSource, @required this.onViewImage, this.cancelFunc}) : super(key: key);

  @override
  _MenuImageProfileState createState() => _MenuImageProfileState();
}

class _MenuImageProfileState extends State<MenuImageProfile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(top: 8, bottom: 32, right: 16, left: 16),
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton.icon(
              onPressed: () {
                widget.onViewImage!();
                widget.cancelFunc!();
              },
              padding: EdgeInsets.all(8),
              label: Text('View Image Profile'),
              icon: Icon(Icons.visibility),
            ),
            FlatButton.icon(
              onPressed: () {
                widget.onSelectImageSource!(ImageSource.gallery);
                widget.cancelFunc!();
              },
              padding: EdgeInsets.all(8),
              label: Text('Upload from Photo'),
              icon: Icon(Icons.photo),
            ),
            FlatButton.icon(
              onPressed: () {
                widget.onSelectImageSource!(ImageSource.camera);
                widget.cancelFunc!();
              },
              padding: EdgeInsets.all(8),
              label: Text('Upload from Camera'),
              icon: Icon(Icons.camera_alt),
            ),
          ],
        ),
      ),
    );
  }
}
