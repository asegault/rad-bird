/* GUI panel 1 : first config tab */
GUIController gui_control_1;

IFRadioController rc_type;
IFRadioButton rc_type1, rc_type2;
IFLabel lb_type;
IFLabel com_type;

IFTextField tf_country;
IFLabel lb_country;
IFLabel com_country;

IFTextField tf_city;
IFLabel lb_city;
IFLabel com_city;

IFTextField tf_address;
IFLabel lb_address;
IFLabel com_address;

IFTextField tf_geolat;
IFLabel lb_geolat;

IFTextField tf_geolon;
IFLabel lb_geolon;
IFLabel com_geo;

IFButton bt_check_1;
IFLabel lb_check_1;
String[] tab_check_1;

IFButton bt_next_1;

/**
 * Configures the GUI components of the first panel.
 */
void gui_panel_1_config(){
  gui_control_1 = new GUIController(this);
  
  lb_type = new IFLabel("Measurement type", 20, 85);
  gui_control_1.add(lb_type);
  rc_type = new IFRadioController("rc_type");
  rc_type1 = new IFRadioButton("Indoor", 20, 100, rc_type);
  rc_type1.setSelected();
  rc_type2 = new IFRadioButton("Outdoor", 100, 100, rc_type);
  gui_control_1.add(rc_type1);
  gui_control_1.add(rc_type2);
  
  lb_country = new IFLabel("Country", 20, 135);
  gui_control_1.add(lb_country);
  tf_country = new IFTextField("tf_country", 20, 150, 200);
  gui_control_1.add(tf_country);
  com_country = new IFLabel("", 230, 145);
  gui_control_1.add(com_country);
  
  lb_city = new IFLabel("City", 20, 185);
  gui_control_1.add(lb_city);
  tf_city = new IFTextField("tf_city", 20, 200, 200);
  gui_control_1.add(tf_city);
  com_city = new IFLabel("", 230, 195);
  gui_control_1.add(com_city);
  
  lb_address = new IFLabel("Address", 20, 235);
  gui_control_1.add(lb_address);
  tf_address = new IFTextField("tf_address", 20, 250, 200);
  gui_control_1.add(tf_address);
  com_address = new IFLabel("This will not be displayed \n but used to calculate GPS \ncoordinates. You can also \nset the GPS coordinates \ndirectly.", 230, 245);
  gui_control_1.add(com_address);
  
  lb_geolat = new IFLabel("GPS Latitude", 20, 285);
  gui_control_1.add(lb_geolat);
  tf_geolat = new IFTextField("tf_geolat", 20, 300, 95);
  gui_control_1.add(tf_geolat);
  
  lb_geolon = new IFLabel("GPS Longitude", 125, 285);
  gui_control_1.add(lb_geolon);
  tf_geolon = new IFTextField("tf_geolon", 125, 300, 95);
  gui_control_1.add(tf_geolon);
  com_geo = new IFLabel("", 230, 295);
  gui_control_1.add(com_geo);
  
  bt_check_1 = new IFButton("Check", 100, 350, 200);
  bt_check_1.addActionListener(this);
  gui_control_1.add(bt_check_1);
  lb_check_1 = new IFLabel("", 10, 350);
  gui_control_1.add(lb_check_1);
  
  bt_next_1 = new IFButton("Next", 290, 380, 100);
  bt_next_1.addActionListener(this);
}

/**
 * Displays the first panel and hides the other ones.
 */
void gui_panel_1(){
  current_panel = 1;
  gui_control_tabs.setVisible(true);
  gui_control_conf.setVisible(true);
  bt_tab_1.setLookAndFeel(look_tab_grey);
  bt_tab_2.setLookAndFeel(look_default);
  gui_control_1.setVisible(true);
  gui_control_2.setVisible(false);
  gui_control_3.setVisible(false);
  gui_control_4.setVisible(false);
}

/**
 * Checks user's inputs on the first panel and provides feedbacks accordingly.
 */
void panel_1_check(){
  tab_check_1 = new String[0];
  if(tf_country.getValue().length() == 0){
    tf_country.setLookAndFeel(look_red);
    com_country.setLabel("Please indicate the \nmeasurement country");
    tab_check_1 = append(tab_check_1, "\n- country name");
  }
  else{
    tf_country.setLookAndFeel(look_default);
    com_country.setLabel("");
  }
  if(tf_city.getValue().length() == 0){
    tf_city.setLookAndFeel(look_red);
    com_city.setLabel("Please indicate the \nmeasurement city");
    tab_check_1 = append(tab_check_1, "\n- city name");
  }
  else{
    tf_city.setLookAndFeel(look_default);
    com_city.setLabel("");
  }
  if(tf_geolat.getValue().length() == 0 || tf_geolon.getValue().length() == 0){
    if(tf_address.getValue().length() == 0){
      tf_address.setLookAndFeel(look_red);
      com_address.setLabel("Please indicate the \nmeasurement address \nor GPS coordinates.");    
      tab_check_1 = append(tab_check_1, "\n- address or GPS coordinates");
    }
    else{
      tf_address.setLookAndFeel(look_default);
      com_address.setLabel("");
      try{
        processing.data.JSONObject geo = geocode(tf_address.getValue(), tf_city.getValue(), tf_country.getValue());
        float geolat = geo.getJSONArray("results").getJSONObject(0).getJSONObject("geometry").getJSONObject("location").getFloat("lat");
        float geolon = geo.getJSONArray("results").getJSONObject(0).getJSONObject("geometry").getJSONObject("location").getFloat("lng");
        tf_geolat.setValue(str(geolat));
        tf_geolat.setLookAndFeel(look_yellow);
        tf_geolon.setValue(str(geolon));
        tf_geolon.setLookAndFeel(look_yellow);
        com_geo.setLabel("This was automatically \nset, please verify it");
      }
      catch (Exception e){
        tf_geolat.setLookAndFeel(look_red);
        tf_geolon.setLookAndFeel(look_red);
        com_geo.setLabel("This couldn't be automatically \nset. Please do it manually");
      }
    }
  }
  if(panel_1_checked != true){
    gui_control_1.add(bt_next_1);
  }
  panel_1_checked = true;
  bt_check_1.setLabel("Re-check");
  bt_check_1.setWidth(100);
  bt_check_1.setX(290);
  if(tab_check_1.length == 0){
    lb_check_1.setLabel("The bot description is quite complete. This \nwill support the reuse of the measurements. To \nadd more metadata, please check the Advanced \nconfiguration.");
  }
  else{
    String o = "The bot description is still incomplete, which may \nhinder the reuse of the measurements. You can \nadd the following metadata :";
    for(String s : tab_check_1){
      o = o + s ;
    }
    lb_check_1.setLabel(o);
  }
}

/**
 * Initializes the user location.
 */
void geo_config(){
  try{
    processing.data.JSONObject loc = get_loc2();
    tf_country.setValue(loc.getString("country"));
    tf_country.setLookAndFeel(look_yellow);
    com_country.setLabel("This value was automatically \nset please verify it");
    tf_city.setValue(loc.getString("city"));
    tf_city.setLookAndFeel(look_yellow);
    com_city.setLabel("This value was automatically \nset please verify it");
  }
  catch (Exception e){
    tf_country.setLookAndFeel(look_red);
    com_country.setLabel("This couldn't be automatically \nset. Please do it manually");
    tf_city.setLookAndFeel(look_red);
    com_city.setLabel("This couldn't be automatically \nset. Please do it manually");
  }
}

/**
 * Locate the user's IP through the ip-api service.
 */
processing.data.JSONObject get_loc2() {
  processing.data.JSONObject loc = new processing.data.JSONObject();
  try {
    String loc_api = "http://ip-api.com/json";
    loc = loadJSONObject(loc_api);
  } catch (Exception e) {
    println("Could not fetch location");
  }
  return loc;
}

/**
 * Locate the user postal address through the Google Maps API.
 */
processing.data.JSONObject geocode(String address, String city, String country){
  processing.data.JSONObject geo = new processing.data.JSONObject();
  address = URLEncoder.encode(address + " " + city + " " + country);
  String geocode_api = "https://maps.googleapis.com/maps/api/geocode/json?address=" + address + "&key=" + GOOGLE_KEY;
  try{
    geo = loadJSONObject(geocode_api);
  } catch (Exception e) {
    println("Could not code location");
  }
  return geo;
}