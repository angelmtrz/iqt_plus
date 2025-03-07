import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CardPublicidad extends StatefulWidget {
  final Color bgColor;
  final String title;
  final String body;
  final String btnText;
  final String btnUrl;

  const CardPublicidad({
    super.key,
    required this.bgColor,
    required this.title,
    required this.body,
    required this.btnText,
    required this.btnUrl,
  });

  @override
  State<CardPublicidad> createState() => _CardPublicidadState();
}

class _CardPublicidadState extends State<CardPublicidad> {
  late Uri _url;

  Future<void> _launchUrl() async {
    _url = Uri.parse(widget.btnUrl);
    if (!await launchUrl(_url)) {
      throw Exception('No se pudo abrir: $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        color: widget.bgColor,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                widget.body,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: _launchUrl,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.yellow),
                  foregroundColor: WidgetStateProperty.all(Colors.black),
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: Text(widget.btnText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
