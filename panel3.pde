/* GUI panel 3 : twitter config panel */
GUIController gui_control_3;

IFLabel com_twitter;

IFTextField tf_oauth_token;
IFLabel lb_oauth_token;

IFTextField tf_oauth_secret;
IFLabel lb_oauth_secret;

IFTextField tf_api_key;
IFLabel lb_api_key;

IFTextField tf_api_secret;
IFLabel lb_api_secret;

IFButton bt_prev_3;
IFButton bt_start_3;

IFLabel lb_start_3;

/**
 * Configures the GUI components of the third panel.
 */
void gui_panel_3_config(){
  gui_control_3 = new GUIController(this);
  
  com_twitter = new IFLabel("To learn how to generate Twitter API tokens, visit\nhttps://dev.twitter.com/oauth/overview/\napplication-owner-access-tokens", 20, 30);
  gui_control_3.add(com_twitter);
  
  lb_oauth_token = new IFLabel("Oauth token", 20, 90);
  gui_control_3.add(lb_oauth_token);
  tf_oauth_token = new IFTextField("tf_oauth_token", 20, 105, 360);
  tf_oauth_token.setValue(conf.getString("twitter_oauth_token"));
  gui_control_3.add(tf_oauth_token);
  
  lb_oauth_secret = new IFLabel("Oauth secret", 20, 140);
  gui_control_3.add(lb_oauth_secret);
  tf_oauth_secret = new IFTextField("tf_oauth_secret", 20, 155, 360);
  tf_oauth_secret.setValue(conf.getString("twitter_oauth_secret"));
  gui_control_3.add(tf_oauth_secret);
  
  lb_api_key = new IFLabel("API key", 20, 190);
  gui_control_3.add(lb_api_key);
  tf_api_key = new IFTextField("tf_api_key", 20, 205, 360);
  tf_api_key.setValue(conf.getString("twitter_api_key"));
  gui_control_3.add(tf_api_key);
  
  lb_api_secret = new IFLabel("API secret", 20, 240);
  gui_control_3.add(lb_api_secret);
  tf_api_secret = new IFTextField("tf_api_secret", 20, 255, 360);
  tf_api_secret.setValue(conf.getString("twitter_api_secret"));
  gui_control_3.add(tf_api_secret);
  
  bt_prev_3 = new IFButton("Back", 100, 300, 90);
  bt_prev_3.addActionListener(this);
  gui_control_3.add(bt_prev_3);
  bt_start_3 = new IFButton("Start", 210, 300, 90);
  bt_start_3.addActionListener(this);
  gui_control_3.add(bt_start_3);
  
  lb_start_3 = new IFLabel("", 20, 330);
  gui_control_3.add(lb_start_3);
}

/**
 * Displays the third panel and hides the other ones.
 */
void gui_panel_3(){
  current_panel = 3;
  gui_control_tabs.setVisible(false);
  gui_control_conf.setVisible(true);
  gui_control_1.setVisible(false);
  gui_control_2.setVisible(false);
  gui_control_3.setVisible(true);
  gui_control_4.setVisible(false);
}

/**
 * Tests the Twitter API authentication
 */
void twitter_test(){
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey(tf_api_key.getValue());
  cb.setOAuthConsumerSecret(tf_api_secret.getValue());
  cb.setOAuthAccessToken(tf_oauth_token.getValue());
  cb.setOAuthAccessTokenSecret(tf_oauth_secret.getValue());
  TwitterFactory tf = new TwitterFactory(cb.build());
  twitter = tf.getInstance();
  try {    
    tw_user = twitter.verifyCredentials();
    gui_panel_4();
  } catch (TwitterException te) {
    lb_start_3.setLabel("Couldn't connect to the Twitter API.\nPlease check the login information and your Internet connection.");
  }
}