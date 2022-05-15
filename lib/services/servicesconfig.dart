class ServicesConfig{
  static String baseUrl="https://arenationfull.herokuapp.com/";
  static final Map<String,String> headers={
        "content-type" : "application/json",
        "accept" : "application/json"
  };

  static Duration timeOutLimit=const Duration(seconds: 20);
  
}