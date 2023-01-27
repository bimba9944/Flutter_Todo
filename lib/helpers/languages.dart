mixin AppLocale {
  static const String title = 'TODO';
  static const String text = 'Things todo';
  static const String changeLanguage = 'Change language';
  static const String changeTheme = 'Change theme';
  static const String logOut = 'Logout';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String repeatPassword = 'Repeat password';
  static const String register = 'Register';
  static const String alreadyAMember = 'Already a member';
  static const String logIn = 'Login';
  static const String userOrEmail = 'Username or Email';

  static const Map<String, dynamic> EN = {
    title: 'TODO',
    text: 'Things todo!',
    changeLanguage: changeLanguage,
    changeTheme: changeTheme,
    logOut: logOut,
    email: email,
    password: password,
    repeatPassword:repeatPassword,
    register:register,
    alreadyAMember:alreadyAMember,
    logIn:logIn,
    userOrEmail:userOrEmail
  };
  static const Map<String, dynamic> KM = {
    title: '去做',
    text: '要做的事！',
    changeLanguage: '改变语言',
    changeTheme: '改变主题',
    logOut: '登出',
    email: '电子邮件',
    password:'密码',
    repeatPassword: '重复输入密码',
    register: '登记',
    alreadyAMember:'已经是会员',
    logIn:'登录',
    userOrEmail:'用户名或电子邮件'
  };
  static const Map<String, dynamic> JA = {
    title: 'する',
    text: 'やる事！',
    changeLanguage: '言語を変更',
    changeTheme: 'テーマを変更',
    logOut: 'ログアウト',
    email: 'Eメール',
    password:'パスワード',
    repeatPassword:'パスワードを再度入力してください',
    register:'登録',
    alreadyAMember:'すでに会員',
    logIn:'ログインする',
    userOrEmail:'ユーザー名または電子メール'
  };
}
