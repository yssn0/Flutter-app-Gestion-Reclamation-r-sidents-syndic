import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ReactionPopup extends StatefulWidget {
  final int satisfactionLevel;
  final Function(String?) onSubmit;

  ReactionPopup({required this.satisfactionLevel, required this.onSubmit});

  @override
  _ReactionPopupState createState() => _ReactionPopupState();
}

class _ReactionPopupState extends State<ReactionPopup> {
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Votre réaction'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _commentController,
            decoration: InputDecoration(hintText: 'Commentaire (optionnel)'),
          ),
          SizedBox(height: 20),
          _isSubmitting
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isSubmitting = true;
                    });
                    widget.onSubmit(_commentController.text);
                  },
                  child: Text('Envoyer'),
                ),
        ],
      ),
    );
  }
}