ThinkPHP 5.0.24                                                                                      
PHP 7.3.3                                                                                         
===============

## 版本歷程!!

~~~
V1.0 ---------- 用戶註冊、登陸、書籍章節等實裝                                                 
V1.1 ---------- 優化書籍章節列表，API獨立拆分
V1.2 ---------- 將書籍列表及章節列表API加入分頁功能，減少資料庫查詢負載  
V2.0 ---------- 修正auth過期時間失效問題            
V2.1 ---------- 模擬充值接口、充值紀錄、個人收藏夾、個人信息   
V2.2 ---------- 加入收藏夾錯誤的書籍編號、章節編號判斷                                
~~~

--------------------------------------------------------------------------------------------------

## 20190422_需求

為漫畫APP開發一個Api                                                                              
主要實現功能：                                                                                    
1、用戶輸入email,密碼註冊                                                                         
2、用戶可以登陸                                                                                   
3、遊客只能看免費的章節，收費章節必須註冊，並且賬戶有足夠的書幣                                   



 + 數據庫大致可結構，自己可以擴展                                                                 
 + 用戶（email,password,bean[書幣] ）                                                             
 + 書籍（書籍名稱，書籍封面，簡介等基本信息）
 + 章節（所屬書籍，章節標題，章節封面圖，章節內容，書幣單價），書幣單價為0表示免費。

--------------------------------------------------------------------------------------------------

## 20190423_需求

擴展下接口，給每個用戶配虛擬賬戶存書幣，模擬充值接口，可以不接支付，個人收藏夾，充值記錄等關於個人
方面的信息接口。

`PS.只做API，不需實現前端UI介面`

--------------------------------------------------------------------------------------------------

## 功能實現

~~~
1、用戶註冊 API URL:

  http://yourdomain/index.php/Index/Index/Register?email=youremail&password=123456

  控制器程序路徑 : application\index\controller\Index.php  class = Register
  
2、用戶登陸

  http://yourdomain/index.php/Index/Index/Login?email=youremail&password=123456

  控制器程序路徑 : application\index\controller\Index.php  class = Login

  用戶註冊登陸設計概念

  原本APP提交之密碼應透過加密後傳輸，這裡為了測試方便先行使用明文。                                 
  用戶登陸後回應app auth，用以後續驗證會員權限而不需重複撈取資料庫驗證。                            


3、書籍列表瀏覽列表JSON資訊

  http://yourdomain/index.php/Index/Index/Books?auth=auth&page=1&limit=15                           
  auth為登陸後回應給APP的會員驗證加密字串
  參數page與參數limit為APP端傳來分頁信息，可減輕後端資料庫查詢負載。

  控制器程序路徑 : application\index\controller\Index.php  class = Books

  書籍列表設計概念

  書籍列表無論會員或遊客皆可瀏覽。                                                                  
  該列表頁Books透過接收APP傳來的auth以驗證用戶，並以APP傳來分頁信息以優化後端資料庫查詢負載。


4、書籍之章節瀏覽列表JSON資訊

  http://yourdomain/index.php/Index/Index/BookView?bid=2&auth=auth&page=1&limit=15                  
  auth為登陸後回應給APP的會員驗證加密字串
  參數page與參數limit為APP端傳來分頁信息，可減輕後端資料庫查詢負載。

  控制器程序路徑 : application\index\controller\Index.php  class = BookView

  書籍之章節設計概念

  API響應分為註冊會員的響應格式與遊客的響應格式

  章節列表頁會員JSON回應之判斷

  當會員餘額大於或等於書籍章節價格則回應給APP JSON issee 內容 can_see字段；反之回應no_see字段，後續
  APP判斷由APP端衍生。

  章節列表頁遊客JSON回應之判斷
  當未取得auth或auth不正確，則視為遊客，遊客只有免費章節回應給APP的JSON issee內容才會是can_see；收費
  章節則回應please login；後續APP判斷由APP端衍生。


5、模擬充值接口與充值紀錄列表實現

  充值接口
  http://yourdomain/index.php/Index/User/setPayment?auth=auth&amount=50
  auth為登陸後回應給APP的會員驗證加密字串

  控制器程序路徑 : application\index\controller\User.php  class = setPayment

  充值紀錄列表
  http://yourdomain/index.php/Index/User/getPaymentList?page=1&limit=2&auth=auth
  auth為登陸後回應給APP的會員驗證加密字串
  參數page與參數limit為APP端傳來分頁信息，可減輕後端資料庫查詢負載。 

  控制器程序路徑 : application\index\controller\User.php  class = getPaymentList

  % 事務處理 => 充值至會員虛擬帳戶與充值紀錄寫入包在同一事務處理，避免資料不同步 %  
  
6、模擬APP收藏感興趣之書籍章節與收藏夾內容呈現

  加入收藏夾
  http://yourdomain/index.php/Index/User/setCollect?bid=3&cid=18&auth=auth
  auth為登陸後回應給APP的會員驗證加密字串

  控制器程序路徑 : application\index\controller\User.php  class = setCollect

  收藏夾列表
  http://yourdomain/index.php/Index/User/getCollectList?page=1&limit=2&auth=auth
  auth為登陸後回應給APP的會員驗證加密字串
  參數page與參數limit為APP端傳來分頁信息，可減輕後端資料庫查詢負載。

  控制器程序路徑 : application\index\controller\User.php  class = getCollectList
  
~~~

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------


## 資料庫設計 John

~~~
資料庫編碼 : UTF-8


member	=>	會員資料表

books	=>	書籍資料表

chapter	=>	書籍之章節資料表

payment_records	=>	充值紀錄資料表

favorites	=>	收藏夾資料表

SQL檔案存放於根目錄db資料夾內。
~~~
