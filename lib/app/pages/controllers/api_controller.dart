import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:get/get.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/app/services/base_client.dart';

class APIController extends GetxController {
  final String url;
  final RequestType requestType;
  final body;
  final headers;
  APIController(
      {required this.url,
      this.requestType = RequestType.get,
      this.body,
      this.headers});
  dynamic data;
  // api call status
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  // getting data from api
  Future getData() async {
    // *) perform api call
    await BaseClient.safeApiCall(
      url, // url
      requestType,
      data: body,
      headers: url.contains('crm') && !url.contains('LoginSSO')
          ? {
              'Authorization': 'Bearer ${MySharedPref.getSupportMeToken()}',
            }
          : headers ??
              {
                'ac84-4ca9-b5a3':
                    '1b0eab95-6362-4ac3-9125-816eb102dad0-48e2b739-9487-4034-a843-a9f9d08b9d8b1b0eab95-6362-4ac3-9125-816eb102dad0-48e2b739-9487-4034-a843-a9f9d08b9d8b-48e2b739-9487-4034-a843-a9f9d08b9d8b',
              },

      onLoading: () {
        // *) indicate loading state
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        // api done successfully
        data = response.data;

        // *) indicate success state
        apiCallStatus = ApiCallStatus.success;
        update();
      },
      // if you don't pass this method base client
      // will automaticly handle error and show message to user
      onError: (error) {
        // show error message to user
        BaseClient.handleApiError(error);
        // *) indicate error status
        apiCallStatus = ApiCallStatus.error;
        update();
      },
    );
  }
}
