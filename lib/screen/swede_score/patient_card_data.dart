import 'package:flutter/material.dart';

class DetailPatientCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                    Expanded(
                      child: const Text(
                        'Aruhi Patel',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ),
                    const SizedBox(width: 15),
                    buildDetailRow('ID', '0128545'),
                  ]),
                  const SizedBox(height: 5),
                  Row(children: [
                    buildDetailRow('Sex', 'Female'),
                    const SizedBox(width: 15),
                    buildDetailRow('Acq. Date', '23/05/24'),
                  ]),
                  Row(children: [
                    buildDetailRow('Age', '28'),
                    const SizedBox(width: 15),
                    buildDetailRow('Acq. Time', '09:30:20 AM'),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String fieldName, String value) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$fieldName: ',
            style: const TextStyle(color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(
                fontWeight: FontWeight.w400, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}