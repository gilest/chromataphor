class AppDelegate

  def applicationDidFinishLaunching(notification)
    # set the app name to an instance variable for easy access
    @appName = NSBundle.mainBundle.infoDictionary['CFBundleName']
    # create a preferences model object to load and save preferences data
    @preferences =  Preferences.new
    # create a new instance of the boot plist model for reading and writing the boot plist
    @bootPlist = BootPlist.new

    # build the prefs window
    buildPrefsWindow

    # finally, build our status menu itself
    buildStatusMenu
  end

end