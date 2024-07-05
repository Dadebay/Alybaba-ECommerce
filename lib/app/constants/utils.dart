// ignore_for_file: equal_keys_in_map

import 'package:get/get.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'tm': {
          'totalProducts': 'Hemme harytlar',
          'stockInHand': 'Elimizdaki harytlar',
          'deleteAccount': 'Hasaby pozmak',
          'deleteAccountTitle': 'Pozuldy',
          'deleteAccountSubtitle': 'Hasabyňyza degişli hemme maglumatlar pozuldy !',
          'aboutUs': 'Biz barada',
          'add': 'Goş',
          'addAddress': 'Salgy goş',
          'addCart': 'Sebede goş',
          'added': 'Goşuldy',
          'addedSubtitle': 'Sebede haryt goşuldy ',
          'address': 'Öý salgyňyz',
          'agree': 'Tassyklamak',
          'alreadyExist': 'Ulanyjy maglumatlaryňyz bizde ýok. Hasaba al bölümden hasaba girmegiňizi haýýyş edýäris',
          'balance': 'Hasap',
          'banner': 'Reklama',
          'call': 'Jaň et',
          'cart': 'Sebet',
          'cartEmpty': 'Sebediňiz boş',
          'cartEmptySubtitle': 'Sebediňize hiç zat goşmadyňyz.',
          'category': 'Kategoriýa',
          'come': 'Geldi',
          'contactInformation': 'Habarlaşmak üçin : ',
          'container': 'Kontainer',
          'copySucces': 'Tassyklandy',
          'copySuccesSubtitle': 'Göçürme ýerine ýetirildi',
          'countProducts': 'Harytlar : ',
          'createdAt': 'Goýulan Senesi : ',
          'data': 'Maglumat :',
          'data1': 'Maşyn ady :',
          'data2': 'Kategoriýa :',
          'data3': 'Görülme sany :',
          'data4': 'Ýüklenme Sany :',
          'data5': 'Goşmaça Maglumat :',
          'deleteAddress': 'Salgylarym',
          'deleteAddressTitle': 'Siz hakykatdanda Salgylarymy pozmak isleýärsiňizmi ?',
          'description': 'Düşündiriş',
          'download': 'Ýükle',
          'downloaded': 'Ýüklänlerim',
          'downloadFiles': 'Ýüklemek',
          'emptyCart': 'Sebet boş',
          'emptyCartSubtitle': 'Sargyt etmek üçin sebediňizi haryt goşuň',
          'error': 'Ýalňyşlyk ýüze çykdy täzeden synanşyň',
          'errorData': 'Girizeň maglumatyňyz ýalňyş !',
          'errorEmpty': 'Tekst gutusy boş bolup bilmez',
          'errorPassword': 'Parol azyndan 6 haryp bolmaly',
          'errorPassword2': 'Parolyňyz ýalňyş',
          'errorPhoneCount': 'Telefon belgiňiz 8 sanly bolmaly.',
          'errorTitle': 'Ýalňyş',
          'favorites': 'Halanlarym',
          'filter': 'Filter',
          'fixMachine': 'Bejeriş Hyzmaty',
          'giveLike': 'Bizi Play marketde bahalandyryň',
          'home': 'Baş sahypa',
          'locations': 'Salgylarym',
          'log_out_title': 'Siz hakykatdanda ulgamdan çykmak isleýärsiňizmi ?',
          'log_out': 'Ulgamdan çyk',
          'login': 'Ulgama gir',
          'loginError': 'Ulgama giriň',
          'loginError1': 'Hyzmaty ýerine ýetirmek üçin ulgama giriň',
          'loginErrorSubtitle': 'Sargyt etmek üçin ulgama giriň',
          'loginErrorSubtitle1': 'Hyzmaty ýerine etmek üçin ulgama giriň',
          'maxPrice': 'Iň gymmat',
          'minPrice': 'Iň arzan',
          'no': 'Ýok',
          'noConnection1': 'Aragatnaşyk ýok',
          'noConnection2': 'Internede baglanyp bolmady.Internet sazlamalaryňyzy barlap gaýtadan synanşyň !',
          'noConnection3': 'Täzeden synanş',
          'noData': 'Maglumat ýüklenmedi, täzeden synanşyň',
          'noData1': 'Wagtlaýynça maglumat ýok !',
          'noFile': 'Hiç hili Faýl ýok. Biz bilen habarlaşyň',
          'noMoney': 'Pul ýok',
          'noMoneySubtitle': 'Hyzmaty ýerine ýetirmek üçin Puluňyz ýetenok',
          'note': 'Bellik',
          'notification': 'Bildirişler',
          'notWork': 'Işlänok',
          'notWorkSubtitle': 'Waglaýynça hyzmat işlänok',
          'order_status_come': 'Gelenler',
          'order_status_submission': 'Tabşyrylanlar',
          'order_status_wait': 'Sargyt edilenler',
          'order': 'Sargyt',
          'orderAdress': 'Eltip bermek üçin salgyňyz',
          'orderComesThatDaySubtitle': 'hepde aralygynda gelýär',
          'orderComesThatDayTitle': 'Zakaz eden harytlaryňyz ',
          'orderProducts': 'Sargyt et',
          'orders': 'Sargytlarym',
          'orderSubtitle': 'Sargydyňyz ýerine ýetirmek üçin nobata goýuldy',
          'orderType': 'Sargyt görnüşi',
          'otp': 'Sms kod',
          'otpCheck': 'Otp Werfikasiýa',
          'otpErrorSubtitle': 'Sms koduňyzy ýene bir gezek barlaň',
          'otpErrorTitle': 'SMS kod ýalňyşlygy',
          'otpSubtitle': 'Telefon belgiňize gelen sms kody giriziň',
          'otpTitle': 'Ýazan belgiňize sms arkaly kod ugradylar.',
          'ourDeliveryService': 'Eltip bermek we töleg',
          'phoneNumber': 'Telefon belgiňiz',
          'plain': 'Uçar',
          'price': 'Bahasy :',
          'priceProduct': 'Jemi Bahasy : ',
          'priceRange': 'Baha aralygy',
          'productAddToFav': 'Haryt halanlarym goşuldy',
          'products': 'Harytlar',
          'profil': 'Ulanyjy',
          'questions': 'Köp soralýan soraglar ?',
          'read': 'Oka',
          'referal_Code': 'Referal Kod',
          'referalDesc': 'Bu kod Üsti bilen ulanyjylary çagyryp bilersiňiz ve Pul gazanyp bilersiňiz',
          'referalKod': 'Referal kod',
          'referalKod1': 'Referal kodyňyz',
          'referalKodEarnedMoney': 'Jemi gazanç :',
          'referalKodUsedUser': 'Kody ulanan ulanyjylar',
          'select_language': 'Dil saýlaň',
          'selectCityTitle': 'Welaýat saýlaň',
          'selectColor': 'Renk saýlaň !',
          'selectDate': 'Eltip bermeli wagty saýlaň',
          'selectDateTitle': 'Sargyt eltip bermeli wagty :',
          'selectMachine': 'Tikin maşyn görnüşi saýlaň',
          'selectSize': 'Razmer saýlaň !',
          'settings': 'Sazlamalar',
          'share': 'Programmany paýlaş',
          'shareUs': 'Programmany paýlaş',
          'signIn1': 'Familýaňyz',
          'signIn2': 'Adyňyz',
          'signInDialog': 'Ulgama girmek üçin ulanyjy maglumatlary doly we dogry şekilde dolduruň',
          'signUp': 'Hasaba al',
          'skip': 'Geç',
          'terms_and_conditions_to_order': 'Hormatly ulanyjy sargyt geçmek üçin ulanyş şertleri we düzgünlerini kabul ediň',
          'terms_and_conditions': 'Ulanyş şertleri we düzgünleri',
          'train': 'Ýük maşyn',
          'transferUSB': 'USB geçir',
          'userName': 'Ulanyjy ady',
          'versia': 'Wersiýa',
          'viewCount': 'Görülme Sany :',
          'waitForSms': 'SMS kod gelýänçä garaşmagyňyzy haýyş edýäris !',
          'waiting': 'Garaşylýar',
          'yes': 'Hawwa',
          'brandPP': 'Brand',
          'brands': 'Brendler',
          'callNumber': 'Telefon Belgilerimiz',
          'cash': 'Nagt',
          'cashSubtitle': 'Sargydy alan wagtyňyz nagt görnüşde hasaplaşmak',
          'categoriesMini': 'Kategoriýalar',
          'chooseTheColor': 'Renk saýlaň : ',
          'chooseTheSize': 'Razmer :',
          'creditCart': 'Kart',
          'creditCartSubtitle': 'Sargydy alan wagtyňyz töleg terminaly arkaly hasaplaşmak',
          'deleteFavProduct': 'Halanlarymy boşat !',
          'deleteFavProductSubtitle': 'Siz hakykatdanam Halanlarymy boşatmakçymy ?',
          'discountedItems': 'Arzanladyşdaky harytlar',
          'doYouWantToDeleteCart': 'Sebedi boşat !',
          'doYouWantToDeleteCartSubtitle': 'Siz hakykatdanam Sebedi boşatmakçymy ?',
          'emptyFavS': 'Halan harytlaryňyz sanawy boş.',
          'emptyFavT': 'Halanlarym ýok ',
          'hastags': 'Haştaglar',
          'inOurHands': 'Şulary hem halap bilersiňiz',
          'minSumCount': 'Sargydyňyzyň jemi azyndan 50 manat bolmaly',
          'newItems': 'Täze harytlar',
          'orderAgreeSubTitle': 'Sargyt eden Suwlaryňyz "BLOK" görnüşinde eltip berilýändir.',
          'orderAgreeTitle': 'Sargyt tassyklaň !',
          'orderDeleted': 'Pozuldy',
          'orderDeletedSubtitle': 'Harytlar Sebetden aýyryldy',
          'paymentMethod': 'Töleg görnüşi',
          'recomendedItems': 'Maslahat berilýän harytlar',
          'sameProducts': 'Meňzeş harytlar',
          'search': 'Gözleg',
          'shopByBrand': 'Brand boýunça söwda',
          'trendingItems': 'Meşhur harytlar',
          'userInfo': 'Ulanyjy maglumatlary :',
          'videos': 'Gysga wideolar',
          'sort': 'Yzygiderlik',
          'sortCreatedAtHighToLow': 'Ilki Täzeler',
          'sortCreatedAtLowToHigh': 'Ilki Köneler',
          'sortDefault': 'Adaty',
          'sortPriceHighToLow': 'Ilki Arzanlar',
          'sortPriceLowToHigh': 'Ilki Gymmatlar',
          'sortViewsASC': 'Köp görülenler',
          'sortViewsDESC': 'Az görülenler',
          'noProductTitle': 'Gutardy',
          'noProductSubtitle': 'Haryt gutardy',
          'kargoIncluded': 'Kargo mugt',
          'orderComplete': 'Sargyt tassyklandy',
          'orderCompletedTrue': 'Sargydyňyz tassyklandy Siz bilen jaň arkaly habarlaşarlar',
          'emptyLocations': 'Siziň salgylaryňyz goşulmadyk',
          'ordersDeleted': 'Salgylaryňyz pozuldy ',
          'orderName1': 'Garaşylýanlar',
          'orderName2': 'Kabul edilenler',
          'orderName3': 'Ýolda gelýänler ',
          'orderName4': 'Red edilenler',
          'noHistoryOrders': 'Hiç hili sargyt etmediňiz',
          'sum': 'Jemi',
          'status': 'Ýagdaýy',
          'sameProducts': 'Degişli harytlar ',
          'more': 'Goşmaçalar',
          'date': 'Sene : ',
          'orderDetails': 'Giňişleýin maglumat',
          'noImage': 'Surat ýok',
          'product': 'Haryt',
          'appColor': 'Programma reňki',
          'appColor1': 'Reňk saýlaň',
          'appColor2': 'Reňk 1',
          'appColor3': 'Reňk 2',
          'appColor4': 'Reňk 3',
          'waitMyMan': 'Garaşyň',
          'waitMyManSubtitle': 'Maglumat ýüklenýänça garaşyň',
        },
        'ru': {
          'totalProducts': 'Все товары',
          'stockInHand': 'Запасы в наличии',
          'deleteAccountTitle': 'Удалено',
          'deleteAccountSubtitle': 'Вся информация, связанная с вашей учетной записью, была скомпрометирована!',
          'deleteAccount': 'Удалить аккаунт',
          'read': 'Читать',
          'product': 'Продукт',
          'signInDialog': 'Заполните информацию о пользователе полностью и правильно, чтобы войти',
          'signIn1': 'Ваша фамилия',
          'signIn2': 'Ваше имя',
          'noImage': 'Нет изображения',
          'noProductTitle': 'Готово',
          'noProductSubtitle': 'Нет в наличии',
          'kargoIncluded': 'Бесплатное карго',
          'orderComplete': 'Заказ подтвержден',
          'orderCompletedTrue': 'Ваш заказ подтвержден. С вами свяжутся по телефону',
          'emptyLocations': 'Ваши местоположения не включены',
          'ordersDeleted': 'Ваши заказы были удалены ',
          'orderName1': 'Ожидания',
          'orderName2': 'Принято',
          'orderName3': 'Товар в пути',
          'orderName4': 'Отклонено',
          'noHistoryOrders': 'Вы не делали ни одного ордера',
          'sum': 'Итого',
          'status': 'Статус',
          'sameProducts': 'Те же продукты ',
          'more': 'Дополнения',
          'date': 'Год : ',
          'orderDetails': 'Детали',
          'terms_and_conditions_to_order': 'Уважаемый пользователь, примите условия заказа',
          'skip': 'Пропустить',
          'waitForSms': 'Пожалуйста, подождите, пока придет SMS-код!',
          'referalDesc': 'С помощью этого кода вы можете привлекать пользователей и зарабатывать деньги',
          'orderType': 'Тип ордера',
          'emptyFavS': 'Ваш список товаров по-прежнему пуст',
          'emptyFavT': 'У меня нет избранного ',
          'banner': 'Реклама',
          'errorTitle': 'Ошибка',
          'plain': 'Cамолет',
          'train': 'Фура',
          'container': 'Контейнер',
          'orderComesThatDayTitle': 'Заказанный товар прибудет в течение',
          'orderComesThatDaySubtitle': 'недель',
          'selectColor': 'Выбери цвет!',
          'selectSize': 'Выберите размер!',
          'aboutUs': 'О нас',
          'addCart': 'В корзину',
          'added': 'Добавлено',
          'addedSubtitle': 'Добавлено в корзину',
          'agree': 'Подтверждение',
          'alreadyExist': 'У нас нет ваших пользовательских данных. Пожалуйста, авторизуйтесь в разделе «Регистрация»',
          'balance': 'Счет',
          'call': 'Звонить',
          'cart': 'Корзина',
          'cartEmpty': 'Ваша корзина пуста',
          'cartEmptySubtitle': 'Вы ничего не добавили в корзину.',
          'category': 'Категория',
          'come': 'Пришел',
          'contactInformation': 'Связываться :',
          'copySucces': 'Подтвержденный',
          'countProducts': 'Товары : ',
          'createdAt': 'Дата публикации:',
          'data': 'Информация :',
          'data1': 'Название швейной машины :',
          'data2': 'Категория :',
          'data3': 'Количество просмотров :',
          'data4': 'Количество загрузок :',
          'data5': 'Дополнительная информация :',
          'description': 'Описание',
          'download': 'Скачать',
          'downloaded': 'Мои загрузки',
          'downloadFiles': 'Загрузить',
          'emptyCart': 'Корзина пуста',
          'emptyCartSubtitle': 'Добавьте товары в корзину для заказа',
          'error': 'Произошла ошибка. Пожалуйста, попробуйте еще раз',
          'errorData': 'Ваши данные для входа неверны!',
          'errorEmpty': 'Текстовое поле не может быть пустым',
          'errorPassword': 'Пароль должен содержать не менее 6 символов',
          'errorPassword2': 'Ваш пароль неверен',
          'errorPhoneCount': 'Ваш номер телефона должен состоять из 8 цифр.',
          'favorites': 'Избранное',
          'fixMachine': 'Техническое обслуживание',
          'giveLike': 'Оцените нас на Play Market',
          'home': 'Главная',
          'locations': 'Мои адреса',
          'log_out_title': 'Вы действительно хотите выйти из приложения?',
          'log_out': 'Выйти',
          'login': 'Войти',
          'loginError': 'Войти',
          'loginError1': 'Войдите, чтобы выполнить услугу',
          'loginErrorSubtitle': 'Войдите, чтобы заказать',
          'loginErrorSubtitle1': 'Войдите, чтобы выполнить услугу',
          'maxPrice': 'Дорогой',
          'minPrice': 'Дешевый',
          'no': 'Нет',
          'noConnection1': 'Нет связи',
          'noConnection2': 'Невозможно подключиться к Интернету. Пожалуйста проверьте настройки Интернета и повторите попытку!',
          'noConnection3': 'Попробуйте снова',
          'noData': 'Не удалось загрузить данные. Повторите попытку.',
          'noData1': 'Временно нет информации!',
          'noFile': 'Файлов нет. Свяжитесь с нами',
          'noMoney': 'Нет денег',
          'noMoneySubtitle': 'У вас недостаточно денег для выполнения услуги',
          'note': 'Примечание',
          'notification': 'Уведомления',
          'notWork': 'Не работает',
          'notWorkSubtitle': 'Служба предупреждений не работает',
          'order': 'Заказ',
          'orderAdress': 'Ваш адрес доставки',
          'orderProducts': 'Разместить заказ',
          'orders': 'Мои заказы',
          'orderSubtitle': 'Ваш заказ поставлен в очередь на выполнение',
          'otp': 'Код из смс',
          'otpCheck': 'OTP подтверждение',
          'otpErrorSubtitle': 'Пожалуйста, проверьте ваш смс-код еще раз',
          'otpErrorTitle': 'Ошибка кода СМС',
          'otpSubtitle': 'Введите SMS-код, полученный на ваш телефон',
          'ourDeliveryService': 'Доставка и оплата',
          'phoneNumber': 'Ваш номер телефона',
          'priceProduct': 'Итоговая цена : ',
          'priceRange': 'Ценовой диапазон',
          'productAddToFav': 'Товары добавлены в избранное',
          'products': 'Товары',
          'profil': 'Пользователь',
          'questions': 'Вопросы ?',
          'select_language': 'Выберите язык',
          'selectCityTitle': 'Выберите провинцию',
          'selectDate': 'Выберите дату доставки',
          'selectDateTitle': 'Время доставки заказа :',
          'selectMachine': 'Выберите тип швейной машины',
          'settings': 'Настройки',
          'share': 'Поделитесь приложением',
          'shareUs': 'Поделитесь приложением',
          'signUp': 'Регистрация',
          'filter': 'Фильтр',
          'sort': 'Сортировать',
          'sortDefault': 'По умолчанию',
          'sortCreatedAtHighToLow': 'Сначала новый',
          'sortCreatedAtLowToHigh': 'Сначала старые',
          'sortPriceHighToLow': 'Первый дешевый',
          'sortPriceLowToHigh': 'Первые ценности',
          'sortViewsASC': 'Больше просмотров',
          'sortViewsDESC': 'Меньше просмотров',
          'termsAndCondition': 'Правила и условия пользования',
          'transferUSB': 'Передача USB',
          'userName': 'Имя пользователя',
          'versia': 'Версия',
          'waiting': 'Ожидал',
          'yes': 'Да',
          'brandPP': 'Бренд',
          'brands': 'Бренды',
          'callNumber': 'Наши номера телефонов',
          'cash': 'Денежные средства',
          'cashSubtitle': 'Оплата наличными при получении заказа',
          'categoriesMini': 'Категории',
          'creditCart': 'Кредитная карта',
          'creditCartSubtitle': 'Расчет через платежный терминал при получении заказа',
          'deleteFavProduct': 'Удалить мои избранные !',
          'deleteFavProductSubtitle': 'Вы уверены, что хотите удалить избранное ?',
          'discountedItems': 'Товары со скидкой',
          'recomendedItems': 'Рекомендуемые продукты',
          'doYouWantToDeleteCart': 'Пустая корзина !',
          'doYouWantToDeleteCartSubtitle': 'Вы уверены, что хотите удалить корзину?',
          'hastags': 'Хэштеги',
          'minSumCount': 'К сожалению, сумма заказа должна быть не менее 50 манатов.',
          'newItems': 'Новые товары',
          'orderAgreeSubTitle': 'Заказанные Вами Воды поставляются в форме "БЛОК".',
          'orderAgreeTitle': 'Подтвердить заказ !',
          'orderDeleted': 'Удалено',
          'orderDeletedSubtitle': 'Заказы удалены из корзины',
          'paymentMethod': 'Способ оплаты ',
          'sameProducts': 'Те же продукты',
          'search': 'Найти ',
          'trendingItems': 'Популярные товары',
          'userInfo': 'Информация о пользователе :',
          'videos': 'Короткие видео',
          'shopByBrand': 'Поиск по бренду',
          'inOurHands': 'Вам также могут понравиться эти',
          'price': 'Цена :',
          'chooseTheColor': 'Выберите цвет : ',
          'chooseTheSize': 'Размер :',
          'order_status_wait': 'Заказанные товары',
          'order_status_come': 'Прибытие',
          'order_status_submission': 'Доставленный',
          'referal_Code': 'Промо-код',
          'terms_and_conditions': 'Условия и положения',
          'addAddress': 'Добавить адрес',
          'address': 'Ваш домашний адрес',
          'add': 'Добавлять',
          'deleteAddress': 'Мой адрес',
          'deleteAddressTitle': '  Вы уверены, что удалили все адреса в приложении ? ',
          'referalKodEarnedMoney': 'Общий доход :',
          'referalKodUsedUser': 'Пользователи, использующие код',
          'referalKod1': 'Ваш реферальный код',
          'referalKod': 'Промо-код',
          'copySuccesSubtitle': 'Перенос завершен',
          'appColor': 'Цвет приложения',
          'appColor1': 'Выберите цвет приложения',
          'appColor2': 'Цвет  1',
          'appColor3': 'Цвет  2',
          'appColor4': 'Цвет  3',
        },
        'en': {
          'totalProducts': 'Total Product',
          'stockInHand': 'Stock In Hand',
          'deleteAccountTitle': 'Deleted',
          'deleteAccountSubtitle': 'All information associated with your account has been deleted!',
          'deleteAccount': 'Delete account',
          'appColor': 'App Color',
          'appColor1': 'Select App color',
          'appColor2': 'Color 1',
          'appColor3': 'Color 2',
          'appColor4': 'Color 3',
          'read': 'Read',
          'product': 'Product',
          'noImage': 'No image',
          'noProductTitle': 'Finished',
          'noProductSubtitle': 'Out of stock',
          'kargoIncluded': 'Kargo free',
          'orderComplete': 'Order Confirmed',
          'orderCompletedTrue': 'Your order has been confirmed You will be contacted by phone',
          'emptyLocations': 'Your locations are not included',
          'ordersDeleted': 'Your orders have been deleted',
          'orderName1': 'Expectations',
          'orderName2': 'Accepted',
          'orderName3': 'Goods on the way',
          'orderName4': 'Rejected',
          'noHistoryOrders': 'You have not made any orders',
          'sum': 'Total',
          'status': 'Status',
          'sameProducts': 'Same Products ',
          'more': 'Additions',
          'date': 'Date : ',
          'orderDetails': 'Details',
          'terms_and_conditions_to_order': 'Dear user, accept the terms and conditions to order',
          'skip': 'Skip',
          'waitForSms': 'Please wait for the SMS code to arrive!',
          'referalDesc': 'You can refer users and earn money with this code',
          'orderType': 'Order Type',
          'emptyFavS': 'Your list of goods is still empty.',
          'emptyFavT': 'I have no favorites ',
          'banner': 'Advertisement',
          'errorTitle': 'Error',
          'plain': 'Airplane',
          'train': 'Globetrotter',
          'container': 'Container',
          'orderComesThatDayTitle': 'Your ordered goods will arrive within',
          'orderComesThatDaySubtitle': 'weeks',
          'selectColor': 'Choose a color!',
          'selectSize': 'Choose a size!',
          'referalKodEarnedMoney': 'Total income :',
          'referalKodUsedUser': 'Who used your referal code',
          'referalKod1': 'Your referal code',
          'referalKod': 'Referal Code',
          'copySuccesSubtitle': 'Перенос завершен',
          'deleteAddress': 'My address',
          'deleteAddressTitle': 'Are you sure to delete all addresses in the App ?',
          'add': 'Add',
          'addAddress': 'Add address',
          'address': 'Home location',
          'price': 'Price :',
          'aboutUs': 'About Us',
          'addCart': 'Add to Cart',
          'added': 'Added',
          'addedSubtitle': 'Item added to cart',
          'agree': 'Confirm',
          'alreadyExist': 'We do not have your user data. Please log in from the Register section',
          'balance': 'Account',
          'call': 'Call',
          'cart': 'Cart',
          'cartEmpty': 'Your cart is empty',
          'cartEmptySubtitle': 'You have not added anything to your cart.',
          'category': 'Category',
          'come': 'Delivered',
          'contactInformation': 'To contact: ',
          'copySuccess': 'Confirmed',
          'countProducts': 'Maps: ',
          'createdAt': 'Created At: ',
          'data': 'Information:',
          'data1': 'Machine name:',
          'data2': 'Category:',
          'data3': 'View count : ',
          'data4': 'Number of Downloads:',
          'data5': 'Additional Information:',
          'description': 'Description',
          'download': 'Download',
          'downloaded': 'Downloaded',
          'downloadFiles': 'Download',
          'emptyCart': 'Cart is empty',
          'emptyCartSubtitle': 'Add items to your cart to checkout',
          'error': 'An error occurred, please try again',
          'errorData': 'Your login information is incorrect!',
          'errorEmpty': 'Text box cannot be empty',
          'errorPassword': 'Password must be at least 6 characters long',
          'errorPassword2': 'Your password is incorrect',
          'errorPhoneCount': 'Your phone number must be 8 digits long.',
          'favorites': 'My favorites',
          'fixMachine': 'Maintenance Service',
          'giveLike': 'Rate us on Play Market',
          'home': 'Home',
          'locations': 'Locations',
          'log_out_title': 'Are you sure you want to log out?',
          'log_out': 'Log out',
          'login': 'Log in',
          'loginError': 'Log in',
          'loginError1': 'Log in to run the service',
          'loginErrorSubtitle': 'Login to order',
          'loginErrorSubtitle1': 'Login to perform service',
          'maxPrice': 'Most expensive',
          'minPrice': 'Cheapest',
          'no': 'No',
          'noConnection1': 'No connection',
          'noConnection2': 'Could not connect to the Internet. Please check your Internet settings and try again!',
          'noConnection3': 'Retry',
          'noData': 'Data not loaded, please try again',
          'noData1': 'Temporarily no data!',
          'noMoney': 'No Money',
          'noMoneySubtitle': 'You do not have enough money to perform the service',
          'note': 'Note',
          'notification': 'Notifications',
          'notWork': 'Not work',
          'notWorkSubtitle': 'Warning service not working',
          'order': 'Order',
          'orderAddress': 'Delivery Address',
          'orderProducts': 'Order',
          'orders': 'My orders',
          'orderSubtitle': 'Your order has been queued for execution',
          'otp': 'Sms Code',
          'otpCheck': 'Otp Verification',
          'otpErrorSubtitle': 'Please check your sms code again',
          'otpErrorTitle': 'SMS code error',
          'otpSubtitle': 'Enter the SMS code received on your phone number',
          'otpTitle': 'A code has been sent via SMS to the number you entered.',
          'ourDeliveryService': 'Delivery and Payment',
          'phoneNumber': 'Your phone number',
          'priceProduct': 'Total Price: ',
          'priceRange': 'Price Range',
          'products': 'Products',
          'profile': 'User',
          'questions': 'Frequently Asked Questions?',
          'select_language': 'Select a language',
          'selectCityTitle': 'Select City',
          'selectDate': 'Select a delivery date',
          'selectDateTitle': 'Order delivery time :',
          'selectMachine': 'Select sewing machine type',
          'settings': 'Settings',
          'share': 'Share the app',
          'shareUs': 'Share the app',
          'signIn1': 'Your Surname',
          'signIn2': 'Your Name',
          'signInDialog': 'Please fill in the user information completely and correctly to sign in to the device',
          'signUp': 'Sign Up',
          'filter': 'Filter',
          'sort': 'Sort',
          'sortDefault': 'Default',
          'sortCreatedAtHighToLow': 'Firstly new goods ',
          'sortCreatedAtLowToHigh': 'Firstly old goods',
          'sortPriceHighToLow': 'Firsty cheap',
          'sortPriceLowToHigh': 'Firstly expenive',
          'sortViewsASC': 'Most viewed',
          'sortViewsDESC': 'Least viewed',
          'transferUSB': 'Transfer USB',
          'userName': 'Username',
          'versia': 'Version',
          'waiting': 'Waiting',
          'yes': 'Yes',
          'z': 'View Count:',
          'brandPP': 'Brand',
          'brands': 'Brands',
          'callNumber': 'Phone Numbers',
          'cash': 'Cash',
          'cashSubtitle': 'Payment in cash when you receive the order',
          'categoriesMini': 'Categories',
          'creditCart': 'Credit Card',
          'creditCartSubtitle': 'Settlement through the payment terminal when you receive the order',
          'deleteFavProduct': 'Delete my favorites !',
          'deleteFavProductSubtitle': 'Are you sure you want to delete favorites ?',
          'discountedItems': 'Discounted Items',
          'recomendedItems': 'Recommended Products',
        },
      };
}
