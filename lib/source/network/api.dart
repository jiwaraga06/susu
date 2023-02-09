String baseUrl = 'https://satu.sipatex.co.id:2087';
String baseUrlApi2 = 'https://api2.sipatex.co.id:2096';

class MyApi {
  static token() {
    return 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxLCJuYW1hIjoicm9vdCIsImVtYWlsIjoicm9vdEBsb2NhbGhvc3QifSwiaWF0IjoxNTkyMjM1MzE2fQ.KHYQ0M1vcLGSjJZF-zvTM5V44hM0B8TqlTD0Uwdh9rY';
  }

  static invetoryIssue() {
    return '$baseUrl/api/v1/mobile-app/klinik/inventory-issue';
  }

  static tukarSusu(barcode) {
    return '$baseUrlApi2/CoinChange/TukarSusu1?Barcode=$barcode';
  }

  static login(username, userpass) {
    return '$baseUrlApi2/CoinChange/CekLogin?UserName=$username&UserPass=$userpass';
  }
}
