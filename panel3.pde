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
  
  lb_oauth_token = new IFLabel("Oauth token", 20, 85);
  gui_control_3.add(lb_oauth_token);
  tf_oauth_token = new IFTextField("tf_oauth_token", 20, 100, 300);
  tf_oauth_token.setValue(OAUTH_ACCESS_TOKEN);
  gui_control_3.add(tf_oauth_token);
  
  lb_oauth_secret = new IFLabel("Oauth secret", 20, 135);
  gui_control_3.add(lb_oauth_secret);
  tf_oauth_secret = new IFTextField("tf_oauth_secret", 20, 150, 300);
  tf_oauth_secret.setValue(OAUTH_ACCESS_TOKEN_SECRET);
  gui_control_3.add(tf_oauth_secret);
  
  lb_api_key = new IFLabel("API key", 20, 185);
  gui_control_3.add(lb_api_key);
  tf_api_key = new IFTextField("tf_api_key", 20, 200, 300);
  tf_api_key.setValue(OAUTH_CONSUMER_KEY);
  gui_control_3.add(tf_api_key);
  
  lb_api_secret = new IFLabel("API secret", 20, 235);
  gui_control_3.add(lb_api_secret);
  tf_api_secret = new IFTextField("tf_api_secret", 20, 250, 300);
  tf_api_secret.setValue(OAUTH_CONSUMER_SECRET);
  gui_control_3.add(tf_api_secret);
  
  bt_prev_3 = new IFButton("Back", 100, 300, 90);
  bt_prev_3.addActionListener(this);
  gui_control_3.add(bt_prev_3);
  bt_start_3 = new IFButton("Start", 210, 300, 90);
  bt_start_3.addActionListener(this);
  gui_control_3.add(bt_start_3);
  
  lb_start_3 = new IFLabel("", 20, 320);
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
  try {    
    tw_user = twitter.verifyCredentials();
    gui_panel_4();
  } catch (TwitterException te) {
    lb_start_3.setLabel("Couldn't connect to the Twitter API.\nPlease check the login information and your Internet connection.");
  }
}