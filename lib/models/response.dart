class Response<T>{
  late T _data;

  Response( T data){  
    setData=data;
  }

  T get getData=>_data;

  set setData(T data){
    _data=data;
  }

}