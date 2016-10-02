/* GUI panel 2 : second config tab */
GUIController gui_control_2;

IFLabel lb_profile;

IFTextField tf_environment;
IFLabel lb_environment;
IFLabel com_environment;

IFTextField tf_tags;
IFLabel lb_tags;
IFLabel com_tags;

IFLabel lb_measurement;
IFLabel lb_measurement_notice;

IFTextField tf_device;
IFLabel lb_device;
IFLabel com_device;

IFTextField tf_duration;
IFLabel lb_duration;
IFLabel com_duration;

IFTextField tf_frequency;
IFLabel lb_frequency;
IFLabel com_frequency;

IFButton bt_check_2;
IFLabel lb_check_2;
String[] tab_check_2;

IFButton bt_next_2;

/**
 * Configures the GUI components of the second panel.
 */
void gui_panel_2_config(){
   /* GUI panel 2 : second config tab */
  
  gui_control_2 = new GUIController(this);
  
  lb_profile = new IFLabel("Profile", 10, 70, 40);
  gui_control_2.add(lb_profile);
  
  lb_environment = new IFLabel("Environment", 20, 90);
  gui_control_2.add(lb_environment);
  tf_environment = new IFTextField("tf_environment", 20, 105, 200);
  tf_environment.setValue(conf.getString("environment"));
  gui_control_2.add(tf_environment);
  com_environment = new IFLabel("Description of the site\n(e.g. floor, walls)", 230, 100);
  gui_control_2.add(com_environment);
  
  lb_tags = new IFLabel("Hashtags", 20, 135);
  gui_control_2.add(lb_tags);
  tf_tags = new IFTextField("tf_tags", 20, 150, 200);
  tf_tags.setValue(conf.getString("tags"));
  gui_control_2.add(tf_tags);
  com_tags = new IFLabel("Tags that will be attached\nto the tweets.", 230, 145);
  gui_control_2.add(com_tags);
  
  lb_measurement = new IFLabel("Measurement", 10,190, 40);
  gui_control_2.add(lb_measurement);
  
  lb_measurement_notice = new IFLabel("This information should \nonly be changed if the \nradiameter, electronics, \nor Arduino program differ \nfrom the original system.", 230, 230, 10);
  gui_control_2.add(lb_measurement_notice);
  
  lb_device = new IFLabel("Device name", 20, 210);
  gui_control_2.add(lb_device);
  tf_device = new IFTextField("tf_device", 20, 225, 200);
  tf_device.setValue(conf.getString("device"));
  tf_device.setLookAndFeel(look_grey);
  gui_control_2.add(tf_device);
  
  lb_duration = new IFLabel("Duration", 20, 255);
  gui_control_2.add(lb_duration);
  tf_duration = new IFTextField("tf_duration", 20, 270, 200);
  tf_duration.setValue(conf.getString("duration"));
  tf_duration.setLookAndFeel(look_grey);
  gui_control_2.add(tf_duration);
  
  lb_frequency = new IFLabel("Frequency", 20, 300);
  gui_control_2.add(lb_frequency);
  tf_frequency = new IFTextField("tf_frequency", 20, 315, 200);
  tf_frequency.setValue(conf.getString("frequency"));
  tf_frequency.setLookAndFeel(look_grey);
  gui_control_2.add(tf_frequency);
  
  bt_check_2 = new IFButton("Check", 100, 350, 200);
  bt_check_2.addActionListener(this);
  gui_control_2.add(bt_check_2);
  lb_check_2 = new IFLabel("", 10, 350);
  gui_control_2.add(lb_check_2);
  
  bt_next_2 = new IFButton("Next", 290, 380, 100);
  bt_next_2.addActionListener(this);
}

/**
 * Displays the second panel and hides the other ones.
 */
void gui_panel_2(){
  current_panel = 2;
  gui_control_tabs.setVisible(true);
  gui_control_conf.setVisible(true);
  bt_tab_1.setLookAndFeel(look_default);
  bt_tab_2.setLookAndFeel(look_tab_grey);
  gui_control_1.setVisible(false);
  gui_control_2.setVisible(true);
  gui_control_3.setVisible(false);
  gui_control_4.setVisible(false);
}

/**
 * Checks user's inputs on the second panel and provides feedbacks accordingly.
 */
void panel_2_check(){
  panel_1_check();
  tab_check_2 = new String[0];
  
  if(tf_environment.getValue().length() == 0){
    tf_environment.setLookAndFeel(look_red);
    com_environment.setLabel("Please describe the \nmeasurement environment");
    tab_check_2 = append(tab_check_2, "\n- environment description (advanced)");
  }
  else{
    tf_environment.setLookAndFeel(look_default);
    com_environment.setLabel("");
  }
  if(tf_tags.getValue().length() == 0){
    tf_tags.setLookAndFeel(look_red);
    com_tags.setLabel("Please indicate \nsome hashtags");
    tab_check_2 = append(tab_check_2, "\n- hashtags (advanced)");
  }
  else{
    tf_tags.setLookAndFeel(look_default);
    com_tags.setLabel("");
  }
  if(tf_device.getValue().length() == 0 || tf_duration.getValue().length() == 0 || tf_frequency.getValue().length() == 0){
      if(tf_device.getValue().length() == 0){
        tf_device.setLookAndFeel(look_red);
      }
      else{
        tf_device.setLookAndFeel(look_grey);
      }
      if(tf_duration.getValue().length() == 0){
        tf_duration.setLookAndFeel(look_red);
      }
      else{
        tf_duration.setLookAndFeel(look_grey);
      }
      if(tf_frequency.getValue().length() == 0){
        tf_frequency.setLookAndFeel(look_red);
      }
      else{
        tf_frequency.setLookAndFeel(look_grey);
      }
    lb_measurement_notice.setLabel("Please fill the \nmeasurement setup");
    tab_check_2 = append(tab_check_2, "\n- measurement device setup (advanced)");
  }
  else{
    lb_measurement_notice.setLabel("This information should \nonly be changed if the \nradiameter, electronics, \nor Arduino program differ \nfrom the original system.");
  }
    
  if(panel_2_checked != true){
    gui_control_2.add(bt_next_2);
  }
  panel_2_checked = true;
  bt_check_2.setLabel("Re-check");
  bt_check_2.setWidth(100);
  bt_check_2.setX(290);
  
  tab_check_2 = concat(tab_check_1, tab_check_2);
  
  if(tab_check_2.length == 0){
    lb_check_1.setLabel("The bot description is quite complete. This \nwill support the reuse of the measurements.");
    lb_check_2.setLabel("The bot description is quite complete. This \nwill support the reuse of the measurements.");
  }
  else{
    String o = "The bot description is quite complete. To support \n the reuse of the measurements, you can still \nadd the following metadata :";
    for(String s : tab_check_2){
      o = o + s ;
    }
    lb_check_1.setLabel(o);
    lb_check_2.setLabel(o);
  }
}