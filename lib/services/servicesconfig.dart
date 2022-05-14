class ServicesConfig{
  static String baseUrl="https://arenationfull.herokuapp.com/";
  static final Map<String,String> headers={
     'Content-Type': 'application/json',
  };

  static Duration timeOutLimit=const Duration(seconds: 20);
  
}