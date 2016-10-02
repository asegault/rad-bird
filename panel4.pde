/* GUI panel 4 : bot control panel */
GUIController gui_control_4;

IFLabel lb_title_time;
IFLabel lb_time;

IFLabel lb_title_nb;
IFLabel lb_nb;

IFLabel lb_title_last;
IFLabel lb_last;

IFButton bt_stop_4;
IFButton bt_restart_4;

String tw_desc = "";
String tw_loc = "";
String tw_tweet = "";

int nb = 0;
/* trouver comment représenter les dates / durées */


/**
 * Configures the GUI components of the fourth panel.
 */
void gui_panel_4_config() {
  gui_control_4 = new GUIController(this);

  lb_title_time = new IFLabel("Bot started since : ", 20, 85);
  gui_control_4.add(lb_title_time);
  lb_time = new IFLabel("blabla", 30, 100);
  gui_control_4.add(lb_time);

  lb_title_nb = new IFLabel("Tweets sent :", 20, 155);
  gui_control_4.add(lb_title_nb);
  lb_nb = new IFLabel("blabla", 30, 170);
  gui_control_4.add(lb_nb);

  lb_title_last = new IFLabel("Last tweet :", 20, 225);
  gui_control_4.add(lb_title_last);
  lb_last = new IFLabel("blabla", 30, 240);
  gui_control_4.add(lb_last);

  bt_stop_4 = new IFButton("Stop", 100, 300, 200);
  bt_stop_4.addActionListener(this);
  gui_control_4.add(bt_stop_4);
  bt_restart_4 = new IFButton("Restart", 100, 300, 200);
  bt_restart_4.addActionListener(this);
}

/**
 * Displays the fourth panel and hides the other ones. Then calls the Twitter profile configuration function 
 */
void gui_panel_4() {
  current_panel = 4;
  gui_control_tabs.setVisible(false);
  gui_control_conf.setVisible(false);
  gui_control_1.setVisible(false);
  gui_control_2.setVisible(false);
  gui_control_3.setVisible(false);
  gui_control_4.setVisible(true);

  twitter_config();
}


/**
 * Creates profiles and location strings based on user configuration. Then updates the Twitter profile
 */
void twitter_config() {
  /* location field */
  if (tf_geolon.getValue().length() == 0 || tf_geolat.getValue().length() == 0 ) {
    if (tf_city.getValue().length() > 0) {
      tw_loc = tf_city.getValue() ;
    }
    if (tf_country.getValue().length() > 0) {
      if (tf_city.getValue().length() > 0) {
        tw_loc = tw_loc + ", " ;
      }
      tw_loc = tw_loc + tf_country.getValue() ;
    }
  } else {
    tw_loc = tf_geolon.getValue() + ", " + tf_geolat.getValue() ;
  }

  /* description field */
  if (rc_type.getSelected() == rc_type1) {
    tw_desc = "Indoor measurements" ;
  } else {
    tw_desc = "Outdoor measurements" ;
  }
  if (tf_device.getValue().length() > 0) {
    tw_desc = tw_desc + " using " + tf_device.getValue() ;
  }
  if (tf_environment.getValue().length() > 0) {
    tw_desc = tw_desc + " (" + tf_environment.getValue() + ")" ;
  }
  tw_desc = tw_desc + "." ;
  if (tf_duration.getValue().length() > 0) {
    tw_desc = tw_desc + " Average over " + tf_duration.getValue();
    if (tf_frequency.getValue().length() > 0) {
      tw_desc = tw_desc + " every " + tf_frequency.getValue() + ".";
    } else {
      tw_desc = tw_desc + ".";
    }
  } else {
    if (tf_frequency.getValue().length() > 0) {
      tw_desc = tw_desc + "Published every " + tf_frequency.getValue() + ".";
    }
  }


  if (tw_loc != tw_user.getLocation() || tw_desc != tw_user.getDescription()) {
    try {    
      twitter.updateProfile(tw_user.getName(), tw_user.getURL(), tw_loc, tw_desc);
    } 
    catch (TwitterException te) {
      println("Couldn't connect to the Twitter API.");
    }
  }
}