class ReserveModel {
  String? id;
  String? userID;
  String? childId;
  String? clinicName;
  String? doctorName;
  String? date;
  String? time;
  String? mobile;

  ReserveModel(
      {
         this.id,
        this.userID,
      this.childId,
      this.clinicName,
      this.doctorName,
      this.date,
      this.time,
      this.mobile});

  ReserveModel.fromJson(Map<String, dynamic> json) {
    id= json['field_appointment_id'];
    userID = json['title'];
    childId = json['field_appointment_child_id'];
    clinicName = json['field_appointment_clinic_name_ar'];
    doctorName = json['field_appointment_physician_name'];
    date = json['field_appointment_date'];
    time = json['field_appointment_time'];
    mobile = json['field_appointment_mobile'];
  }
}
