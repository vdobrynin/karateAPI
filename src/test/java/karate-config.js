function fn() {
  var env = karate.env;     // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {                              // #16.1
    apiUrl: 'https://conduit-api.bondaracademy.com/api/',
  };
  if (env == 'dev') {                            // #16.1
    config.userEmail = 'karateTest64@test.com'
    config.userPassword = 'vd1234567'
  }
  if (env == 'qa') {
    config.userEmail = 'karateTest65@test.com'
    config.userPassword = 'vd123456789'
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers', { Authorization: 'Token ' + accessToken })

  return config;
}