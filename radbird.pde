import interfascia.*;
import java.util.*;
import java.net.*;
import java.io.*;
import twitter4j.conf.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import twitter4j.*;

IFLookAndFeel look_default, look_red, look_yellow, look_green, look_grey, look_tab_grey;
boolean panel_1_checked = false;
boolean panel_2_checked = false;
int current_panel = 0;
processing.data.JSONObject conf; 

/* Webservices */
String OPENCAGE_KEY = "83325a178bf8fa5ac56db6996af6c7b5";
Twitter twitter;
User tw_user;

/* GUI tabs (switch between panel 1 and 2) */
GUIController gui_control_tabs;
IFButton bt_tab_1;
IFButton bt_tab_2;

/* GUI config : managing config files */
GUIController gui_control_conf;
IFButton bt_config_file;

/**
 * Main function. Configures the GUI, retrieves geo coordinates, initializes the first GUI panel.
 */
void setup() {
  size(400, 600);
  gui_config();
  geo_config();
  gui_panel_1();
}

/**
 * Main lopps. Simply clears the canvas.
 */
void draw() {
  background(255);
}

/**
 * Main events controller. Handles clicks on most GUI buttons.
 */
void actionPerformed (GUIEvent e) {
  if (e.getMessage() == "Clicked") {
    if (current_panel == 1) {
      if (e.getSource() == bt_tab_2) {
        gui_panel_2();
      } else if (e.getSource() == bt_check_1) {
        panel_1_check();
      } else if (e.getSource() == bt_next_1) {
        gui_panel_3();
      }
    } else if (current_panel == 2) {
      if (e.getSource() == bt_tab_1) {
        gui_panel_1();
      } else if (e.getSource() == bt_check_2) {
        panel_2_check();
      } else if (e.getSource() == bt_next_2) {
        gui_panel_3();
      }
    } else if (current_panel == 3) {
      if (e.getSource() == bt_prev_3) {
        gui_panel_1();
      } else if (e.getSource() == bt_start_3) {
        twitter_test();
      }
    }
  }
}

/**
 * Configures the GUI components that are common to several panels. Then calls the configuration functions of each panels.
 */
void gui_config() {

  /* GUI look and feels */
  look_default = new IFLookAndFeel(this, IFLookAndFeel.DEFAULT);

  look_red = new IFLookAndFeel(this, IFLookAndFeel.DEFAULT);
  look_red.borderColor = color(255, 200, 200);
  look_red.baseColor = color(255, 200, 200);

  look_yellow = new IFLookAndFeel(this, IFLookAndFeel.DEFAULT);
  look_yellow.borderColor = color(255, 255, 200);
  look_yellow.baseColor = color(255, 255, 200);

  look_green = new IFLookAndFeel(this, IFLookAndFeel.DEFAULT);
  look_green.borderColor = color(200, 255, 200);
  look_green.baseColor = color(200, 255, 200);

  look_grey = new IFLookAndFeel(this, IFLookAndFeel.DEFAULT);
  look_grey.borderColor = color(200, 200, 200);
  look_grey.baseColor = color(200, 200, 200);

  look_tab_grey = new IFLookAndFeel(this, IFLookAndFeel.DEFAULT);
  look_tab_grey.baseColor = color(200, 200, 200);
  look_tab_grey.borderColor = color(200, 200, 200);
  look_tab_grey.highlightColor = color(200, 200, 200);

  /* GUI tabs (switch between panel 1 and 2) */
  gui_control_tabs = new GUIController(this);
  bt_tab_1 = new IFButton("Basic configuration", 0, 30, width/2);
  bt_tab_1.addActionListener(this);
  gui_control_tabs.add(bt_tab_1);
  bt_tab_2 = new IFButton("Advanced configuration", width/2, 30, width/2);
  bt_tab_2.addActionListener(this);
  gui_control_tabs.add(bt_tab_2);

  /* GUI config : managing config files */
  gui_control_conf = new GUIController(this);
  bt_config_file = new IFButton("Loading a config file ...", 0, 0, width);
  gui_control_conf.add(bt_config_file);
  bt_config_file.setLookAndFeel(look_tab_grey);
  config_file_load();

  /* configuring GUI panels */
  gui_panel_1_config();
  gui_panel_2_config();
  gui_panel_3_config();
  gui_panel_4_config();
}

void config_file_load() {
  if (loadStrings("perso.conf") != null) {
    conf = loadJSONObject("perso.conf");
    bt_config_file.setLabel("Config loaded from perso.conf");
  } else if (loadStrings("default.conf") != null) {
    conf = loadJSONObject("default.conf");
    bt_config_file.setLabel("Config loaded from default.conf");
  } else {
    bt_config_file.setLabel("No config file found.");
  }
}

void config_file_save(){
  if(rc_type.getSelected() == rc_type1){
    conf.setString("type", "indoor");
  }
  else{
    conf.setString("type", "outdoor");
  }
  conf.setString("country", tf_country.getValue());
  conf.setString("city", tf_city.getValue());
  conf.setString("address", tf_address.getValue());
  conf.setString("geolat", tf_geolat.getValue());
  conf.setString("geolon", tf_geolon.getValue());
  conf.setString("environment", tf_environment.getValue());
  conf.setString("tags", tf_tags.getValue());
  conf.setString("device", tf_device.getValue());
  conf.setString("duration", tf_duration.getValue());
  conf.setString("frequency", tf_frequency.getValue());
  conf.setString("twitter_oauth_token", tf_oauth_token.getValue());
  conf.setString("twitter_oauth_secret", tf_oauth_secret.getValue());
  conf.setString("twitter_api_key", tf_api_key.getValue());
  conf.setString("twitter_api_secret", tf_api_secret.getValue());
  saveJSONObject(conf, "data/perso.conf");
}